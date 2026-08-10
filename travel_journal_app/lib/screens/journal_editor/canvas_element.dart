import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinmap_travel_journal/models/journal.dart';

/// Builds a [TextStyle] for a scrapbook element from its serializable
/// properties.
TextStyle buildElementTextStyle({
  required String fontFamily,
  required double fontSize,
  required int colorValue,
  required bool bold,
  required bool italic,
  required bool underline,
}) {
  final base = TextStyle(
    fontSize: fontSize,
    color: Color(colorValue),
    fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    fontStyle: italic ? FontStyle.italic : FontStyle.normal,
    decoration: underline ? TextDecoration.underline : TextDecoration.none,
  );
  switch (fontFamily) {
    case 'Playfair Display':
      return GoogleFonts.playfairDisplay(textStyle: base);
    case 'Dancing Script':
      return GoogleFonts.dancingScript(textStyle: base);
    default:
      return GoogleFonts.dmSans(textStyle: base);
  }
}

/// An element on a scrapbook page. Mutable so gesture updates can be applied
/// in place and reflected with a single setState.
class EditorElement {
  final String id;
  final String type; // 'text' | 'image' | 'sticker' | 'ticket'
  final String? elementKey; // stable client id persisted to journal_elements.element_key
  double x;
  double y;
  double scale;
  double rotation;
  int zIndex;

  // text properties
  String? text;
  String fontFamily;
  double fontSize;
  int textColorValue;
  bool bold;
  bool italic;
  bool underline;
  TextAlign textAlign;

  // image / ticket
  String? imageUrl;
  double? width;
  double? height;
  int? ticketId;
  Uint8List? localImageBytes;
  bool uploadPending;

  // sticker
  String? emoji;
  double? stickerSize;

  EditorElement({
    required this.id,
    required this.type,
    this.elementKey,
    this.x = 0,
    this.y = 0,
    this.scale = 1,
    this.rotation = 0,
    this.zIndex = 0,
    this.text,
    this.fontFamily = 'DM Sans',
    this.fontSize = 14,
    this.textColorValue = 0xDD000000,
    this.bold = false,
    this.italic = false,
    this.underline = false,
    this.textAlign = TextAlign.left,
    this.imageUrl,
    this.width,
    this.height,
    this.ticketId,
    this.localImageBytes,
    this.uploadPending = false,
    this.emoji,
    this.stickerSize,
  });

  String get displayText {
    final value = text;
    return (value == null || value.isEmpty) ? 'New text block' : value;
  }

