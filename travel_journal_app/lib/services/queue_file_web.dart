import 'dart:convert';
import 'dart:typed_data';

Future<Uint8List?> readQueuedBytes({String? path, String? base64}) async {
  if (base64 != null && base64.isNotEmpty) {
    try {
      return base64Decode(base64);
    } catch (_) {
      return null;
    }
  }
  return null;
}
