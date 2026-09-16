import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinmap_travel_journal/l10n/app_localizations.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

/// Horizontal strip of page chips with "add page" and page-background actions.
class EditorPageStrip extends StatelessWidget {
  final int pageCount;
  final int currentIndex;
  final ValueChanged<int> onPageSelected;
  final ValueChanged<int> onPageLongPress;
  final VoidCallback onAddPage;
  final VoidCallback onBackground;

  const EditorPageStrip({
    super.key,
    required this.pageCount,
    required this.currentIndex,
    required this.onPageSelected,
    required this.onPageLongPress,
    required this.onAddPage,
    required this.onBackground,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.space2),
      decoration: BoxDecoration(
        color: AppTheme.card,
        boxShadow: AppTheme.shadowSm,
      ),
      child: Row(
        children: [
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: pageCount,
              separatorBuilder: (_, __) => const SizedBox(width: AppTheme.space2),
              itemBuilder: (context, index) {
                final active = index == currentIndex;
                return GestureDetector(
                  onTap: () => onPageSelected(index),
                  onLongPress: () => onPageLongPress(index),
                  child: Container(
                    width: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: active
                          ? AppTheme.primary
                          : AppTheme.bg.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                      border: active
                          ? null
                          : Border.all(color: AppTheme.lightGray),
                    ),
                    child: Text(
                      '${index + 1}',
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: active ? Colors.white : AppTheme.darkBrown,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          IconButton(
            tooltip: l10n.editorAddPage,
            icon: const Icon(Icons.add_circle_outline),
            color: AppTheme.primary,
            onPressed: onAddPage,
          ),
          IconButton(
            tooltip: l10n.editorPageBg,
            icon: const Icon(Icons.format_color_fill),
            color: AppTheme.primary,
            onPressed: onBackground,
          ),
        ],
      ),
    );
  }
}

/// Text formatting controls (bold / italic / underline / colour / font / size).
class EditorFormatToolbar extends StatelessWidget {
  final bool bold;
  final bool italic;
  final bool underline;
  final double fontSize;
  final VoidCallback onToggleBold;
  final VoidCallback onToggleItalic;
  final VoidCallback onToggleUnderline;
  final VoidCallback onPickColor;
  final VoidCallback onPickFont;
  final ValueChanged<double> onFontSize;

  const EditorFormatToolbar({
    super.key,
    required this.bold,
    required this.italic,
    required this.underline,
    required this.fontSize,
    required this.onToggleBold,
    required this.onToggleItalic,
    required this.onToggleUnderline,
    required this.onPickColor,
    required this.onPickFont,
    required this.onFontSize,
  });

  static const List<double> fontSizes = [10, 12, 14, 16, 18, 20, 24, 28, 32];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.space2),
      decoration: BoxDecoration(
        color: AppTheme.card,
        boxShadow: AppTheme.shadowSm,
      ),
      child: Row(
        children: [
          _icon(Icons.format_bold, bold, onToggleBold, l10n.editorFormatTooltip),
          _icon(
            Icons.format_italic,
            italic,
            onToggleItalic,
            l10n.editorFormatTooltip,
          ),
          _icon(
            Icons.format_underline,
            underline,
            onToggleUnderline,
            l10n.editorFormatTooltip,
          ),
          _icon(Icons.color_lens, false, onPickColor, l10n.editorTextColor),
          _icon(Icons.font_download, false, onPickFont, l10n.editorFontFamily),
          const SizedBox(width: AppTheme.space2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppTheme.warmGray.withValues(alpha: 0.3),
              ),
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            ),
            child: DropdownButton<double>(
              value: fontSize,
              underline: const SizedBox(),
              isDense: true,
              style: GoogleFonts.dmSans(fontSize: 12, color: AppTheme.darkBrown),
              items: fontSizes.map((size) {
                return DropdownMenuItem<double>(
                  value: size,
                  child: Text('${size.toInt()}'),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) onFontSize(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _icon(
    IconData icon,
    bool isActive,
    VoidCallback onTap,
    String tooltip,
  ) {
    return IconButton(
      tooltip: tooltip,
      icon: Icon(
        icon,
        size: 20,
        color: isActive ? AppTheme.primary : AppTheme.warmGray,
      ),
      onPressed: onTap,
    );
  }
}

/// Actions for the currently selected element.
class EditorSelectionToolbar extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onRotateLeft;
  final VoidCallback onRotateRight;
  final VoidCallback onSmaller;
  final VoidCallback onBigger;
  final VoidCallback onBringForward;
  final VoidCallback onSendBackward;
  final VoidCallback onDuplicate;
  final VoidCallback onDelete;
  final bool canEdit;

  const EditorSelectionToolbar({
    super.key,
    required this.onEdit,
    required this.onRotateLeft,
    required this.onRotateRight,
    required this.onSmaller,
    required this.onBigger,
    required this.onBringForward,
    required this.onSendBackward,
    required this.onDuplicate,
    required this.onDelete,
    this.canEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.space2),
      decoration: BoxDecoration(
        color: AppTheme.card,
        boxShadow: AppTheme.shadowSm,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            if (canEdit) ...[
              _action(Icons.edit, l10n.editorEditText, onEdit),
            ],
            _action(Icons.rotate_left, l10n.editorRotateLeft, onRotateLeft),
            _action(Icons.rotate_right, l10n.editorRotateRight, onRotateRight),
            _action(Icons.zoom_out, l10n.editorSmaller, onSmaller),
            _action(Icons.zoom_in, l10n.editorBigger, onBigger),
            _action(
              Icons.layers_clear,
              l10n.editorBringForward,
              onBringForward,
            ),
            _action(Icons.layers, l10n.editorSendBackward, onSendBackward),
            _action(Icons.copy, l10n.editorDuplicate, onDuplicate),
            _action(
              Icons.delete_outline,
              l10n.settingsDelete,
              onDelete,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _action(IconData icon, String tooltip, VoidCallback onTap,
      {Color? color}) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        icon: Icon(icon, size: 20, color: color ?? AppTheme.darkBrown),
        onPressed: onTap,
      ),
    );
  }
}

/// Bottom row of tools for adding content.
class EditorBottomPanel extends StatelessWidget {
  final VoidCallback onAddPage;
  final VoidCallback onAddText;
  final VoidCallback onPickImage;
  final VoidCallback onScanTicket;
  final VoidCallback onPickSticker;

  const EditorBottomPanel({
    super.key,
    required this.onAddPage,
    required this.onAddText,
    required this.onPickImage,
    required this.onScanTicket,
    required this.onPickSticker,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.space2),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppTheme.radiusLg),
        ),
        boxShadow: AppTheme.shadowLg,
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _tool(Icons.text_fields, l10n.editorToolText, onAddText),
            _tool(Icons.add_photo_alternate, l10n.editorToolPicture, onPickImage),
            _tool(Icons.camera_alt_outlined, l10n.editorToolTicket, onScanTicket),
            _tool(
              Icons.emoji_emotions_outlined,
              l10n.editorToolSticker,
              onPickSticker,
            ),
          ],
        ),
      ),
    );
  }

  Widget _tool(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24, color: AppTheme.primary),
          const SizedBox(height: 2),
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
}
