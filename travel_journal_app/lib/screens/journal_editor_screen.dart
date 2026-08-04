import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinmap_travel_journal/models/journal.dart';
import 'package:pinmap_travel_journal/services/journal_service.dart';
import 'package:pinmap_travel_journal/services/country_service.dart';
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
                    await JournalService.saveJournal(_journal!);
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
          child: _buildElementContent(element),
        ),
      ),
    );
  }

  Widget _buildElementContent(CanvasElement element) {
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
        return ClipRRect(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          child: CachedNetworkImage(
            imageUrl: element.imageUrl ?? 'https://picsum.photos/200/200?random=${element.id}',
            width: element.width ?? 200,
            height: element.height ?? 200,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              width: element.width ?? 200,
              height: element.height ?? 200,
              color: AppTheme.lightGray,
              child: const Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => Container(
              width: element.width ?? 200,
              height: element.height ?? 200,
              color: AppTheme.lightGray,
              child: const Icon(Icons.image, size: 50, color: Colors.grey),
            ),
          ),
        );
      case 'sticker':
        return Text(
          element.emoji ?? '😊',
          style: TextStyle(fontSize: element.stickerSize ?? 40),
        );
      case 'ticket':
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            boxShadow: AppTheme.shadowMd,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.confirmation_number, color: AppTheme.primary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Ticket',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                element.ticketInfo ?? 'Flight: NYC → PAR\nDate: 2026-05-15\nSeat: 14A',
                style: GoogleFonts.dmSans(fontSize: 12, color: AppTheme.warmGray),
              ),
            ],
          ),
        );
      default:
        return const SizedBox();
    }
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

  void _addTicket() {
    setState(() {
      _canvasElements.add(CanvasElement(
        id: 'ticket_${DateTime.now().millisecondsSinceEpoch}',
        type: 'ticket',
        x: 50 + _canvasElements.length * 20,
        y: 100 + _canvasElements.length * 30,
        ticketInfo: 'Flight: NYC → PAR\nDate: 2026-05-15\nSeat: 14A',
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
            onTap: _addTicket,
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
