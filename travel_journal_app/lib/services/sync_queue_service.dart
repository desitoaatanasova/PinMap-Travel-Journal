import 'dart:async';
import 'dart:convert';
import 'package:pinmap_travel_journal/services/api_client.dart';
import 'package:pinmap_travel_journal/services/queue_file.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SyncActionType {
  addWishlist,
  removeWishlist,
  toggleVisited,
  toggleCityVisited,
  toggleCountryVisited,
  addTrip,
  updateTrip,
  deleteTrip,
  saveDraft,
  addTicketScan,
  saveProfile,
  saveSettings,
  ratePlace,
  rateCountry,
  deletePlaceRating,
  deleteCountryRating,
}

class SyncAction {
  final SyncActionType type;
  final Map<String, dynamic> data;
  final DateTime timestamp;

  SyncAction({required this.type, required this.data, required this.timestamp});

  factory SyncAction.fromJson(Map<String, dynamic> json) => SyncAction(
        type: SyncActionType.values.firstWhere(
          (e) => e.name == json['type'],
          orElse: () => SyncActionType.saveDraft,
        ),
        data: json['data'] as Map<String, dynamic>,
        timestamp: DateTime.parse(json['timestamp'] as String),
      );

  Map<String, dynamic> toJson() => {
        'type': type.name,
        'data': data,
        'timestamp': timestamp.toIso8601String(),
      };
}

class SyncQueueService {
  static final Map<int, List<SyncAction>> _queues = {};
  static int? _activeUserId;
  static bool _loaded = false;

  static String _keyFor(int? userId) => 'sync_queue_${userId ?? -1}';

  /// Activates the queue for [userId] and loads its persisted actions.
  /// Call after a successful login/register and after restoring a session.
  static Future<void> activateUser(int userId) async {
    if (_activeUserId == userId && _loaded) return;
    _activeUserId = userId;
    _queues[userId] = [];
    _loaded = false;
    await loadQueue(userId: userId);
  }

  /// Clears the in-memory queue when the user logs out. Persisted actions
  /// stay in storage so they can be flushed after the user signs back in.
  static Future<void> deactivateUser() async {
    if (_activeUserId != null && _queues[_activeUserId] != null) {
      await _saveQueue();
    }
    _activeUserId = null;
    _loaded = false;
  }

