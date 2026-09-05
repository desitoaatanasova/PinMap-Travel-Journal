import 'package:flutter/foundation.dart';
import 'package:pinmap_travel_journal/models/journal.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';
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

  static Future<void> loadJournals() async {
    if (_loaded) return;
    try {
      final data = await ApiClient.get('/journal');
      _journals = (data as List).map((json) => Journal.fromJson(json)).toList();
      _loaded = true;
    } catch (e) {
      debugPrint('JournalService.loadJournals error: $e');
      _loaded = false;
    }
  }

  static Future<void> reloadJournals() async {
    try {
      final data = await ApiClient.get('/journal');
      _journals = (data as List).map((json) => Journal.fromJson(json)).toList();
    } catch (e) {
      debugPrint('JournalService.reloadJournals error: $e');
    }
  }

  static Journal? getJournalById(int id) {
    try {
      return _journals.firstWhere((j) => j.journalId == id);
    } catch (e) {
      return null;
    }
  }

  static Future<JournalSaveResult> saveJournal(Journal journal) async {
    final body = journal.toJson();
    try {
      final data = await ApiClient.post('/journal/save', body: body);
      final serverId = data['id'] is int
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
        pages: journal.pages,
      );
      final index = _journals.indexWhere((j) => j.journalId == journal.journalId);
      if (index >= 0) {
        _journals[index] = saved;
      } else {
        _journals.add(saved);
      }
      return JournalSaveResult(journalId: serverId, pages: savedPages);
    } catch (e) {
      final isRetryable = _isRetryableError(e);
      if (isRetryable) {
        await SyncQueueService.enqueue(SyncAction(
          type: SyncActionType.saveDraft,
          data: body,
          timestamp: DateTime.now(),
        ));
        final optimistic = Journal(
          journalId: journal.journalId,
          title: journal.title,
          countryId: journal.countryId,
          coverImage: journal.coverImage,
          pages: journal.pages,
        );
        final idx = _journals.indexWhere((j) => j.journalId == journal.journalId);
        if (idx >= 0) {
          _journals[idx] = optimistic;
        } else {
          _journals.add(optimistic);
        }
        return JournalSaveResult(journalId: journal.journalId, pages: []);
      }
      rethrow;
    }
  }

  static bool _isRetryableError(Object e) {
    if (e is ApiException) {
      final c = e.statusCode;
      if (c == 401 || c == 403 || c == 400 || c == 404 || c == 422) return false;
      return true;
    }
    final s = e.toString().toLowerCase();
    return s.contains('socketexception') || s.contains('timeout') || s.contains('failed host lookup') || s.contains('connection');
  }

  static Future<void> deleteJournal(int id) async {
    _journals.removeWhere((j) => j.journalId == id);
    try {
      await ApiClient.delete('/journal/$id');
    } catch (e) {
      if (e is ApiException) {
        final c = e.statusCode;
        if (c >= 200 && c < 300) return;
        if (c == 404 || c == 409) return;
        if (c == 400 || c == 422) {
          await SyncQueueService.enqueue(SyncAction(
            type: SyncActionType.deleteJournal,
            data: {'id': id},
            timestamp: DateTime.now(),
          ));
          final q = SyncQueueService.allActions.lastWhere((a) => a.type == SyncActionType.deleteJournal && a.data['id'] == id, orElse: () => SyncAction(type: SyncActionType.deleteJournal, data: {'id': id}, timestamp: DateTime.now()));
          q.isDeadLetter = true;
          q.lastError = e.toString();
          q.lastAttempt = DateTime.now();
          return;
        }
        if (c == 401 || c == 403 || c == 429 || (c >= 500 && c <= 599)) {
          await SyncQueueService.enqueue(SyncAction(
            type: SyncActionType.deleteJournal,
            data: {'id': id},
            timestamp: DateTime.now(),
          ));
          return;
        }
      }
      final s = e.toString().toLowerCase();
      final isNetwork = s.contains('socketexception') || s.contains('timeout') || s.contains('failed host lookup') || s.contains('connection');
      if (isNetwork) {
        await SyncQueueService.enqueue(SyncAction(
          type: SyncActionType.deleteJournal,
          data: {'id': id},
          timestamp: DateTime.now(),
        ));
        return;
      }
      debugPrint('JournalService.deleteJournal error: $e');
      await SyncQueueService.enqueue(SyncAction(
        type: SyncActionType.deleteJournal,
        data: {'id': id},
        timestamp: DateTime.now(),
      ));
    }
  }

  static List<Journal> getAllJournals() => _journals;

  static void reset() {
    _journals = [];
    _loaded = false;
  }
}
