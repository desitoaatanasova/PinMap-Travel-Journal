import 'package:flutter/widgets.dart';

import 'captured_image.dart';
import 'capture_io.dart'
    if (dart.library.js_interop) 'capture_web.dart'
    if (dart.library.html) 'capture_web.dart' as impl;

/// Requests camera permission (spec step 3). On web the browser handles this.
Future<bool> requestCameraPermission() => impl.requestCameraPermission();

/// Opens the camera (mobile) or image picker (web) and returns the captured
/// photo bytes, or null if the user cancelled.
Future<CapturedImage?> captureTicketPhoto(BuildContext context) =>
    impl.captureTicketPhoto(context);
