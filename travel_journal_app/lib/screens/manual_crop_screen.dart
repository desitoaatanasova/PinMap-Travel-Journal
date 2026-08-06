import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart' as img;

import 'package:pinmap_travel_journal/services/ticket_image_processor.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

enum ManualCropAction { cropped, cancelled, retake }

class ManualCropResult {
  final ManualCropAction action;
  final Uint8List? bytes;
  final TicketCorners? corners;
  ManualCropResult({required this.action, this.bytes, this.corners});
}

/// Interactive 4-corner crop overlay used when automatic ticket detection
/// fails or is imprecise.
class ManualCropScreen extends StatefulWidget {
  final Uint8List imageBytes;
  final TicketCorners? initialCorners;

  const ManualCropScreen({
    super.key,
    required this.imageBytes,
    this.initialCorners,
  });

  @override
  State<ManualCropScreen> createState() => _ManualCropScreenState();
}

class _ManualCropScreenState extends State<ManualCropScreen> {
  late final int _imgW;
  late final int _imgH;
  late List<Offset> _corners; // widget-space

  @override
  void initState() {
    super.initState();
    final decoded = img.decodeImage(widget.imageBytes);
    _imgW = decoded?.width ?? 1000;
    _imgH = decoded?.height ?? 1000;
    _corners = List.filled(4, Offset.zero);
  }

  Rect _imageRect(Size box) {
    final scale = (box.width / _imgW) < (box.height / _imgH)
        ? box.width / _imgW
        : box.height / _imgH;
    final w = _imgW * scale;
    final h = _imgH * scale;
    final left = (box.width - w) / 2;
    final top = (box.height - h) / 2;
    return Rect.fromLTWH(left, top, w, h);
  }

  void _initCorners(Rect rect) {
    final initial = widget.initialCorners;
    if (initial != null) {
      Offset toWidget(Offset p) => Offset(
            rect.left + (p.dx / _imgW) * rect.width,
            rect.top + (p.dy / _imgH) * rect.height,
          );
      _corners = [toWidget(initial.tl), toWidget(initial.tr), toWidget(initial.br), toWidget(initial.bl)];
    } else {
      _corners = [
        rect.topLeft,
        rect.topRight,
        rect.bottomRight,
        rect.bottomLeft,
      ];
    }
  }

  TicketCorners _toImageCorners(Rect rect) {
    Offset toImage(Offset p) => Offset(
          ((p.dx - rect.left) / rect.width * _imgW).clamp(0, _imgW).toDouble(),
          ((p.dy - rect.top) / rect.height * _imgH).clamp(0, _imgH).toDouble(),
        );
    return TicketCorners(
      tl: toImage(_corners[0]),
      tr: toImage(_corners[1]),
      br: toImage(_corners[2]),
      bl: toImage(_corners[3]),
    );
  }

  void _crop() {
    final corners = _toImageCorners(_lastRect);
    final cropped = TicketImageProcessor.perspectiveWarp(widget.imageBytes, corners);
    Navigator.of(context).pop(ManualCropResult(
      action: ManualCropAction.cropped,
      bytes: cropped,
      corners: corners,
    ));
  }

  Rect _lastRect = Rect.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Adjust ticket corners',
          style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(
              ManualCropResult(action: ManualCropAction.retake),
            ),
            child: Text('Retake', style: GoogleFonts.dmSans(color: Colors.white)),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final rect = _imageRect(constraints.biggest);
          _lastRect = rect;
          if (_corners[0] == Offset.zero &&
              _corners[1] == Offset.zero &&
              _corners[2] == Offset.zero &&
              _corners[3] == Offset.zero) {
            _initCorners(rect);
          }
          return Stack(
            children: [
              Positioned.fill(
                child: Image.memory(widget.imageBytes, fit: BoxFit.contain),
              ),
              Positioned.fill(
                child: CustomPaint(
                  painter: _CropPainter(rect, _corners),
                ),
              ),
              ..._cornerHandles(rect),
              Positioned(
                left: 0,
                right: 0,
                bottom: 32,
                child: Center(
                  child: ElevatedButton.icon(
                    onPressed: _crop,
                    icon: const Icon(Icons.crop),
                    label: const Text('Crop ticket'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _cornerHandles(Rect rect) {
    const names = ['TL', 'TR', 'BR', 'BL'];
    return List.generate(4, (i) {
      return Positioned(
        left: _corners[i].dx - 18,
        top: _corners[i].dy - 18,
        child: GestureDetector(
          key: ValueKey('corner_${names[i]}'),
          behavior: HitTestBehavior.opaque,
          onPanUpdate: (details) {
            setState(() {
              final clamped = Offset(
                (_corners[i].dx + details.delta.dx).clamp(rect.left, rect.right),
                (_corners[i].dy + details.delta.dy).clamp(rect.top, rect.bottom),
              );
              _corners[i] = clamped;
            });
          },
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppTheme.primary,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
        ),
      );
    });
  }
}

class _CropPainter extends CustomPainter {
  final Rect rect;
  final List<Offset> corners;
  _CropPainter(this.rect, this.corners);

  @override
  void paint(Canvas canvas, Size size) {
    final quad = Path()
      ..moveTo(corners[0].dx, corners[0].dy)
      ..lineTo(corners[1].dx, corners[1].dy)
      ..lineTo(corners[2].dx, corners[2].dy)
      ..lineTo(corners[3].dx, corners[3].dy)
      ..close();

    canvas.save();
    canvas.clipPath(quad);
    canvas.drawRect(rect, Paint()..color = Colors.black.withValues(alpha: 0.0));
    canvas.restore();

    // Dim outside the quad.
    final outer = Path()
      ..addRect(rect)
      ..addPath(quad, Offset.zero)
      ..fillType = PathFillType.evenOdd;
    canvas.drawPath(outer, Paint()..color = Colors.black.withValues(alpha: 0.55));

    canvas.drawPath(
      quad,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..color = AppTheme.primary,
    );
  }

  @override
  bool shouldRepaint(_CropPainter oldDelegate) =>
      oldDelegate.corners != corners || oldDelegate.rect != rect;
}
