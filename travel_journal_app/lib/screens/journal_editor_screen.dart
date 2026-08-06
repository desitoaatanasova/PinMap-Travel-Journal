import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinmap_travel_journal/models/journal.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';
import 'package:pinmap_travel_journal/services/api_config.dart';
import 'package:pinmap_travel_journal/services/journal_service.dart';
import 'package:pinmap_travel_journal/services/country_service.dart';
import 'package:pinmap_travel_journal/services/sync_queue_service.dart';
import 'package:pinmap_travel_journal/services/ticket_scan_service.dart';
import 'package:pinmap_travel_journal/screens/manual_crop_screen.dart';
import 'package:pinmap_travel_journal/screens/ticket_preview_screen.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class CanvasElement {
  final String id;
  final String type;
  double x;
  double y;
  String? text;
  TextStyle? textStyle;
  String? imageUrl;
  double? width;
  double? height;
  String? emoji;
  double? stickerSize;
  String? ticketInfo;
  double? scale;
  double? rotation;
  int? ticketId;
  Uint8List? localImageBytes;

  CanvasElement({
    required this.id,
    required this.type,
    this.x = 0,
    this.y = 0,
    this.text,
    this.textStyle,
    this.imageUrl,
    this.width,
    this.height,
    this.emoji,
    this.stickerSize,
    this.ticketInfo,
    this.scale,
    this.rotation,
    this.ticketId,
    this.localImageBytes,
  });
}

class JournalEditorScreen extends StatefulWidget {
  final String? chapterId;
  final String? countryName;

  const JournalEditorScreen({super.key, this.chapterId, this.countryName});

  @override
  State<JournalEditorScreen> createState() => _JournalEditorScreenState();
}

