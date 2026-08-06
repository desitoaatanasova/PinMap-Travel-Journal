import 'dart:typed_data';

import 'queue_file_io.dart'
    if (dart.library.js_interop) 'queue_file_web.dart'
    if (dart.library.html) 'queue_file_web.dart' as impl;

/// Reads queued ticket image bytes either from a local file path (mobile) or
/// from an embedded base64 payload (web).
Future<Uint8List?> readQueuedBytes({String? path, String? base64}) {
  return impl.readQueuedBytes(path: path, base64: base64);
}
