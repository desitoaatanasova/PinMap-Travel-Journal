import 'package:flutter/foundation.dart';
import 'package:pinmap_travel_journal/models/journal.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';
import 'package:pinmap_travel_journal/services/local_ticket_store.dart';
import 'package:pinmap_travel_journal/services/sync_queue_service.dart';

class JournalSaveResult {
  final int journalId;
  final List<SavedPage> pages;

  const JournalSaveResult({required this.journalId, required this.pages});
}

class SavedPage {
  final int pageId;
  final int pageNumber;

  const SavedPage({required this.pageId, required this.pageNumber});
}

class JournalService {
  static List<Journal> _journals = [];
  static bool _loaded = false;
  static int? _ownerId;
  static final ValueNotifier<int> version = ValueNotifier(0);
  static final Map<int, Journal> _publicCache = {};

  static void _bump() => version.value++;

  static void _ensureOwner() {
    final uid = SyncQueueService.activeUserId;
    if (_ownerId != uid) {
      _journals = [];
      _loaded = false;
      _ownerId = uid;
      _bump();
    }
  }

  static Future<void> loadJournals() async {
    _ensureOwner();
    if (_loaded) return;
    try {
      final data = await ApiClient.get('/journal');
      _ensureOwner();
      _journals = (data as List).map((json) => Journal.fromJson(json)).toList();
      _loaded = true;
      _bump();
    } catch (e) {
      debugPrint('JournalService.loadJournals error: $e');
      _loaded = false;
    }
  }

  static Future<void> reloadJournals() async {
    _ensureOwner();
    try {
      final data = await ApiClient.get('/journal');
      _ensureOwner();
      _journals = (data as List).map((json) => Journal.fromJson(json)).toList();
      _bump();
    } catch (e) {
      debugPrint('JournalService.reloadJournals error: $e');
    }
  }

  static Journal? getJournalById(int id) {
    _ensureOwner();
    try {
      return _journals.firstWhere((j) => j.journalId == id);
    } catch (e) {
      debugPrint('JournalService.getJournalById not found: $e');
      return null;
    }
  }

  static Future<JournalSaveResult> saveJournal(Journal journal) async {
    _ensureOwner();
    final body = journal.toJson();
    try {
      final data = await ApiClient.post('/journal/save', body: body);
      final serverId =
          data['id'] is int
              ? data['id'] as int
              : int.tryParse(data['id'].toString()) ?? journal.journalId;
      final savedPages = <SavedPage>[
        for (final page in (data['pages'] as List?) ?? <dynamic>[])
          SavedPage(
            pageId: (page['pageId'] as num?)?.toInt() ?? 0,
            pageNumber: (page['pageNumber'] as num?)?.toInt() ?? 0,
          ),
      ];
      final saved = Journal(
        journalId: serverId,
        title: journal.title,
        countryId: journal.countryId,
        coverImage: journal.coverImage,
        visibility: journal.visibility,
        pages: journal.pages,
      );
      final index = _journals.indexWhere(
        (j) => j.journalId == journal.journalId,
      );
      if (index >= 0) {
        _journals[index] = saved;
      } else {
        _journals.add(saved);
      }
      _bump();
      return JournalSaveResult(journalId: serverId, pages: savedPages);
    } catch (e) {
      final isRetryable = _isRetryableError(e);
      if (isRetryable) {
        await SyncQueueService.enqueue(
          SyncAction(
            type: SyncActionType.saveDraft,
            data: body,
            timestamp: DateTime.now(),
          ),
        );
        final optimistic = Journal(
          journalId: journal.journalId,
          title: journal.title,
          countryId: journal.countryId,
          coverImage: journal.coverImage,
          visibility: journal.visibility,
          pages: journal.pages,
        );
        final idx = _journals.indexWhere(
          (j) => j.journalId == journal.journalId,
        );
        if (idx >= 0) {
          _journals[idx] = optimistic;
        } else {
          _journals.add(optimistic);
        }
        _bump();
        return JournalSaveResult(journalId: journal.journalId, pages: []);
      }
      rethrow;
    }
  }

