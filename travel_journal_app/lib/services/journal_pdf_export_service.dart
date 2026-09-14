import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pinmap_travel_journal/models/journal.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';
import 'package:pinmap_travel_journal/services/api_config.dart';

class JournalPdfExportService {
  static const int maxImageDimension = 800;
  static const Duration imageTimeout = Duration(seconds: 10);
  static const double referencePageWidth = 600;

  static String sanitizeFilename(String title) {
    var base = title.trim().replaceAll(RegExp(r'[^A-Za-z0-9\-_]+'), '_');
    base = base.replaceAll(RegExp(r'_+'), '_');
    base = base.replaceAll(RegExp(r'^_+|_+$'), '');
    if (base.length > 60) base = base.substring(0, 60);
    if (base.isEmpty) return 'PinMap_Journal.pdf';
    return 'PinMap_Journal_$base.pdf';
  }

  static Future<Uint8List> buildJournalPdf(
    Journal journal, {
    String? countryName,
    double editorPageWidth = referencePageWidth,
  }) async {
    final imageCache = await _preloadImages(journal);
    final doc = pw.Document();

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
        journal.title.isEmpty ? 'Untitled journal' : journal.title,
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
      if (journal.coverImage != null && journal.coverImage!.isNotEmpty)
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: 8),
          child: _coverImage(imageCache[journal.coverImage]),
        ),
      pw.Divider(color: PdfColors.grey300),
    ];

    final body = <pw.Widget>[];
    if (journal.pages.isEmpty) {
      body.add(
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: 12),
          child: pw.Text(
            'This journal has no pages yet.',
            style: pw.TextStyle(font: pw.Font.helveticaOblique(), fontSize: 11),
          ),
        ),
      );
    } else {
      final pages = List<JournalPage>.from(journal.pages)
        ..sort((a, b) => a.pageNumber.compareTo(b.pageNumber));
      for (final page in pages) {
        body.add(_buildPage(page, imageCache, editorPageWidth));
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

  static pw.Widget _buildPage(
    JournalPage page,
    Map<String, Uint8List?> imageCache,
    double editorPageWidth,
  ) {
    final contentWidth = PdfPageFormat.a4.width - 72;
    final scale = contentWidth / editorPageWidth;
    final elements = List<JournalElement>.from(page.elements)
      ..sort((a, b) => a.zIndex.compareTo(b.zIndex));

    double canvasHeight = 150;
    for (final el in elements) {
      final bottom = (el.yPosition + el.height * el.scale) * scale + 16;
      if (bottom > canvasHeight) canvasHeight = bottom;
    }
    if (canvasHeight > 1600) canvasHeight = 1600;

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 12),
        pw.Text(
          'Page ${page.pageNumber}',
          style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 14),
        ),
        pw.SizedBox(height: 4),
        pw.Container(
          width: contentWidth,
          height: canvasHeight,
          decoration: pw.BoxDecoration(
            color: _parseBackground(page.backgroundColor),
            borderRadius: pw.BorderRadius.circular(8),
            border: pw.Border.all(color: PdfColors.grey300),
          ),
          child: pw.Stack(
            children: [
              for (final el in elements) _buildElement(el, imageCache, scale),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildElement(
    JournalElement el,
    Map<String, Uint8List?> imageCache,
    double scale,
  ) {
    final left = el.xPosition.toDouble() * scale;
    final top = el.yPosition.toDouble() * scale;
    final w = (el.width.toDouble() * scale).clamp(20.0, double.infinity);
    final h = el.height.toDouble() * scale;

    pw.Widget child;
    if (el.elementType == 'text') {
      child = pw.SizedBox(width: w, child: _buildText(el, scale));
    } else if (el.elementType == 'image' || el.elementType == 'ticket') {
      final bytes = el.imageUrl == null ? null : imageCache[el.imageUrl];
      if (bytes == null || bytes.isEmpty) {
        child = pw.Container(width: w, height: h, color: PdfColors.grey300);
      } else {
        child = pw.SizedBox(
          width: w,
          height: h,
          child: pw.ClipRRect(
            horizontalRadius: 6,
            verticalRadius: 6,
            child: pw.Image(
              pw.MemoryImage(bytes),
              fit: pw.BoxFit.cover,
              width: w,
              height: h,
            ),
          ),
        );
      }
    } else if (el.elementType == 'sticker') {
      child = pw.SizedBox(
        width: w,
        height: h,
        child: pw.Center(
          child: pw.Text(
            el.content ?? '',
            style: pw.TextStyle(
              font: pw.Font.helvetica(),
              fontSize: (h * 0.6).clamp(8.0, 72.0),
            ),
          ),
        ),
      );
    } else {
      child = pw.SizedBox();
    }

    return pw.Positioned(
      left: left,
      top: top,
      child: pw.Transform.rotate(
        angle: el.rotation * math.pi / 180,
        child: pw.Transform.scale(scale: el.scale, child: child),
      ),
    );
  }

  static pw.Widget _buildText(JournalElement el, double scale) {
    String text = '';
    double fontSize = 14;
    PdfColor color = PdfColors.black;
    bool bold = false;
    bool italic = false;
    bool underline = false;
    pw.TextAlign align = pw.TextAlign.left;
    try {
      if (el.content != null) {
        final m = jsonDecode(el.content!) as Map<String, dynamic>;
        text = (m['text'] as String?) ?? '';
        fontSize = (m['fontSize'] as num?)?.toDouble() ?? 14;
        final c = m['color'];
        if (c is int) color = _argbToPdfColor(c);
        if (c is String) {
          color = _argbToPdfColor(int.tryParse(c) ?? 0xDD000000);
        }
        bold = m['bold'] == true;
        italic = m['italic'] == true;
        underline = m['underline'] == true;
        final a = m['align'] ?? m['textAlign'];
        if (a == 'center') align = pw.TextAlign.center;
        if (a == 'right') align = pw.TextAlign.right;
        if (a == 'justify') align = pw.TextAlign.justify;
      }
    } catch (_) {
      text = el.content ?? '';
    }
    pw.Font font;
    if (bold && italic) {
      font = pw.Font.helveticaBoldOblique();
    } else if (bold) {
      font = pw.Font.helveticaBold();
    } else if (italic) {
      font = pw.Font.helveticaOblique();
    } else {
      font = pw.Font.helvetica();
    }
    return pw.Text(
      text,
      style: pw.TextStyle(
        font: font,
        fontSize: (fontSize * scale).clamp(6.0, 48.0),
        color: color,
        decoration:
            underline ? pw.TextDecoration.underline : pw.TextDecoration.none,
      ),
      textAlign: align,
    );
  }

  static PdfColor _argbToPdfColor(int argb) {
    final a = ((argb >> 24) & 0xFF) / 255.0;
    final r = ((argb >> 16) & 0xFF) / 255.0;
    final g = ((argb >> 8) & 0xFF) / 255.0;
    final b = (argb & 0xFF) / 255.0;
    return PdfColor(r, g, b, a);
  }

  static PdfColor _parseBackground(String? hex) {
    if (hex == null || hex.isEmpty) return PdfColor(1, 1, 0.965);
    try {
      var v = hex.replaceAll('#', '');
      if (v.length == 6) v = 'FF$v';
      final value = int.parse(v, radix: 16);
      return _argbToPdfColor(value);
    } catch (_) {
      return PdfColor(1, 1, 0.965);
    }
  }

  static pw.Widget _coverImage(Uint8List? bytes) {
    if (bytes == null || bytes.isEmpty) return pw.SizedBox();
    return pw.Container(
      width: double.infinity,
      child: pw.Image(pw.MemoryImage(bytes), fit: pw.BoxFit.cover),
    );
  }

  static Future<Map<String, Uint8List?>> _preloadImages(Journal journal) async {
    final urls = <String>{};
    if (journal.coverImage != null && journal.coverImage!.isNotEmpty) {
      urls.add(journal.coverImage!);
    }
    for (final page in journal.pages) {
      for (final el in page.elements) {
        if ((el.elementType == 'image' || el.elementType == 'ticket') &&
            el.imageUrl != null &&
            el.imageUrl!.isNotEmpty) {
          urls.add(el.imageUrl!);
        }
      }
    }
    final cache = <String, Uint8List?>{};
    for (final url in urls) {
      try {
        cache[url] = await _fetchImageBytes(url);
      } catch (e) {
        debugPrint('JournalPdfExportService image skipped: $e');
        cache[url] = null;
      }
    }
    return cache;
  }

  static Future<Uint8List?> _fetchImageBytes(String imageUrl) async {
    try {
      final url = ApiConfig.assetUrl(imageUrl);
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
      debugPrint('JournalPdfExportService image fetch failed: $e');
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
      debugPrint('JournalPdfExportService downscale failed: $e');
      return null;
    }
  }
}
