import 'dart:typed_data';

import 'image_compressor_io.dart'
    if (dart.library.js_interop) 'image_compressor_web.dart'
    if (dart.library.html) 'image_compressor_web.dart' as impl;

class ImageCompressor {
  static Future<Uint8List> compressJpeg(Uint8List bytes, {int quality = 85}) {
    return impl.compressJpeg(bytes, quality: quality);
  }

  static Future<Uint8List> compressPng(Uint8List bytes) {
    return impl.compressPng(bytes);
  }
}
