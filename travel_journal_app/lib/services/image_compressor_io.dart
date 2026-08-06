import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<Uint8List> compressJpeg(Uint8List bytes, {int quality = 85}) async {
  final result = await FlutterImageCompress.compressWithList(
    bytes,
    quality: quality.clamp(1, 100),
    format: CompressFormat.jpeg,
  );
  return result;
}

Future<Uint8List> compressPng(Uint8List bytes) async {
  final result = await FlutterImageCompress.compressWithList(
    bytes,
    format: CompressFormat.png,
  );
  return result;
}
