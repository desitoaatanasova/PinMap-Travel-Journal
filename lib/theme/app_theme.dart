import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Design System Colors (matching CSS design-system.css)
  static const Color bg = Color(0xFFF7F2EC);
  static const Color warmOffWhite = bg;
  static const Color card = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF3E2723);
  static const Color espressoBrown = primary;
  static const Color darkBrown = Color(0xFF2D1810);
  static const Color warmGray = Color(0xFF8D7966);
  static const Color lightGray = Color(0xFFE8E0D8);
  static const Color charcoal = Color(0xFF3D3D3D);

  // Spacing System (8px baseline)
  static const double space1 = 4;
  static const double space2 = 8;
  static const double space3 = 12;
  static const double space4 = 16;
  static const double space5 = 20;
  static const double space6 = 24;
  static const double space8 = 32;
  static const double space10 = 40;
  static const double space12 = 48;

  // Border Radius
  static const double radiusSm = 8;
  static const double radiusMd = 16;
  static const double radiusLg = 24;
  static const double radiusFull = 9999;

  // Shadows
  static List<BoxShadow> get shadowSm => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];
  static List<BoxShadow> get shadowMd => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ];
  static List<BoxShadow> get shadowLg => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.12),
          blurRadius: 32,
          offset: const Offset(0, 8),
        ),
      ];

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: Colors.white,
        surface: bg,
        onSurface: darkBrown,
        secondary: warmGray,
        onSecondary: Colors.white,
      ),
      scaffoldBackgroundColor: bg,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.playfairDisplay(
          color: darkBrown,
          fontSize: 40,
          fontWeight: FontWeight.bold,
          height: 1.2,
        ),
        displayMedium: GoogleFonts.playfairDisplay(
          color: darkBrown,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          height: 1.2,
        ),
        displaySmall: GoogleFonts.playfairDisplay(
          color: darkBrown,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          height: 1.3,
        ),
        titleLarge: GoogleFonts.dancingScript(
          color: primary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: GoogleFonts.dancingScript(
          color: primary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: GoogleFonts.dmSans(
          color: warmGray,
          fontSize: 16,
          height: 1.6,
        ),
        bodyMedium: GoogleFonts.dmSans(
          color: warmGray,
          fontSize: 14,
          height: 1.6,
        ),
        bodySmall: GoogleFonts.dmSans(
          color: warmGray,
          fontSize: 12,
          height: 1.5,
        ),
        labelLarge: GoogleFonts.dmSans(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: bg,
        foregroundColor: darkBrown,
        elevation: 0,
        titleTextStyle: GoogleFonts.playfairDisplay(
          color: darkBrown,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: darkBrown),
      ),
      cardTheme: CardThemeData(
        color: card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        margin: const EdgeInsets.only(bottom: space4),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusFull),
          ),
          padding: const EdgeInsets.symmetric(
              vertical: space3, horizontal: space6),
          textStyle: GoogleFonts.dmSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: const BorderSide(color: primary, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusFull),
          ),
          padding: const EdgeInsets.symmetric(
              vertical: space3, horizontal: space6),
          textStyle: GoogleFonts.dmSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusFull),
          ),
          textStyle: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: card,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide(color: lightGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: space4, vertical: space3),
        hintStyle: GoogleFonts.dmSans(
          color: warmGray,
          fontSize: 14,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: lightGray,
        thickness: 1,
        space: space4,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: bg,
        labelStyle: GoogleFonts.dmSans(
          color: primary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusFull),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(
            horizontal: space3, vertical: space1),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.dark,
      ),
    );
  }
}