  TextStyle get textStyle => buildElementTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        colorValue: textColorValue,
        bold: bold,
        italic: italic,
        underline: underline,
      );

  /// Text style with the element scale folded into the font size, so pinching
  /// a text box visibly grows the text.
  TextStyle get scaledTextStyle => buildElementTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize * scale,
        colorValue: textColorValue,
        bold: bold,
        italic: italic,
        underline: underline,
      );

  /// A copy with a fresh id and a small offset, used for "duplicate".
  EditorElement copyForDuplicate() {
    return EditorElement(
      id: '${type}_${DateTime.now().microsecondsSinceEpoch}',
      type: type,
      x: x + 24,
      y: y + 24,
      scale: scale,
      rotation: rotation,
      zIndex: zIndex + 1,
      text: text,
      fontFamily: fontFamily,
      fontSize: fontSize,
      textColorValue: textColorValue,
      bold: bold,
      italic: italic,
      underline: underline,
      textAlign: textAlign,
      imageUrl: imageUrl,
      width: width,
      height: height,
      ticketId: ticketId,
      localImageBytes: localImageBytes,
      uploadPending: uploadPending,
      emoji: emoji,
      stickerSize: stickerSize,
    );
  }

  /// A copy with a fresh id but identical geometry, used for "duplicate page".
  EditorElement copyForPage() {
    return EditorElement(
      id: '${type}_${DateTime.now().microsecondsSinceEpoch}',
      type: type,
      x: x,
      y: y,
      scale: scale,
      rotation: rotation,
      zIndex: zIndex,
      text: text,
      fontFamily: fontFamily,
      fontSize: fontSize,
      textColorValue: textColorValue,
      bold: bold,
      italic: italic,
      underline: underline,
      textAlign: textAlign,
      imageUrl: imageUrl,
      width: width,
      height: height,
      ticketId: ticketId,
      localImageBytes: localImageBytes,
      uploadPending: uploadPending,
      emoji: emoji,
      stickerSize: stickerSize,
    );
  }

  JournalElement toJournalElement() {
    String? content;
    switch (type) {
      case 'text':
        content = jsonEncode({
          'text': text ?? '',
          'fontFamily': fontFamily,
          'fontSize': fontSize,
          'color': textColorValue,
          'bold': bold,
          'italic': italic,
          'underline': underline,
          'align': textAlign.name,
        });
      case 'sticker':
        content = emoji;
    }
    final isMedia = type == 'image' || type == 'ticket';
    final isSticker = type == 'sticker';
    return JournalElement(
      elementId: 0,
      elementType: type,
      elementKey: elementKey ?? id,
      content: content,
      imageUrl: isMedia ? imageUrl : null,
      xPosition: x.round(),
      yPosition: y.round(),
      width: (isSticker ? (stickerSize ?? 40) : (width ?? 200)).round(),
      height: (isSticker ? (stickerSize ?? 40) : (height ?? 130)).round(),
      scale: scale,
      rotation: rotation,
      zIndex: zIndex,
    );
  }

  factory EditorElement.fromJournalElement(JournalElement el) {
    final key = el.elementKey;
    final element = EditorElement(
      id: key ?? 'el_${el.elementId}',
      type: el.elementType,
      elementKey: key,
      x: el.xPosition.toDouble(),
      y: el.yPosition.toDouble(),
      scale: el.scale,
      rotation: el.rotation,
      zIndex: el.zIndex,
      imageUrl: el.imageUrl,
      width: el.elementType == 'sticker' ? null : el.width.toDouble(),
      height: el.elementType == 'sticker' ? null : el.height.toDouble(),
      emoji: el.elementType == 'sticker' ? el.content : null,
      stickerSize: el.elementType == 'sticker' ? el.height.toDouble() : null,
    );
    if (el.elementType == 'image' || el.elementType == 'ticket') {
      element.imageUrl = el.imageUrl ?? el.content;
    } else if (el.elementType == 'text') {
      final decoded = _tryDecodeTextJson(el.content);
      if (decoded != null) {
        element.text = decoded['text'] ?? '';
        element.fontFamily = decoded['fontFamily'] ?? 'DM Sans';
        element.fontSize = (decoded['fontSize'] as num?)?.toDouble() ?? 14;
        element.textColorValue = (decoded['color'] as num?)?.toInt() ?? 0xDD000000;
        element.bold = decoded['bold'] ?? false;
        element.italic = decoded['italic'] ?? false;
        element.underline = decoded['underline'] ?? false;
        element.textAlign = TextAlign.values.firstWhere(
          (a) => a.name == decoded['align'],
          orElse: () => TextAlign.left,
        );
      } else {
        element.text = el.content ?? '';
      }
    }
    return element;
  }

  static Map<String, dynamic>? _tryDecodeTextJson(String? content) {
    if (content == null) return null;
    try {
      final value = jsonDecode(content);
      if (value is Map<String, dynamic>) return value;
    } catch (_) {
      // Legacy plain-text element.
    }
    return null;
  }
}

/// The in-memory state for a single scrapbook page.
class EditorPageState {
  int? pageId;
  int pageNumber;
  String? backgroundColor;
  final List<EditorElement> elements;

  EditorPageState({
    this.pageId,
    this.pageNumber = 1,
    this.backgroundColor,
    List<EditorElement>? elements,
  }) : elements = elements ?? [];
}
