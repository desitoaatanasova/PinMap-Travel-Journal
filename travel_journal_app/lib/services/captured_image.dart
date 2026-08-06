import 'dart:typed_data';

class CapturedImage {
  final Uint8List bytes;
  final String format; // mime type e.g. image/jpeg

  const CapturedImage({required this.bytes, required this.format});
}
