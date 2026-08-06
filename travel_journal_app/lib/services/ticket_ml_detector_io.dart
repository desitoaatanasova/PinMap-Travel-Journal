import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

import 'package:pinmap_travel_journal/services/ticket_image_processor.dart';

/// Uses Google ML Kit text recognition (mobile) to derive a ticket
/// quadrilateral from the union of detected text regions.
Future<TicketCorners?> detectWithMl(Uint8List bytes) async {
  final recognizer = TextRecognizer(script: TextRecognitionScript.latin);
  try {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/mlkit_scan_${DateTime.now().millisecondsSinceEpoch}.jpg');
    await file.writeAsBytes(bytes, flush: true);

    final decoded = img.decodeImage(bytes);
    if (decoded == null) return null;
    final iw = decoded.width;
    final ih = decoded.height;

    final input = InputImage.fromFilePath(file.path);
    final result = await recognizer.processImage(input);

    final blocks = result.blocks;
    if (blocks.isEmpty) return null;

    // Union of all text bounding rects (normalized 0..1).
    var minX = 1.0, minY = 1.0, maxX = 0.0, maxY = 0.0;
    for (final block in blocks) {
      final r = block.boundingBox;
      final x0 = r.left / iw;
      final y0 = r.top / ih;
      final x1 = r.right / iw;
      final y1 = r.bottom / ih;
      minX = x0 < minX ? x0 : minX;
      minY = y0 < minY ? y0 : minY;
      maxX = x1 > maxX ? x1 : maxX;
      maxY = y1 > maxY ? y1 : maxY;
    }
    if (maxX <= minX || maxY <= minY) return null;

    // Expand the text region outward to capture the ticket body.
    final padX = (maxX - minX) * 0.12;
    final padY = (maxY - minY) * 0.12;
    final cMinX = (minX - padX).clamp(0.0, 1.0);
    final cMinY = (minY - padY).clamp(0.0, 1.0);
    final cMaxX = (maxX + padX).clamp(0.0, 1.0);
    final cMaxY = (maxY + padY).clamp(0.0, 1.0);

    final w = iw;
    final h = ih;
    final coverage = (cMaxX - cMinX) * (cMaxY - cMinY);
    final confidence = (0.5 + coverage * 0.5).clamp(0.5, 1.0);

    return TicketCorners(
      tl: Offset(cMinX * w, cMinY * h),
      tr: Offset(cMaxX * w, cMinY * h),
      br: Offset(cMaxX * w, cMaxY * h),
      bl: Offset(cMinX * w, cMaxY * h),
      confidence: confidence.toDouble(),
    );
  } finally {
    recognizer.close();
  }
}
