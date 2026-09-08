import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showAppSnackBar(BuildContext context, String message, {Color? backgroundColor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: GoogleFonts.dmSans()),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 2),
    ),
  );
}
