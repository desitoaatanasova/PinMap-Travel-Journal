import 'package:flutter/material.dart';
import 'package:pinmap_travel_journal/screens/journal_editor/canvas_element.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

/// Inline text editor shown over a selected text element. Typing updates the
/// element live; the style mirrors the element's scaled text style.
class TextEditOverlay extends StatefulWidget {
  final EditorElement element;
  final ValueChanged<String> onChanged;
  final VoidCallback onDone;

  const TextEditOverlay({
    super.key,
    required this.element,
    required this.onChanged,
    required this.onDone,
  });

  @override
  State<TextEditOverlay> createState() => _TextEditOverlayState();
}

class _TextEditOverlayState extends State<TextEditOverlay> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.element.text ?? '');
    _controller.selection = TextSelection(
      baseOffset: _controller.text.length,
      extentOffset: _controller.text.length,
    );
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {},
      child: Container(
        width: 260,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.96),
          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
          border: Border.all(color: AppTheme.primary, width: 1.5),
          boxShadow: AppTheme.shadowMd,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 32, 8),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                maxLines: null,
                style: widget.element.scaledTextStyle,
                textAlign: widget.element.textAlign,
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: widget.onChanged,
              ),
            ),
            Positioned(
              top: 6,
              right: 6,
              child: GestureDetector(
                onTap: widget.onDone,
                child: const Icon(
                  Icons.check_circle,
                  size: 20,
                  color: AppTheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
