import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

Future<bool?> showAppConfirmDialog(
  BuildContext context, {
  required String title,
  required String content,
  String cancelText = 'Cancel',
  String confirmText = 'Confirm',
  Color confirmColor = Colors.red,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        title,
        style: GoogleFonts.playfairDisplay(color: AppTheme.darkBrown, fontWeight: FontWeight.bold),
      ),
      content: Text(content, style: GoogleFonts.dmSans()),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(cancelText, style: GoogleFonts.dmSans(color: AppTheme.warmGray)),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          style: ElevatedButton.styleFrom(backgroundColor: confirmColor, foregroundColor: Colors.white),
          child: Text(confirmText, style: GoogleFonts.dmSans()),
        ),
      ],
    ),
  );
}
