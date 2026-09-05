import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

Future<String?> saveTicketBytes(
  Uint8List bytes,
  int journalId, {
  required bool original,
}) async {
  final root = await getApplicationDocumentsDirectory();
  final folder = Directory('${root.path}/tickets/$journalId');
  await folder.create(recursive: true);

  var n = 1;
  final existing = folder.listSync();
  while (true) {
    final base = 'ticket_${n.toString().padLeft(3, '0')}';
    final conflict = existing.any((e) {
      final name = e.uri.pathSegments.last;
      return name == '$base.png' ||
          name == '$base.jpg' ||
          name == '${base}_original.png' ||
          name == '${base}_original.jpg';
    });
    if (!conflict) break;
    n++;
  }

  final name = 'ticket_${n.toString().padLeft(3, '0')}${original ? '_original' : ''}.png';
  final file = File('${folder.path}/$name');
  await file.writeAsBytes(bytes, flush: true);
  return file.path;
}

Future<void> deleteTicketsForJournal(int journalId) async {
  try {
    final root = await getApplicationDocumentsDirectory();
    final folder = Directory('${root.path}/tickets/$journalId');
    if (await folder.exists()) {
      await folder.delete(recursive: true);
    }
  } catch (_) {}
}
