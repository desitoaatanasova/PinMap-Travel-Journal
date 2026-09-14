import 'dart:typed_data';

import 'pdf_download_io.dart'
    if (dart.library.js_interop) 'pdf_download_web.dart'
    if (dart.library.html) 'pdf_download_web.dart' as impl;

Future<void> savePdfBytes(Uint8List bytes, String filename) {
  return impl.savePdfBytes(bytes, filename);
}
