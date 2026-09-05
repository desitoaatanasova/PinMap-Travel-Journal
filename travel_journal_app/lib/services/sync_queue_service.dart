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
  int retryCount;
  DateTime? lastAttempt;
  String? lastError;
  bool isDeadLetter;

  SyncAction({
    required this.type,
    required this.data,
    required this.timestamp,
    this.retryCount = 0,
    this.lastAttempt,
    this.lastError,
    this.isDeadLetter = false,
  });

  factory SyncAction.fromJson(Map<String, dynamic> json) => SyncAction(
        type: SyncActionType.values.firstWhere(
          (e) => e.name == json['type'],
          orElse: () => SyncActionType.saveDraft,
        ),
        data: json['data'] as Map<String, dynamic>,
        timestamp: DateTime.parse(json['timestamp'] as String),
        retryCount: (json['retryCount'] as num?)?.toInt() ?? 0,
        lastAttempt: json['lastAttempt'] != null ? DateTime.tryParse(json['lastAttempt'] as String) : null,
        lastError: json['lastError'] as String?,
        isDeadLetter: json['isDeadLetter'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'type': type.name,
        'data': data,
        'timestamp': timestamp.toIso8601String(),
        'retryCount': retryCount,
        'lastAttempt': lastAttempt?.toIso8601String(),
        'lastError': lastError,
        'isDeadLetter': isDeadLetter,
      };
}

class SyncQueueService {
  static final Map<int, List<SyncAction>> _queues = {};
  static int? _activeUserId;
  static bool _loaded = false;
  static bool _authPaused = false;
  static String? _authError;

  static String _keyFor(int? userId) => 'sync_queue_${userId ?? -1}';

  static bool get isAuthPaused => _authPaused;
  static String? get authError => _authError;
  static int? get activeUserId => _activeUserId;

  static void clearAuthPause() {
    _authPaused = false;
    _authError = null;
  }

  static Future<void> activateUser(int userId) async {
    if (_activeUserId == userId && _loaded) return;
    _activeUserId = userId;
    _queues[userId] = [];
    _loaded = false;
    _authPaused = false;
    _authError = null;
    await loadQueue(userId: userId);
  }

  static Future<void> deactivateUser() async {
    if (_activeUserId != null && _queues[_activeUserId] != null) {
      await _saveQueue();
    }
    _activeUserId = null;
    _loaded = false;
    _authPaused = false;
    _authError = null;
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

  static List<SyncAction> _activeQueue() {
    return _currentQueue().where((a) => !a.isDeadLetter).toList();
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
    if (action.type == SyncActionType.saveDraft) {
      final journalId = action.data['id'];
      queue.removeWhere(
        (a) => a.type == SyncActionType.saveDraft && a.data['id'] == journalId,
      );
    }
    if (action.type == SyncActionType.toggleVisited) {
      final id = action.data['placeId'];
      queue.removeWhere((a) => a.type == SyncActionType.toggleVisited && a.data['placeId'] == id);
    }
    if (action.type == SyncActionType.toggleCityVisited) {
      final id = action.data['cityId'];
      queue.removeWhere((a) => a.type == SyncActionType.toggleCityVisited && a.data['cityId'] == id);
    }
    if (action.type == SyncActionType.toggleCountryVisited) {
      final id = action.data['countryId'];
      queue.removeWhere((a) => a.type == SyncActionType.toggleCountryVisited && a.data['countryId'] == id);
    }
    queue.add(action);
    await _saveQueue();
    unawaited(processQueue());
  }

  static bool _isNetworkError(Object e) {
    final s = e.toString().toLowerCase();
    return s.contains('socketexception') || s.contains('timeoutexception') || s.contains('failed host lookup') || s.contains('connection');
  }

  static String _classifyFailure(Object e) {
    if (e is ApiException) {
      final c = e.statusCode;
      if (c == 401 || c == 403) return 'auth';
      if (c == 400 || c == 404 || c == 422) return 'dead';
      if (c == 409) return 'conflict';
      if (c == 429 || (c >= 500 && c <= 599)) return 'retry';
      return 'retry';
    }
    if (_isNetworkError(e)) return 'retry';
    return 'retry';
  }

  static Future<void> processQueue() async {
    final uid = _activeUserId;
    if (uid == null) return;
    if (_authPaused) return;
    final queue = _queues[uid] ??= [];
    if (queue.isEmpty) return;
    final active = _activeQueue();
    if (active.isEmpty) return;
    final processed = <SyncAction>[];
    for (final action in List<SyncAction>.from(active)) {
      try {
        await _processAction(action);
        processed.add(action);
      } on StateError catch (e) {
        action.isDeadLetter = true;
        action.lastError = e.message;
        action.lastAttempt = DateTime.now();
        await _saveQueue();
        continue;
      } catch (e) {
        final cls = _classifyFailure(e);
        if (cls == 'auth') {
          _authPaused = true;
          _authError = e.toString();
          action.lastError = e.toString();
          action.lastAttempt = DateTime.now();
          await _saveQueue();
          break;
        }
        if (cls == 'dead') {
          action.isDeadLetter = true;
          action.lastError = e.toString();
          action.lastAttempt = DateTime.now();
          await _saveQueue();
          continue;
        }
        if (cls == 'conflict') {
          processed.add(action);
          continue;
        }
        action.retryCount += 1;
        action.lastError = e.toString();
        action.lastAttempt = DateTime.now();
        await _saveQueue();
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

  static int get pendingCount => _activeQueue().length;
  static List<SyncAction> get pendingActions => List.unmodifiable(_activeQueue());
  static List<SyncAction> get deadLetters => List.unmodifiable(_currentQueue().where((a) => a.isDeadLetter));
  static List<SyncAction> get allActions => List.unmodifiable(_currentQueue());
}
