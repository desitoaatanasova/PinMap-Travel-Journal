import 'dart:typed_data';

import 'local_ticket_store_io.dart'
    if (dart.library.js_interop) 'local_ticket_store_web.dart'
    if (dart.library.html) 'local_ticket_store_web.dart' as impl;

class LocalTicketStore {
  /// Saves ticket bytes under {documents}/tickets/{journalId}/ticket_XXX.png
  /// (or _original). Returns the absolute path, or null when the platform has
  /// no persistent file system (web).
  static Future<String?> saveTicketBytes(
    Uint8List bytes,
    int journalId, {
    required bool original,
  }) {
    return impl.saveTicketBytes(bytes, journalId, original: original);
  }
}
