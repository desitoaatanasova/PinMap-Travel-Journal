import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pinmap_travel_journal/models/trip.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';
import 'package:pinmap_travel_journal/services/api_config.dart';

class PdfExportService {
  static const int maxImageDimension = 800;
  static const Duration imageTimeout = Duration(seconds: 10);

  static String sanitizeFilename(String tripName) {
    var base = tripName.trim().replaceAll(RegExp(r'[^A-Za-z0-9\-_]+'), '_');
    base = base.replaceAll(RegExp(r'_+'), '_');
    base = base.replaceAll(RegExp(r'^_+|_+$'), '');
    if (base.length > 60) base = base.substring(0, 60);
    if (base.isEmpty) return 'PinMap_Trip.pdf';
    return 'PinMap_$base.pdf';
  }

  static Future<Uint8List> buildTripPdf(
    Trip trip, {
    String? countryName,
    Map<int, String>? cityNames,
    Map<int, String>? categoryNames,
  }) async {
    final imageCache = await _preloadImages(trip);
    final doc = pw.Document();
    final dateLabel = _dateRange(trip);
    final daysLabel = _daysLabel(trip);
    final metaLine = _metaLine(trip);
    final routeLine = _routeLine(trip);
    final participantsLine = _participantsLine(trip);

    final header = <pw.Widget>[
      pw.Text(
        'PinMap — Travel Journal',
        style: pw.TextStyle(
          font: pw.Font.helveticaBold(),
          fontSize: 12,
          color: PdfColors.teal800,
        ),
      ),
      pw.SizedBox(height: 8),
      pw.Text(
        trip.title.isEmpty ? 'Untitled trip' : trip.title,
        style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 22),
      ),
      if (countryName != null && countryName.isNotEmpty)
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: 4),
          child: pw.Text(
            countryName,
            style: pw.TextStyle(font: pw.Font.helvetica(), fontSize: 14),
          ),
        ),
      if (dateLabel.isNotEmpty || daysLabel.isNotEmpty)
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: 6),
          child: pw.Text(
            [dateLabel, daysLabel].where((s) => s.isNotEmpty).join('  •  '),
            style: pw.TextStyle(
              font: pw.Font.helvetica(),
              fontSize: 10,
              color: PdfColors.grey700,
            ),
          ),
        ),
      if (metaLine.isNotEmpty)
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: 2),
          child: pw.Text(
            metaLine,
            style: pw.TextStyle(
              font: pw.Font.helvetica(),
              fontSize: 10,
              color: PdfColors.grey700,
            ),
          ),
        ),
      if (routeLine.isNotEmpty)
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: 2),
          child: pw.Text(
            routeLine,
            style: pw.TextStyle(font: pw.Font.helvetica(), fontSize: 10),
          ),
        ),
      if (participantsLine.isNotEmpty)
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: 2),
          child: pw.Text(
            participantsLine,
            style: pw.TextStyle(
              font: pw.Font.helvetica(),
              fontSize: 10,
              color: PdfColors.grey700,
            ),
          ),
        ),
      pw.Divider(color: PdfColors.grey300),
    ];

    final body = <pw.Widget>[];
    if (trip.itinerary.isEmpty) {
      body.add(
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: 12),
          child: pw.Text(
            'No activities yet — generate or edit your itinerary, then export again.',
            style: pw.TextStyle(
              font: pw.Font.helveticaOblique(),
              fontSize: 11,
            ),
          ),
        ),
      );
    } else {
      for (final day in trip.itinerary) {
        body.add(_buildDay(day, categoryNames, imageCache));
      }
    }

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(36),
        build: (context) => [...header, ...body],
      ),
    );
    return doc.save();
  }

  static pw.Widget _buildDay(
    TripDay day,
    Map<int, String>? categoryNames,
    Map<String, Uint8List?> imageCache,
  ) {
    final slots = <pw.Widget>[];
    slots.addAll(_buildSlot('Morning', day.morning, categoryNames, imageCache));
    slots.addAll(
      _buildSlot('Afternoon', day.afternoon, categoryNames, imageCache),
    );
    slots.addAll(_buildSlot('Evening', day.evening, categoryNames, imageCache));
    if (slots.isEmpty) {
      slots.add(
        pw.Text(
          'No activities planned.',
          style: pw.TextStyle(
            font: pw.Font.helveticaOblique(),
            fontSize: 10,
            color: PdfColors.grey600,
          ),
        ),
      );
    }
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 12),
        pw.Text(
          day.date != null && day.date!.isNotEmpty
              ? 'Day ${day.dayNumber} — ${day.date}'
              : 'Day ${day.dayNumber}',
          style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 14),
        ),
        pw.SizedBox(height: 4),
        ...slots,
      ],
    );
  }

  static List<pw.Widget> _buildSlot(
    String label,
    List<TripActivity> activities,
    Map<int, String>? categoryNames,
    Map<String, Uint8List?> imageCache,
  ) {
    if (activities.isEmpty) return const [];
    final widgets = <pw.Widget>[
      pw.Padding(
        padding: const pw.EdgeInsets.only(top: 6),
        child: pw.Text(
          label,
          style: pw.TextStyle(
            font: pw.Font.helveticaBold(),
            fontSize: 11,
            color: PdfColors.teal900,
          ),
        ),
      ),
    ];
    for (final activity in activities) {
      final bytes = activity.placeImage == null
          ? null
          : imageCache[activity.placeImage];
      final subtitle = _subtitle(activity, categoryNames);
      final row = <pw.Widget>[
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                activity.placeName?.isNotEmpty == true
                    ? activity.placeName!
                    : 'Activity',
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 11,
                ),
              ),
              if (subtitle.isNotEmpty)
                pw.Text(
                  subtitle,
                  style: pw.TextStyle(
                    font: pw.Font.helvetica(),
                    fontSize: 9,
                    color: PdfColors.grey700,
                  ),
                ),
              if (activity.notes.isNotEmpty)
                pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 2),
                  child: pw.Text(
                    activity.notes,
                    style: pw.TextStyle(
                      font: pw.Font.helvetica(),
                      fontSize: 10,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ];
      if (bytes != null && bytes.isNotEmpty) {
        row.add(pw.SizedBox(width: 8));
        row.add(
          pw.Container(
            width: 110,
            child: pw.Image(pw.MemoryImage(bytes), fit: pw.BoxFit.cover),
          ),
        );
      }
      widgets.add(
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 4),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: row,
          ),
        ),
      );
    }
    return widgets;
  }

  static String _subtitle(
    TripActivity activity,
    Map<int, String>? categoryNames,
  ) {
    final parts = <String>[];
    if (activity.cityName?.isNotEmpty == true) parts.add(activity.cityName!);
    final category =
        activity.categoryId != null ? categoryNames?[activity.categoryId] : null;
    if (category != null && category.isNotEmpty) parts.add(category);
    return parts.join('  •  ');
  }

  static String _dateRange(Trip trip) {
    try {
      final start = _shortDate(trip.startDate);
      final end = _shortDate(trip.endDate);
      if (start.isEmpty || end.isEmpty) return '';
      return '$start → $end';
    } catch (_) {
      return '';
    }
  }

  static String _shortDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  static String _daysLabel(Trip trip) {
    final days = trip.numberOfDays ?? trip.itinerary.length;
    if (days <= 0) return '';
    return '$days day${days == 1 ? '' : 's'}';
  }

  static String _metaLine(Trip trip) {
    final parts = <String>[];
    if (trip.tripType.isNotEmpty) parts.add(trip.tripType);
    if (trip.travelStyle.isNotEmpty) parts.add(trip.travelStyle);
    return parts.join('  •  ');
  }

  static String _routeLine(Trip trip) {
    final arrival = trip.arrivalCity?.trim() ?? '';
    final departure = trip.departureCity?.trim() ?? '';
    if (arrival.isEmpty && departure.isEmpty) return '';
    if (arrival.isNotEmpty && departure.isNotEmpty) {
      return '$arrival → $departure';
    }
    return arrival.isNotEmpty ? arrival : departure;
  }

  static String _participantsLine(Trip trip) {
    if (trip.participants.isEmpty) return '';
    final names =
        trip.participants.map((p) => p.displayName.trim()).where((n) => n.isNotEmpty).toList();
    if (names.isEmpty) return '';
    return 'With ${names.join(', ')}';
  }

  static Future<Map<String, Uint8List?>> _preloadImages(Trip trip) async {
    final urls = <String>{};
    for (final day in trip.itinerary) {
      for (final activity in day.allActivities) {
        final image = activity.placeImage;
        if (image != null && image.isNotEmpty) urls.add(image);
      }
    }
    final cache = <String, Uint8List?>{};
    for (final url in urls) {
      try {
        cache[url] = await _fetchImageBytes(url);
      } catch (e) {
        debugPrint('PdfExportService image skipped: $e');
        cache[url] = null;
      }
    }
    return cache;
  }

  static Future<Uint8List?> _fetchImageBytes(String placeImage) async {
    try {
      final url = ApiConfig.assetUrl(placeImage);
      final uri = Uri.tryParse(url);
      if (uri == null) return null;
      final headers = await ApiClient.authHeadersForImage();
      final response = await http
          .get(uri, headers: headers.isEmpty ? null : headers)
          .timeout(imageTimeout);
      if (response.statusCode < 200 || response.statusCode >= 300) return null;
      if (response.bodyBytes.isEmpty) return null;
      return _downscale(response.bodyBytes);
    } catch (e) {
      debugPrint('PdfExportService image fetch failed: $e');
      return null;
    }
  }

  static Uint8List? _downscale(Uint8List bytes) {
    try {
      final decoded = img.decodeImage(bytes);
      if (decoded == null) return bytes.length > 1500000 ? null : bytes;
      if (decoded.width <= maxImageDimension &&
          decoded.height <= maxImageDimension) {
        if (bytes.length > 1500000) {
          return Uint8List.fromList(img.encodeJpg(decoded, quality: 80));
        }
        return bytes;
      }
      final resized = img.copyResize(
        decoded,
        width: decoded.width >= decoded.height ? maxImageDimension : null,
        height: decoded.height > decoded.width ? maxImageDimension : null,
      );
      return Uint8List.fromList(img.encodeJpg(resized, quality: 80));
    } catch (e) {
      debugPrint('PdfExportService downscale failed: $e');
      return null;
    }
  }
}
