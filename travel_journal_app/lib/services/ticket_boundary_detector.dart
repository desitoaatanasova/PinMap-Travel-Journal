import 'dart:typed_data';

import 'package:pinmap_travel_journal/services/ticket_image_processor.dart';

import 'ticket_ml_detector_io.dart'
    if (dart.library.js_interop) 'ticket_ml_detector_web.dart'
    if (dart.library.html) 'ticket_ml_detector_web.dart' as impl;

/// Combines on-device ML (mobile: Google ML Kit text detection) with the
/// pure-Dart geometric detector. ML is a hint; the CV detector is the source
/// of truth when its confidence is higher.
class TicketBoundaryDetector {
  static Future<TicketCorners?> detect(Uint8List bytes) async {
    TicketCorners? ml;
    try {
      ml = await impl.detectWithMl(bytes);
    } catch (_) {
      ml = null;
    }
    final cv = TicketImageProcessor.detectCorners(bytes);
    if (ml != null && (cv == null || ml.confidence >= cv.confidence)) {
      return ml;
    }
    return cv;
  }
}
