import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

Future<Uint8List?> readQueuedBytes({String? path, String? base64}) async {
  if (base64 != null && base64.isNotEmpty) {
    try {
      return base64Decode(base64);
    } catch (e) {
      debugPrint('readQueuedBytes base64 decode failed: $e');
      return null;
    }
  }
  return null;
}
