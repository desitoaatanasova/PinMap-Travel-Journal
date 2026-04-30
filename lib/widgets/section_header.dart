import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_journal_app/theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Color? color;
  final Widget? trailing;

  const SectionHeader({
    super.key,
    required this.title,
    this.color,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.playfairDisplay(
                color: color ?? AppTheme.darkBrown,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          trailing?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
