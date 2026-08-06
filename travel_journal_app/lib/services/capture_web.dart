import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pinmap_travel_journal/services/captured_image.dart';

Future<bool> requestCameraPermission() async => true;

Future<CapturedImage?> captureTicketPhoto(BuildContext context) async {
  final picker = ImagePicker();
  final file = await picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 95,
    maxWidth: 2400,
  );
  if (file == null) return null;
  final bytes = await file.readAsBytes();
  return CapturedImage(bytes: bytes, format: file.mimeType ?? 'image/jpeg');
}
