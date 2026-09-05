import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinmap_travel_journal/screens/journal_editor/canvas_element.dart';
import 'package:pinmap_travel_journal/screens/journal_editor/text_edit_overlay.dart';
import 'package:pinmap_travel_journal/services/api_config.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';
import 'package:pinmap_travel_journal/widgets/authenticated_image.dart';

/// Parses a '#RRGGBB' (or '#AARRGGBB') string into a [Color], falling back to
/// the scrapbook paper colour when unset or invalid.
Color journalPageColor(String? hex, {Color fallback = const Color(0xFFFFFEF6)}) {
  if (hex == null || hex.isEmpty) return fallback;
  var value = hex.replaceFirst('#', '');
  if (value.length == 6) value = 'FF$value';
  final parsed = int.tryParse(value, radix: 16);
  if (parsed == null) return fallback;
  return Color(parsed);
}

class _DragState {
  final double startScale;
  final double startRotation;
  _DragState(this.startScale, this.startRotation);
}

/// A single scrapbook page surface: journal title header, background colour,
/// and its elements rendered in z-order with unified gestures
/// (drag / pinch-scale / two-finger rotate / tap-select / double-tap-edit /
/// long-press menu). Off-page elements are culled to keep scrolling smooth.
class EditorPage extends StatefulWidget {
  final EditorPageState page;
  final String journalTitle;
  final String? selectedElementId;
  final String? editingElementId;
  final ValueChanged<String?> onSelect;
  final ValueChanged<EditorElement> onElementChanged;
  final ValueChanged<EditorElement> onElementDoubleTap;
  final ValueChanged<EditorElement> onElementLongPress;

  const EditorPage({
    super.key,
    required this.page,
    required this.journalTitle,
    this.selectedElementId,
    this.editingElementId,
    required this.onSelect,
    required this.onElementChanged,
    required this.onElementDoubleTap,
    required this.onElementLongPress,
  });

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  static const double _textWrapWidth = 280;
  static const double _cullMargin = 200;

  final Map<String, _DragState> _dragState = {};

  Size _baseSize(EditorElement el) {
    switch (el.type) {
      case 'text':
        final tp = TextPainter(
          text: TextSpan(text: el.displayText, style: el.textStyle),
          textDirection: TextDirection.ltr,
          textAlign: el.textAlign,
        )..layout(maxWidth: _textWrapWidth);
        return tp.size;
      case 'sticker':
        final size = el.stickerSize ?? 40;
        return Size(size, size);
      case 'image':
      case 'ticket':
        return Size(el.width ?? 200, el.height ?? 130);
      default:
        return Size(200, 130);
    }
  }

  void _startGesture(EditorElement el) {
    _dragState[el.id] = _DragState(el.scale, el.rotation);
  }

  void _applyGesture(EditorElement el, ScaleUpdateDetails details) {
    el.x += details.focalPointDelta.dx;
    el.y += details.focalPointDelta.dy;
    final start = _dragState[el.id];
    if (start != null) {
      el.scale = (start.startScale * details.scale).clamp(0.2, 4.0);
      el.rotation = start.startRotation + details.rotation * 180 / pi;
    }
    widget.onElementChanged(el);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final pageW = constraints.maxWidth;
      final pageH = constraints.maxHeight;
      // z-order, then insertion order for ties (stable).
      final visible = List<MapEntry<int, EditorElement>>.generate(
        widget.page.elements.length,
        (i) => MapEntry(i, widget.page.elements[i]),
      ).where((entry) {
        final size = _baseSize(entry.value);
        final right = entry.value.x + size.width + _cullMargin;
        final bottom = entry.value.y + size.height + _cullMargin;
        return right >= -_cullMargin &&
            bottom >= -_cullMargin &&
            entry.value.x - _cullMargin <= pageW &&
            entry.value.y - _cullMargin <= pageH;
      }).toList()
        ..sort((a, b) {
          final z = a.value.zIndex.compareTo(b.value.zIndex);
          if (z != 0) return z;
          return a.key.compareTo(b.key);
        });
      final editing = widget.editingElementId == null
          ? null
          : widget.page.elements
              .where((el) => el.id == widget.editingElementId)
              .firstOrNull;

      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => widget.onSelect(null),
        child: Container(
          decoration: BoxDecoration(
            color: journalPageColor(widget.page.backgroundColor),
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            border: Border.all(color: AppTheme.lightGray),
            boxShadow: AppTheme.shadowSm,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            child: Stack(
              children: [
                Positioned(
                  left: AppTheme.space4,
                  top: AppTheme.space3,
                  child: Text(
                    widget.journalTitle,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkBrown.withValues(alpha: 0.7),
                    ),
                  ),
                ),
                for (final entry in visible)
                  if (entry.value.id != widget.editingElementId)
                    _buildElement(entry.value),
                if (editing != null)
                  Positioned(
                    left: editing.x - 10,
                    top: editing.y - 10,
                    child: TextEditOverlay(
                      element: editing,
                      onChanged: (value) {
                        editing.text = value;
                        widget.onElementChanged(editing);
                      },
                      onDone: () => widget.onSelect(null),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildElement(EditorElement el) {
    final size = _baseSize(el);
    final selected = el.id == widget.selectedElementId;
    final content = _buildElementContent(el, size);

    return Positioned(
      left: el.x,
      top: el.y,
      width: size.width,
      height: size.height,
      child: Transform.rotate(
        angle: el.rotation * pi / 180,
        alignment: Alignment.center,
        child: Transform.scale(
          scale: el.scale,
          alignment: Alignment.center,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => widget.onSelect(el.id),
            onDoubleTap: () => widget.onElementDoubleTap(el),
            onLongPress: () => widget.onElementLongPress(el),
            onScaleStart: (_) => _startGesture(el),
            onScaleUpdate: (d) => _applyGesture(el, d),
            child: Container(
              decoration: selected
                  ? BoxDecoration(
                      border: Border.all(color: AppTheme.primary, width: 1.5),
                      borderRadius: BorderRadius.circular(6),
                    )
                  : null,
              child: content,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildElementContent(EditorElement el, Size size) {
    switch (el.type) {
      case 'text':
        return SizedBox(
          width: size.width,
          height: size.height,
          child: Text(
            el.displayText,
            style: el.textStyle,
            textAlign: el.textAlign,
          ),
        );
      case 'image':
      case 'ticket':
        return ClipRRect(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          child: _buildImage(el, size),
        );
      case 'sticker':
        return Center(
          child: Text(
            el.emoji ?? '😊',
            style: TextStyle(fontSize: el.stickerSize ?? 40),
          ),
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildImage(EditorElement el, Size size) {
    final width = size.width;
    final height = size.height;
    if (el.localImageBytes != null) {
      return Image.memory(
        el.localImageBytes!,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stack) => _imageFallback(width, height),
      );
    }
    final url = el.imageUrl;
    if (url == null || url.isEmpty) {
      return _imageFallback(width, height);
    }
    if (url.startsWith('/uploads/')) {
      return AuthenticatedCachedImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(width: width, height: height, color: AppTheme.lightGray),
        errorWidget: (context, url, error) => _imageFallback(width, height),
      );
    }
    return CachedNetworkImage(
      imageUrl: ApiConfig.assetUrl(url),
      width: width,
      height: height,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        color: AppTheme.lightGray,
      ),
      errorWidget: (context, url, error) => _imageFallback(width, height),
    );
  }

  Widget _imageFallback(double w, double h) {
    return Container(
      width: w,
      height: h,
      color: AppTheme.lightGray,
      child: const Icon(Icons.image, size: 40, color: Colors.grey),
    );
  }
}
