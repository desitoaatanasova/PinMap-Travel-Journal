import 'package:flutter/foundation.dart';
import 'package:pinmap_travel_journal/models/journal.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';

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
    // reloadJournals is void
  }

  static Journal? getJournalById(int id) {
    try {
      return _journals.firstWhere((j) => j.journalId == id);
    } catch (e) {
      return null;
    }
  }

  /// Persists a journal server-side and updates the local cache with the
  /// server id and fresh page ids. Returns the server result.
  static Future<JournalSaveResult> saveJournal(Journal journal) async {
    final body = journal.toJson();
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
  }

  static Future<void> deleteJournal(int id) async {
    try {
      await ApiClient.delete('/journal/$id');
      _journals.removeWhere((j) => j.journalId == id);
    } catch (e) {
      debugPrint('JournalService.deleteJournal error: $e');
    }
  }

  static List<Journal> getAllJournals() => _journals;

  static void reset() {
    _journals = [];
    _loaded = false;
  }
}
