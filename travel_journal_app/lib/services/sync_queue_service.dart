import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pinmap_travel_journal/services/connectivity_service.dart';

enum SyncActionType { addWishlist, removeWishlist, toggleVisited, addTrip, deleteTrip, saveDraft }

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
  static final ConnectivityService _connectivity = ConnectivityService();

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
    _tryProcessQueue();
  }

  static Future<void> _tryProcessQueue() async {
    final isOnline = await _connectivity.isCurrentlyOnline;
    if (!isOnline || _queue.isEmpty) return;
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
      case SyncActionType.removeWishlist:
      case SyncActionType.toggleVisited:
      case SyncActionType.addTrip:
      case SyncActionType.deleteTrip:
      case SyncActionType.saveDraft:
        break;
    }
  }

  static int get pendingCount => _queue.length;
  static List<SyncAction> get pendingActions => List.unmodifiable(_queue);
}
