import 'dart:typed_data';
import 'package:image/image.dart' as img;

Future<Uint8List> compressJpeg(Uint8List bytes, {int quality = 85}) async {
  final decoded = img.decodeImage(bytes);
  if (decoded == null) return bytes;
  return img.encodeJpg(decoded, quality: quality.clamp(1, 100));
}

Future<Uint8List> compressPng(Uint8List bytes) async {
  final decoded = img.decodeImage(bytes);
  if (decoded == null) return bytes;
  return img.encodePng(decoded);
}
