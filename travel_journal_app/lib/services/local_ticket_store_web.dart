import 'dart:typed_data';

Future<String?> saveTicketBytes(
  Uint8List bytes,
  int journalId, {
  required bool original,
}) async {
  return null; // no persistent local file system on web
}

Future<void> deleteTicketsForJournal(int journalId) async {}