  static bool _isRetryableError(Object e) {
    if (e is ApiException) {
      final c = e.statusCode;
      if (c == 401 || c == 403 || c == 400 || c == 404 || c == 422)
        return false;
      return true;
    }
    final s = e.toString().toLowerCase();
    return s.contains('socketexception') ||
        s.contains('timeout') ||
        s.contains('failed host lookup') ||
        s.contains('connection');
  }

  static Future<void> deleteJournal(int id) async {
    _ensureOwner();
    _journals.removeWhere((j) => j.journalId == id);
    _bump();
    try {
      await LocalTicketStore.deleteTicketsForJournal(id);
    } catch (e) {
      debugPrint('JournalService deleteTickets cleanup failed: $e');
    }
    try {
      await ApiClient.delete('/journal/$id');
    } catch (e) {
      if (e is ApiException) {
        final c = e.statusCode;
        if (c >= 200 && c < 300) return;
        if (c == 404 || c == 409) return;
        if (c == 400 || c == 422) {
          await SyncQueueService.enqueue(
            SyncAction(
              type: SyncActionType.deleteJournal,
              data: {'id': id},
              timestamp: DateTime.now(),
            ),
          );
          final q = SyncQueueService.allActions.lastWhere(
            (a) => a.type == SyncActionType.deleteJournal && a.data['id'] == id,
            orElse:
                () => SyncAction(
                  type: SyncActionType.deleteJournal,
                  data: {'id': id},
                  timestamp: DateTime.now(),
                ),
          );
          q.isDeadLetter = true;
          q.lastError = e.toString();
          q.lastAttempt = DateTime.now();
          return;
        }
        if (c == 401 || c == 403 || c == 429 || (c >= 500 && c <= 599)) {
          await SyncQueueService.enqueue(
            SyncAction(
              type: SyncActionType.deleteJournal,
              data: {'id': id},
              timestamp: DateTime.now(),
            ),
          );
          return;
        }
      }
      final s = e.toString().toLowerCase();
      final isNetwork =
          s.contains('socketexception') ||
          s.contains('timeout') ||
          s.contains('failed host lookup') ||
          s.contains('connection');
      if (isNetwork) {
        await SyncQueueService.enqueue(
          SyncAction(
            type: SyncActionType.deleteJournal,
            data: {'id': id},
            timestamp: DateTime.now(),
          ),
        );
        return;
      }
      debugPrint('JournalService.deleteJournal error: $e');
      await SyncQueueService.enqueue(
        SyncAction(
          type: SyncActionType.deleteJournal,
          data: {'id': id},
          timestamp: DateTime.now(),
        ),
      );
    }
  }

  static List<Journal> getAllJournals() {
    _ensureOwner();
    return List.unmodifiable(_journals);
  }

  static Future<String> updateVisibility(int id, String visibility) async {
    _ensureOwner();
    if (visibility != 'public' && visibility != 'private') {
      throw ArgumentError('visibility must be public or private');
    }
    final data = await ApiClient.patch(
      '/journal/$id/visibility',
      body: {'visibility': visibility},
    );
    final newVis = (data['visibility'] as String?) ?? visibility;
    final idx = _journals.indexWhere((j) => j.journalId == id);
    if (idx >= 0) {
      _journals[idx] = _journals[idx].copyWith(visibility: newVis);
      _bump();
    }
    _publicCache.remove(id);
    return newVis;
  }

  static Future<List<Journal>> getPublicJournals(int userId) async {
    final data = await ApiClient.get('/users/$userId/journals');
    final list =
        (data as List)
            .map((e) => Journal.fromJson(e as Map<String, dynamic>))
            .toList();
    for (final j in list) {
      _publicCache[j.journalId] = j;
    }
    return list;
  }

  static Future<Journal> getPublicJournal(int id) async {
    if (_publicCache.containsKey(id) && _publicCache[id]!.pages.isNotEmpty) {
      return _publicCache[id]!;
    }
    final data = await ApiClient.get('/journal/$id/public');
    final journal = Journal.fromJson(data as Map<String, dynamic>);
    _publicCache[id] = journal;
    return journal;
  }

  static void reset() {
    _journals = [];
    _loaded = false;
    _ownerId = null;
    _publicCache.clear();
    _bump();
  }
}
