import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_journal_app/models/journal.dart';
import 'package:travel_journal_app/services/journal_service.dart';
import 'package:travel_journal_app/theme/app_theme.dart';

class JournalEditorScreen extends StatefulWidget {
  final String? chapterId;

  const JournalEditorScreen({super.key, this.chapterId});

  @override
  State<JournalEditorScreen> createState() => _JournalEditorScreenState();
}

class _JournalEditorScreenState extends State<JournalEditorScreen> {
  late TextEditingController _textController;
  JournalChapter? _chapter;
  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderline = false;
  Color _textColor = Colors.black87;
  String _currentFont = 'DM Sans';
  final List<String> _availableFonts = const [
    'DM Sans',
    'Playfair Display',
    'Dancing Script',
  ];

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    if (widget.chapterId != null) {
      _chapter = JournalService.getChapterById(widget.chapterId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF6),
      extendBody: true,
      appBar: AppBar(
        title: Text(
          _chapter?.title ?? 'New Chapter',
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
            icon: const Icon(Icons.save_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Chapter saved!',
                    style: GoogleFonts.dmSans(),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
        ],
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
    final entries = _chapter?.entries ?? [];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_chapter != null) ...[
            Container(
              padding: const EdgeInsets.all(AppTheme.space4),
              decoration: BoxDecoration(
                color: _chapter!.accentColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                border: Border.all(
                  color: _chapter!.accentColor.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _chapter!.title,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkBrown,
                    ),
                  ),
                  const SizedBox(height: AppTheme.space1),
                  Text(
                    '${_chapter!.city ?? ''}, ${_chapter!.country}',
                    style: GoogleFonts.dancingScript(
                      fontSize: 18,
                      color: AppTheme.warmGray,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.space4),
          ],
          ...entries.map((entry) => _buildEntryCard(entry)),
          const SizedBox(height: AppTheme.space4),
          _buildNewEntryField(),
          const SizedBox(height: AppTheme.space12),
        ],
      ),
    );
  }

  Widget _buildEntryCard(JournalEntry entry) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.space4),
      padding: const EdgeInsets.all(AppTheme.space4),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: AppTheme.shadowMd,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (entry.imageUrls.isNotEmpty) ...[
            SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: entry.imageUrls.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: AppTheme.space2),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    child: Image.network(
                      entry.imageUrls[index],
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) => Container(
                        height: 200,
                        width: 200,
                        color: AppTheme.lightGray,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppTheme.space3),
          ],
          Text(
            entry.content,
            style: GoogleFonts.dmSans(
              fontSize: 14,
              height: 1.6,
              color: AppTheme.darkBrown,
            ),
          ),
          if (entry.stickers.isNotEmpty) ...[
            const SizedBox(height: AppTheme.space3),
            Wrap(
              spacing: AppTheme.space2,
              children: entry.stickers.map((sticker) {
                return Text(
                  sticker.emoji,
                  style: TextStyle(fontSize: sticker.size),
                );
              }).toList(),
            ),
          ],
          const SizedBox(height: AppTheme.space2),
          Text(
            '${entry.createdAt.month}/${entry.createdAt.day} ${entry.createdAt.hour}:${entry.createdAt.minute.toString().padLeft(2, '0')}',
            style: GoogleFonts.dmSans(
              fontSize: 11,
              color: AppTheme.warmGray,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewEntryField() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.space4),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: AppTheme.shadowSm,
        border: Border.all(
          color: AppTheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _textController,
            maxLines: 6,
            style: _getFontStyle(_currentFont),
            decoration: InputDecoration(
              hintText: 'Write your story...',
              hintStyle: GoogleFonts.dmSans(
                color: AppTheme.warmGray,
              ),
              border: InputBorder.none,
            ),
          ),
          const SizedBox(height: AppTheme.space3),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.add_photo_alternate, size: 20),
                color: AppTheme.warmGray,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Image upload coming soon!',
                        style: GoogleFonts.dmSans(),
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.emoji_emotions_outlined, size: 20),
                color: AppTheme.warmGray,
                onPressed: _showStickerPicker,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showStickerPicker() {
    final stickers = [
      JournalSticker(emoji: '✈️', name: 'Airplane'),
      JournalSticker(emoji: '🎫', name: 'Ticket'),
      JournalSticker(emoji: '📸', name: 'Camera'),
      JournalSticker(emoji: '🎨', name: 'Art'),
      JournalSticker(emoji: '☕', name: 'Coffee'),
      JournalSticker(emoji: '🏛️', name: 'Building'),
      JournalSticker(emoji: '🎭', name: 'Theater'),
      JournalSticker(emoji: '🍷', name: 'Wine'),
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
                    _textController.text += ' ${sticker.emoji}';
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
                          sticker.emoji,
                          style: const TextStyle(fontSize: 32),
                        ),
                        Text(
                          sticker.name,
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
            onTap: () {
              // Focus on text field
            },
          ),
          _buildToolButton(
            icon: Icons.add_photo_alternate,
            label: 'Pictures',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Image upload coming soon!',
                    style: GoogleFonts.dmSans(),
                  ),
                ),
              );
            },
          ),
          _buildToolButton(
            icon: Icons.camera_alt_outlined,
            label: 'Scan',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Scan feature coming soon!',
                    style: GoogleFonts.dmSans(),
                  ),
                ),
              );
            },
          ),
          _buildToolButton(
            icon: Icons.emoji_emotions_outlined,
            label: 'Stickers',
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