  static Future<void> loadQueue({int? userId}) async {
    final uid = userId ?? _activeUserId;
    _activeUserId = uid;
    if (uid == null) return;
    if (_loaded) return;
    _queues[uid] = [];
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyFor(uid));
    if (jsonString != null) {
      try {
        final List<dynamic> decoded = jsonDecode(jsonString);
        _queues[uid]!.addAll(
          decoded.map((e) => SyncAction.fromJson(e as Map<String, dynamic>)),
        );
      } catch (e) {
        _queues[uid] = [];
      }
    }
    _loaded = true;
  }

  static List<SyncAction> _currentQueue() {
    final uid = _activeUserId;
    if (uid == null) return const [];
    return _queues[uid] ??= [];
  }

  static Future<void> _saveQueue() async {
    final uid = _activeUserId;
    if (uid == null) return;
    final queue = _queues[uid] ?? [];
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(queue.map((e) => e.toJson()).toList());
    await prefs.setString(_keyFor(uid), jsonString);
  }

  static Future<void> enqueue(SyncAction action) async {
    final uid = _activeUserId;
    if (uid == null) return;
    final queue = _queues[uid] ??= [];
    // Coalesce journal draft saves: only the latest draft per journal matters.
    if (action.type == SyncActionType.saveDraft) {
      final journalId = action.data['id'];
      queue.removeWhere(
        (a) => a.type == SyncActionType.saveDraft && a.data['id'] == journalId,
      );
    }
    queue.add(action);
    await _saveQueue();
    // Non-blocking: never block the UI on a network flush.
    unawaited(processQueue());
  }

  static Future<void> processQueue() async {
    final uid = _activeUserId;
    if (uid == null) return;
    final queue = _queues[uid] ??= [];
    if (queue.isEmpty) return;
    final processed = <SyncAction>[];
    for (final action in List<SyncAction>.from(queue)) {
      try {
        await _processAction(action);
        processed.add(action);
      } on StateError {
        // Payload (e.g. ticket image bytes) is gone — drop it silently.
        processed.add(action);
      } catch (e) {
        // Stop on the first failure to preserve ordering; retry later.
        break;
      }
    }
    if (processed.isNotEmpty) {
      for (final action in processed) {
        queue.remove(action);
      }
      await _saveQueue();
    }
  }

  static Future<void> _processAction(SyncAction action) async {
    switch (action.type) {
      case SyncActionType.addWishlist:
        await ApiClient.post('/wishlist', body: action.data);
      case SyncActionType.removeWishlist:
        await ApiClient.delete('/wishlist/${action.data['id']}');
      case SyncActionType.toggleVisited:
        await ApiClient.post('/visited/places/toggle', body: action.data);
      case SyncActionType.toggleCityVisited:
        await ApiClient.post('/visited/cities/toggle', body: action.data);
      case SyncActionType.toggleCountryVisited:
        await ApiClient.post('/visited/countries/toggle', body: action.data);
      case SyncActionType.addTrip:
        await ApiClient.post('/trips', body: action.data);
      case SyncActionType.updateTrip:
        await ApiClient.put('/trips/${action.data['id']}', body: action.data);
      case SyncActionType.deleteTrip:
        await ApiClient.delete('/trips/${action.data['id']}');
      case SyncActionType.saveDraft:
        await ApiClient.post('/journal/save', body: action.data);
      case SyncActionType.addTicketScan:
        await _processTicketScan(action.data);
      case SyncActionType.saveProfile:
        await ApiClient.put('/profile', body: action.data);
      case SyncActionType.saveSettings:
        await ApiClient.put('/settings', body: action.data);
      case SyncActionType.ratePlace:
        await ApiClient.post('/ratings', body: action.data);
      case SyncActionType.rateCountry:
        await ApiClient.post('/ratings', body: action.data);
      case SyncActionType.deletePlaceRating:
        await ApiClient.delete('/ratings/place/${action.data['placeId']}');
      case SyncActionType.deleteCountryRating:
        await ApiClient.delete('/ratings/country/${action.data['countryId']}');
    }
  }

  static Future<void> _processTicketScan(Map<String, dynamic> data) async {
    final original = await readQueuedBytes(
      path: data['localOriginalPath'] as String?,
      base64: data['originalBase64'] as String?,
    );
    final processed = await readQueuedBytes(
      path: data['localProcessedPath'] as String?,
      base64: data['processedBase64'] as String?,
    );
    if (original == null && processed == null) {
      throw StateError('Ticket images are no longer available to sync');
    }
    final files = <MultipartFileSpec>[
      if (original != null)
        MultipartFileSpec(
          field: 'original',
          bytes: original,
          filename: 'original.png',
          contentType: 'image/png',
        ),
      if (processed != null)
        MultipartFileSpec(
          field: 'processed',
          bytes: processed,
          filename: 'processed.png',
          contentType: 'image/png',
        ),
    ];
    await ApiClient.uploadMultipart('/tickets', fields: {
      'journalId': data['journalId'].toString(),
      'journalTitle': (data['journalTitle'] ?? '').toString(),
      'countryId': data['countryId'].toString(),
      'pageId': data['pageId'] == null ? '' : data['pageId'].toString(),
      'backgroundRemoved': (data['backgroundRemoved'] ?? false).toString(),
      'xPosition': data['xPosition'].toString(),
      'yPosition': data['yPosition'].toString(),
      'width': data['width'].toString(),
      'height': data['height'].toString(),
      'scale': (data['scale'] ?? 1).toString(),
      'rotation': (data['rotation'] ?? 0).toString(),
      'zIndex': (data['zIndex'] ?? 0).toString(),
      'elementType': (data['elementType'] ?? 'ticket').toString(),
      'elementKey': (data['elementKey'] ?? '').toString(),
    }, files: files);
  }

  static int get pendingCount => _currentQueue().length;
  static List<SyncAction> get pendingActions =>
      List.unmodifiable(_currentQueue());
}
