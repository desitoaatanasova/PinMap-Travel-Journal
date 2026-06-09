import 'package:pinmap_travel_journal/models/journal.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';

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
      _loaded = true;
    }
  }

  static Future<void> reloadJournals() async {
    try {
      final data = await ApiClient.get('/journal');
      _journals = (data as List).map((json) => Journal.fromJson(json)).toList();
    } catch (_) {}
  }

  static List<Journal> getAllJournals() {
    return _journals;
  }

  static Journal? getJournalById(int id) {
    try {
      return _journals.firstWhere((j) => j.journalId == id);
    } catch (e) {
      return null;
    }
  }

  static Future<void> saveJournal(Journal journal) async {
    try {
      final body = journal.toJson();
      final data = await ApiClient.post('/journal/save', body: body);
      final serverId = data['id'] is int ? data['id'] : int.tryParse(data['id'].toString()) ?? 0;
      final index = _journals.indexWhere((j) => j.journalId == journal.journalId);
      if (index >= 0) {
        _journals[index] = journal;
      } else {
        final saved = Journal(
          journalId: serverId,
          title: journal.title,
          countryId: journal.countryId,
          coverImage: journal.coverImage,
          pages: journal.pages,
        );
        _journals.add(saved);
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> deleteJournal(int id) async {
    try {
      await ApiClient.delete('/journal/$id');
      _journals.removeWhere((j) => j.journalId == id);
    } catch (_) {}
  }
}
