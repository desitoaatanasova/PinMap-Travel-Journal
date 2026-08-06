import 'dart:typed_data';

import 'package:pinmap_travel_journal/services/ticket_image_processor.dart';

/// No ML Kit on the web build; the CV detector is used instead.
Future<TicketCorners?> detectWithMl(Uint8List bytes) async => null;
