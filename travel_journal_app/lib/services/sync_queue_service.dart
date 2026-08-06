import 'dart:convert';
import 'package:pinmap_travel_journal/services/api_client.dart';
import 'package:pinmap_travel_journal/services/queue_file.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SyncActionType {
  addWishlist,
  removeWishlist,
  toggleVisited,
  addTrip,
  deleteTrip,
  saveDraft,
  addTicketScan,
}

class SyncAction {
  final SyncActionType type;
  final Map<String, dynamic> data;
  final DateTime timestamp;

  SyncAction({required this.type, required this.data, required this.timestamp});

  factory SyncAction.fromJson(Map<String, dynamic> json) => SyncAction(
        type: SyncActionType.values.firstWhere((e) => e.name == json['type']),
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
  static const String _storageKey = 'sync_queue';
  static final List<SyncAction> _queue = [];
  static bool _loaded = false;

  static Future<void> loadQueue() async {
    if (_loaded) return;
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);
    if (jsonString != null) {
      try {
        final List<dynamic> decoded = jsonDecode(jsonString);
        _queue.clear();
        _queue.addAll(decoded.map((e) => SyncAction.fromJson(e as Map<String, dynamic>)));
      } catch (e) {
        _queue.clear();
      }
    }
    _loaded = true;
  }

  static Future<void> _saveQueue() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(_queue.map((e) => e.toJson()).toList());
    await prefs.setString(_storageKey, jsonString);
  }

  static Future<void> enqueue(SyncAction action) async {
    _queue.add(action);
    await _saveQueue();
    await processQueue();
  }

  static Future<void> processQueue() async {
    if (_queue.isEmpty) return;
    final processed = <SyncAction>[];
    for (final action in List<SyncAction>.from(_queue)) {
      try {
        await _processAction(action);
        processed.add(action);
      } catch (e) {
        break;
      }
    }
    for (final action in processed) {
      _queue.remove(action);
    }
    await _saveQueue();
  }

  static Future<void> _processAction(SyncAction action) async {
    switch (action.type) {
      case SyncActionType.addWishlist:
        await ApiClient.post('/wishlist', body: action.data);
      case SyncActionType.removeWishlist:
        await ApiClient.delete('/wishlist/${action.data['id']}');
      case SyncActionType.toggleVisited:
        await ApiClient.post('/visited/places/toggle', body: action.data);
      case SyncActionType.addTrip:
        await ApiClient.post('/trips', body: action.data);
      case SyncActionType.deleteTrip:
        await ApiClient.delete('/trips/${action.data['id']}');
      case SyncActionType.saveDraft:
        await ApiClient.post('/journal/save', body: action.data);
      case SyncActionType.addTicketScan:
        await _processTicketScan(action.data);
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
      'elementType': 'ticket',
    }, files: files);
  }

  static int get pendingCount => _queue.length;
  static List<SyncAction> get pendingActions => List.unmodifiable(_queue);
}