class _JournalEditorScreenState extends State<JournalEditorScreen> {
  late TextEditingController _textController;
  Journal? _journal;
  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderline = false;
  Color _textColor = Colors.black87;
  String _currentFont = 'DM Sans';
  double _fontSize = 14;
  final List<CanvasElement> _canvasElements = [];
  String? _selectedElementId;
  final List<String> _availableFonts = const [
    'DM Sans',
    'Playfair Display',
    'Dancing Script',
  ];
  final List<double> _availableFontSizes = const [10, 12, 14, 16, 18, 20, 24, 28, 32];

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    if (widget.chapterId != null) {
      final id = int.tryParse(widget.chapterId!) ?? 0;
      _journal = JournalService.getJournalById(id);
    } else if (widget.countryName != null) {
      final countryId = CountryService.countryIdByName(widget.countryName!);
      _journal = Journal(
        journalId: DateTime.now().millisecondsSinceEpoch,
        title: widget.countryName!,
        countryId: countryId,
      );
    }
    _loadElementsFromJournal();
  }

  void _loadElementsFromJournal() {
    if (_journal == null) return;
    for (final page in _journal!.pages) {
      for (final el in page.elements) {
        switch (el.elementType) {
          case 'text':
            _canvasElements.add(CanvasElement(
              id: 'el_${el.elementId}',
              type: 'text',
              x: el.xPosition.toDouble(),
              y: el.yPosition.toDouble(),
              text: el.content,
            ));
          case 'sticker':
            _canvasElements.add(CanvasElement(
              id: 'el_${el.elementId}',
              type: 'sticker',
              x: el.xPosition.toDouble(),
              y: el.yPosition.toDouble(),
              emoji: el.content,
              stickerSize: el.height.toDouble(),
              scale: el.scale,
              rotation: el.rotation,
            ));
          case 'ticket':
          case 'image':
            _canvasElements.add(CanvasElement(
              id: 'el_${el.elementId}',
              type: el.elementType,
              x: el.xPosition.toDouble(),
              y: el.yPosition.toDouble(),
              width: el.width.toDouble(),
              height: el.height.toDouble(),
              imageUrl: el.content,
              scale: el.scale,
              rotation: el.rotation,
            ));
        }
      }
    }
  }

  /// Builds a [Journal] that persists the current canvas state.
  Journal _buildJournalWithElements() {
    final elements = _canvasElements.map((e) {
      String? content;
      switch (e.type) {
        case 'text':
          content = e.text;
        case 'sticker':
          content = e.emoji;
        case 'ticket':
        case 'image':
          content = e.imageUrl;
      }
      return JournalElement(
        elementId: 0,
        elementType: e.type,
        content: content,
        xPosition: e.x.round(),
        yPosition: e.y.round(),
        width: (e.width ?? 200).round(),
        height: (e.height ?? 130).round(),
        scale: e.scale ?? 1,
        rotation: e.rotation ?? 0,
      );
    }).toList();
    final page = JournalPage(pageId: 0, pageNumber: 1, elements: elements);
    return Journal(
      journalId: _journal!.journalId,
      title: _journal!.title,
      countryId: _journal!.countryId,
      coverImage: _journal!.coverImage,
      pages: [page],
    );
  }

  /// Saves the canvas to the server. When offline the journal draft is queued
  /// and the local (client) id is returned so the ticket stays attached to it.
  Future<int> _persistJournal() async {
    final journal = _buildJournalWithElements();
    try {
      final serverId = await JournalService.saveJournal(journal);
      if (_journal!.journalId != serverId) {
        _journal = Journal(
          journalId: serverId,
          title: journal.title,
          countryId: journal.countryId,
          coverImage: journal.coverImage,
          pages: journal.pages,
        );
      }
      return serverId;
    } catch (e) {
      await SyncQueueService.enqueue(SyncAction(
        type: SyncActionType.saveDraft,
        data: journal.toJson(),
        timestamp: DateTime.now(),
      ));
      return journal.journalId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF6),
      extendBody: true,
      appBar: AppBar(
        title: Text(
          _journal?.title ?? 'New Journal',
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkBrown,
          ),
        ),
        backgroundColor: const Color(0xFFFFFEF6),
        elevation: 0,
        actions: [
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () async {
                  if (_journal != null) {
                    try {
                      await _persistJournal();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Draft saved!',
                              style: GoogleFonts.dmSans(),
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Could not save draft: $e',
                              style: GoogleFonts.dmSans(),
                            ),
                          ),
                        );
                      }
                    }
                  }
                },
              ),
        ],
      ),
      body: Column(
        children: [
          _buildFormatToolbar(),
          Expanded(
            child: _buildScrapbookCanvas(),
          ),
          _buildSelectionToolbar(),
          _buildBottomToolPanel(),
        ],
      ),
    );
  }

  Widget _buildFormatToolbar() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.space2),
      decoration: BoxDecoration(
        color: AppTheme.card,
        boxShadow: AppTheme.shadowSm,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildToolbarButton(
              icon: Icons.format_bold,
              isActive: _isBold,
              onTap: () => setState(() => _isBold = !_isBold),
            ),
            _buildToolbarButton(
              icon: Icons.format_italic,
              isActive: _isItalic,
              onTap: () => setState(() => _isItalic = !_isItalic),
            ),
            _buildToolbarButton(
              icon: Icons.format_underline,
              isActive: _isUnderline,
              onTap: () => setState(() => _isUnderline = !_isUnderline),
            ),
            _buildToolbarButton(
              icon: Icons.color_lens,
              isActive: false,
              onTap: _showColorPicker,
            ),
            _buildToolbarButton(
              icon: Icons.font_download,
              isActive: false,
              onTap: _showFontPicker,
            ),
            const SizedBox(width: AppTheme.space2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.warmGray.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              ),
              child: DropdownButton<double>(
                value: _fontSize,
                underline: const SizedBox(),
                isDense: true,
                items: _availableFontSizes.map((size) {
                  return DropdownMenuItem<double>(
                    value: size,
                    child: Text(
                      '${size.toInt()}',
                      style: GoogleFonts.dmSans(fontSize: 12),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _fontSize = value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolbarButton({
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppTheme.space2),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isActive ? AppTheme.primary : AppTheme.warmGray,
        ),
      ),
    );
  }

  void _showColorPicker() {
    final colors = [
      Colors.black87,
      Colors.red,
      Colors.blue,
      Colors.green,
      AppTheme.primary,
      Colors.purple,
      Colors.orange,
    ];
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppTheme.space4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Text Color',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppTheme.space4),
            Wrap(
              spacing: AppTheme.space3,
              children: colors.map((color) {
                return GestureDetector(
                  onTap: () {
                    setState(() => _textColor = color);
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _textColor == color
                            ? AppTheme.darkBrown
                            : Colors.transparent,
                        width: 3,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _showFontPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppTheme.space4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Font Family',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppTheme.space4),
            ..._availableFonts.map((font) {
              return ListTile(
                title: Text(
                  font,
                  style: _getFontStyle(font, fontSize: 16),
                ),
                trailing: _currentFont == font
                    ? Icon(Icons.check, color: AppTheme.primary)
                    : null,
                onTap: () {
                  setState(() => _currentFont = font);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  TextStyle _getFontStyle(String font, {double fontSize = 14}) {
    switch (font) {
      case 'Playfair Display':
        return GoogleFonts.playfairDisplay(
          fontSize: fontSize,
          fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
          fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
          decoration: _isUnderline ? TextDecoration.underline : TextDecoration.none,
          color: _textColor,
        );
      case 'Dancing Script':
        return GoogleFonts.dancingScript(
          fontSize: fontSize,
          fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
          fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
          decoration: _isUnderline ? TextDecoration.underline : TextDecoration.none,
          color: _textColor,
        );
      default:
        return GoogleFonts.dmSans(
          fontSize: fontSize,
          fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
          fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
          decoration: _isUnderline ? TextDecoration.underline : TextDecoration.none,
          color: _textColor,
        );
    }
  }

  Widget _buildScrapbookCanvas() {
    return GestureDetector(
      onTap: () => setState(() => _selectedElementId = null),
      child: Container(
        color: const Color(0xFFFFFEF6),
        child: Stack(
          children: [
            if (_journal != null)
              Positioned(
                left: 16,
                top: 16,
                child: Container(
                  padding: const EdgeInsets.all(AppTheme.space4),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                    border: Border.all(
                      color: AppTheme.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _journal!.title,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkBrown,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ..._canvasElements.map((element) => _buildCanvasElement(element)),
          ],
        ),
      ),
    );
  }

  Widget _buildCanvasElement(CanvasElement element) {
    final rotation = element.rotation ?? 0;
    Widget content = _buildElementContent(element);
    if (rotation != 0) {
      content = Transform.rotate(
        angle: rotation * pi / 180,
        child: content,
      );
    }
    return Positioned(
      left: element.x,
      top: element.y,
      child: GestureDetector(
        onTap: () => setState(() => _selectedElementId = element.id),
        onPanUpdate: (details) {
          setState(() {
            element.x += details.delta.dx;
            element.y += details.delta.dy;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: _selectedElementId == element.id
                ? Border.all(color: AppTheme.primary, width: 2)
                : null,
          ),
          child: content,
        ),
      ),
    );
  }

  Widget _buildElementContent(CanvasElement element) {
    final scale = element.scale ?? 1;
    switch (element.type) {
      case 'text':
        return Container(
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(maxWidth: 300),
          child: Text(
            element.text ?? 'New text block',
            style: element.textStyle ??
                _getFontStyle(_currentFont, fontSize: _fontSize),
          ),
        );
      case 'image':
      case 'ticket':
        final w = (element.width ?? 200) * scale;
        final h = (element.height ?? 130) * scale;
        return ClipRRect(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          child: _buildImageElement(element, w, h),
        );
      case 'sticker':
        return Text(
          element.emoji ?? '😊',
          style: TextStyle(fontSize: (element.stickerSize ?? 40) * scale),
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildImageElement(CanvasElement element, double w, double h) {
    if (element.localImageBytes != null) {
      return Image.memory(
        element.localImageBytes!,
        width: w,
        height: h,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stack) => _imageFallback(w, h),
      );
    }
    return CachedNetworkImage(
      imageUrl: element.imageUrl != null && element.imageUrl!.isNotEmpty
          ? ApiConfig.assetUrl(element.imageUrl!)
          : 'https://picsum.photos/200/130?random=${element.id}',
      width: w,
      height: h,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        width: w,
        height: h,
        color: AppTheme.lightGray,
        child: const Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => _imageFallback(w, h),
    );
  }

  Widget _imageFallback(double w, double h) {
    return Container(
      width: w,
      height: h,
      color: AppTheme.lightGray,
      child: const Icon(Icons.image, size: 50, color: Colors.grey),
    );
  }

  void _addTextBlock() {
    final textStyle = _getFontStyle(_currentFont, fontSize: _fontSize);
    setState(() {
      _canvasElements.add(CanvasElement(
        id: 'text_${DateTime.now().millisecondsSinceEpoch}',
        type: 'text',
        x: 50 + _canvasElements.length * 20,
        y: 100 + _canvasElements.length * 30,
        text: 'New text block',
        textStyle: textStyle,
      ));
    });
  }

  void _addImage() {
    setState(() {
      _canvasElements.add(CanvasElement(
        id: 'image_${DateTime.now().millisecondsSinceEpoch}',
        type: 'image',
        x: 50 + _canvasElements.length * 20,
        y: 100 + _canvasElements.length * 30,
        width: 200,
        height: 200,
        imageUrl: 'https://picsum.photos/200/200?random=${DateTime.now().millisecondsSinceEpoch}',
      ));
    });
  }

  Future<void> _scanTicket() async {
    try {
      final captured = await TicketScanService.capture(context);
      if (captured == null) return;
      final originalBytes = captured.bytes;

      final corners = await TicketScanService.detect(originalBytes);
      Uint8List? cropped = corners != null
          ? await TicketScanService.crop(originalBytes, corners)
          : null;

      if (cropped == null) {
        if (!mounted) return;
        final manual = await Navigator.of(context).push<ManualCropResult>(
          MaterialPageRoute(
            builder: (_) => ManualCropScreen(
              imageBytes: originalBytes,
              initialCorners: corners,
            ),
          ),
        );
        if (manual == null || manual.action == ManualCropAction.cancelled) return;
        if (manual.action == ManualCropAction.retake) {
          _scanTicket();
          return;
        }
        cropped = manual.bytes;
      }
      if (cropped == null) return;

      if (!mounted) return;
      final preview = await Navigator.of(context).push<TicketPreviewResult>(
        MaterialPageRoute(
          builder: (_) => TicketPreviewScreen(
            originalBytes: originalBytes,
            croppedBytes: cropped!,
            onSave: (processed, backgroundRemoved) => _saveTicket(
              originalBytes,
              processed,
              backgroundRemoved,
            ),
          ),
        ),
      );
      if (preview == null) return;
      if (preview.action == TicketPreviewAction.retake) {
        _scanTicket();
        return;
      }
      if (preview.action == TicketPreviewAction.saved &&
          preview.saveResult != null &&
          preview.processedBytes != null) {
        final result = preview.saveResult!;
        _addTicketElement(result, preview.processedBytes!);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                result.queuedOffline
                    ? 'Ticket saved on this device. Will sync when online.'
                    : 'Ticket added to your journal!',
                style: GoogleFonts.dmSans(),
              ),
            ),
          );
        }
      }
    } on TicketScanCancelledException {
      return;
    } on TicketScanException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message, style: GoogleFonts.dmSans())),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ticket scan failed: $e', style: GoogleFonts.dmSans()),
          ),
        );
      }
    }
  }

  Future<TicketSaveResult> _saveTicket(
    Uint8List originalBytes,
    Uint8List processedBytes,
    bool backgroundRemoved,
  ) async {
    final journalId = await _persistJournal();
    final pageId = _journal!.pages.isNotEmpty ? _journal!.pages.first.pageId : null;
    return TicketScanService.save(
      journalId: journalId,
      journalTitle: _journal!.title,
      countryId: _journal!.countryId,
      pageId: pageId,
      originalBytes: originalBytes,
      processedBytes: processedBytes,
      backgroundRemoved: backgroundRemoved,
      xPosition: 50 + _canvasElements.length * 16,
      yPosition: 120 + _canvasElements.length * 24,
      width: 200,
      height: 130,
      scale: 1,
      rotation: 0,
    );
  }

  void _addTicketElement(TicketSaveResult result, Uint8List processedBytes) {
    final serverId = result.journalId;
    if (serverId != null && _journal!.journalId != serverId) {
      _journal = Journal(
        journalId: serverId,
        title: _journal!.title,
        countryId: _journal!.countryId,
        coverImage: _journal!.coverImage,
        pages: _journal!.pages,
      );
    }
    setState(() {
      _canvasElements.add(CanvasElement(
        id: 'ticket_${DateTime.now().millisecondsSinceEpoch}',
        type: 'ticket',
        x: 50 + _canvasElements.length * 16,
        y: 120 + _canvasElements.length * 24,
        width: 200,
        height: 130,
        scale: 1,
        rotation: 0,
        imageUrl: result.imageUrl,
        ticketId: result.ticketId,
        localImageBytes: result.queuedOffline ? processedBytes : null,
      ));
    });
  }

  void _addStickerToCanvas(String emoji) {
    setState(() {
      _canvasElements.add(CanvasElement(
        id: 'sticker_${DateTime.now().millisecondsSinceEpoch}',
        type: 'sticker',
        x: 50 + _canvasElements.length * 20,
        y: 100 + _canvasElements.length * 30,
        emoji: emoji,
        stickerSize: 40,
      ));
    });
  }

  void _showStickerPicker() {
    final stickers = [
      {'emoji': '✈️', 'name': 'Airplane'},
      {'emoji': '🎫', 'name': 'Ticket'},
      {'emoji': '📸', 'name': 'Camera'},
      {'emoji': '🎨', 'name': 'Art'},
      {'emoji': '☕', 'name': 'Coffee'},
      {'emoji': '🏛️', 'name': 'Building'},
      {'emoji': '🎭', 'name': 'Theater'},
      {'emoji': '🍷', 'name': 'Wine'},
    ];
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppTheme.space4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add Sticker',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppTheme.space4),
            Wrap(
              spacing: AppTheme.space3,
              runSpacing: AppTheme.space3,
              children: stickers.map((sticker) {
                return GestureDetector(
                  onTap: () {
                    _addStickerToCanvas(sticker['emoji'] as String);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(AppTheme.space2),
                    decoration: BoxDecoration(
                      color: AppTheme.bg,
                      borderRadius:
                          BorderRadius.circular(AppTheme.radiusMd),
                    ),
                    child: Column(
                      children: [
                        Text(
                          sticker['emoji'] as String,
                          style: const TextStyle(fontSize: 32),
                        ),
                        Text(
                          sticker['name'] as String,
                          style: GoogleFonts.dmSans(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionToolbar() {
    final element = _selectedElement;
    if (element == null) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.space3, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.card,
        boxShadow: AppTheme.shadowSm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSelectionAction(
            icon: Icons.rotate_left,
            tooltip: 'Rotate left',
            onTap: () => setState(
              () => element.rotation = ((element.rotation ?? 0) - 15) % 360,
            ),
          ),
          _buildSelectionAction(
            icon: Icons.rotate_right,
            tooltip: 'Rotate right',
            onTap: () => setState(
              () => element.rotation = ((element.rotation ?? 0) + 15) % 360,
            ),
          ),
          _buildSelectionAction(
            icon: Icons.zoom_out,
            tooltip: 'Make smaller',
            onTap: () => setState(
              () => element.scale =
                  ((element.scale ?? 1) - 0.15).clamp(0.3, 3.0).toDouble(),
            ),
          ),
          _buildSelectionAction(
            icon: Icons.zoom_in,
            tooltip: 'Make bigger',
            onTap: () => setState(
              () => element.scale =
                  ((element.scale ?? 1) + 0.15).clamp(0.3, 3.0).toDouble(),
            ),
          ),
          _buildSelectionAction(
            icon: Icons.copy,
            tooltip: 'Duplicate',
            onTap: () => _duplicateElement(element),
          ),
          _buildSelectionAction(
            icon: Icons.delete_outline,
            tooltip: 'Delete',
            color: Colors.red,
            onTap: () => _deleteElement(element),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionAction({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
    Color? color,
  }) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        icon: Icon(icon, size: 20, color: color ?? AppTheme.darkBrown),
        onPressed: onTap,
      ),
    );
  }

  CanvasElement? get _selectedElement {
    for (final e in _canvasElements) {
      if (e.id == _selectedElementId) return e;
    }
    return null;
  }

  void _duplicateElement(CanvasElement element) {
    setState(() {
      final copy = CanvasElement(
        id: '${element.type}_${DateTime.now().millisecondsSinceEpoch}',
        type: element.type,
        x: element.x + 24,
        y: element.y + 24,
        text: element.text,
        textStyle: element.textStyle,
        imageUrl: element.imageUrl,
        width: element.width,
        height: element.height,
        emoji: element.emoji,
        stickerSize: element.stickerSize,
        ticketInfo: element.ticketInfo,
        scale: element.scale,
        rotation: element.rotation,
        ticketId: element.ticketId,
        localImageBytes: element.localImageBytes,
      );
      _canvasElements.add(copy);
      _selectedElementId = copy.id;
    });
  }

  void _deleteElement(CanvasElement element) {
    setState(() {
      _canvasElements.removeWhere((e) => e.id == element.id);
      _selectedElementId = null;
    });
    final ticketId = element.ticketId;
    if (ticketId != null) {
      // Best effort: remove the uploaded image server-side too.
      ApiClient.delete('/tickets/$ticketId').catchError((_) {});
    }
  }

  Widget _buildBottomToolPanel() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.space3),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppTheme.radiusLg),
        ),
        boxShadow: AppTheme.shadowLg,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildToolButton(
            icon: Icons.note_add_outlined,
            label: 'Add page',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'New page coming soon!',
                    style: GoogleFonts.dmSans(),
                  ),
                ),
              );
            },
          ),
          _buildToolButton(
            icon: Icons.text_fields,
            label: 'Add text',
            onTap: _addTextBlock,
          ),
          _buildToolButton(
            icon: Icons.add_photo_alternate,
            label: 'Pictures',
            onTap: _addImage,
          ),
          _buildToolButton(
            icon: Icons.camera_alt_outlined,
            label: 'Scan tickets',
            onTap: _scanTicket,
          ),
          _buildToolButton(
            icon: Icons.emoji_emotions_outlined,
            label: 'Add elements',
            onTap: _showStickerPicker,
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: AppTheme.primary,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.dmSans(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppTheme.darkBrown,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
