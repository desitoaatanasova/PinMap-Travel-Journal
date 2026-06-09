import '../models/journal.dart';

abstract class JournalRepository {
  Future<List<Journal>> getAllJournals();
  Future<Journal?> getJournalById(int id);
  Future<void> saveJournal(Journal journal);
  Future<void> deleteJournal(int id);
}
