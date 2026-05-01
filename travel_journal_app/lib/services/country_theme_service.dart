import 'package:flutter/material.dart';
import 'package:pinmap_travel_journal/models/country_theme.dart';

class CountryThemeService {
  static CountryTheme getThemeForCountry(String countryName) {
    final themes = <String, CountryTheme>{
      'Italy': CountryTheme(
        primaryColor: Color(0xFF7e6350),
        secondaryColor: Color(0xFF5a4a3a),
        backgroundColor: Color(0xFFfaf6f1),
        textColor: Color(0xFF3d3025),
        accentColor: Color(0xFFb8956a),
        surfaceColor: Color(0xFFf3ece2),
        gradientColors: [Color(0xFF7e6350), Color(0xFF5a4a3a), Color(0xFF3d3025)],
      ),
      'France': CountryTheme(
        primaryColor: Color(0xFF641919),
        secondaryColor: Color(0xFF8b2525),
        backgroundColor: Color(0xFFfef5f5),
        textColor: Color(0xFF2d0a0a),
        accentColor: Color(0xFFebcfd2),
        surfaceColor: Color(0xFFfdf0f0),
        gradientColors: [Color(0xFF641919), Color(0xFF8b2525), Color(0xFF2d0a0a)],
      ),
      'Spain': CountryTheme(
        primaryColor: Color(0xFFa8521f),
        secondaryColor: Color(0xFFc9631f),
        backgroundColor: Color(0xFFfffaf0),
        textColor: Color(0xFF3d1e0a),
        accentColor: Color(0xFFffeea8),
        surfaceColor: Color(0xFFfff8e8),
        gradientColors: [Color(0xFFa8521f), Color(0xFFc9631f), Color(0xFF3d1e0a)],
      ),
      'Portugal': CountryTheme(
        primaryColor: Color(0xFF8f1402),
        secondaryColor: Color(0xFFb01a02),
        backgroundColor: Color(0xFFf5faf4),
        textColor: Color(0xFF2d0a02),
        accentColor: Color(0xFFbfd8b8),
        surfaceColor: Color(0xFFf0f7ee),
        gradientColors: [Color(0xFF8f1402), Color(0xFFb01a02), Color(0xFF2d0a02)],
      ),
      'Ireland': CountryTheme(
        primaryColor: Color(0xFF2f5d3a),
        secondaryColor: Color(0xFF3a7548),
        backgroundColor: Color(0xFFf5f9f0),
        textColor: Color(0xFF1a3320),
        accentColor: Color(0xFFe1d3b7),
        surfaceColor: Color(0xFFf0f5eb),
        gradientColors: [Color(0xFF2f5d3a), Color(0xFF3a7548), Color(0xFF1a3320)],
      ),
      'England': CountryTheme(
        primaryColor: Color(0xFF042d62),
        secondaryColor: Color(0xFF063d82),
        backgroundColor: Color(0xFFf5f8ff),
        textColor: Color(0xFF011a3a),
        accentColor: Color(0xFFffe6c2),
        surfaceColor: Color(0xFFeef2ff),
        gradientColors: [Color(0xFF042d62), Color(0xFF063d82), Color(0xFF011a3a)],
      ),
      'Scotland': CountryTheme(
        primaryColor: Color(0xFF244357),
        secondaryColor: Color(0xFF2d5570),
        backgroundColor: Color(0xFFf0f7fb),
        textColor: Color(0xFF0f1f2a),
        accentColor: Color(0xFFcce7f1),
        surfaceColor: Color(0xFFe8f2f8),
        gradientColors: [Color(0xFF244357), Color(0xFF2d5570), Color(0xFF0f1f2a)],
      ),
      'Belgium': CountryTheme(
        primaryColor: Color(0xFF9e3b3b),
        secondaryColor: Color(0xFFb84a4a),
        backgroundColor: Color(0xFFfffcf0),
        textColor: Color(0xFF3d1515),
        accentColor: Color(0xFFfffaa0),
        surfaceColor: Color(0xFFfffde8),
        gradientColors: [Color(0xFF9e3b3b), Color(0xFFb84a4a), Color(0xFF3d1515)],
      ),
      'The Netherlands': CountryTheme(
        primaryColor: Color(0xFFc85103),
        secondaryColor: Color(0xFFe8630a),
        backgroundColor: Color(0xFFfff8f4),
        textColor: Color(0xFF4a1e01),
        accentColor: Color(0xFFffd0a6),
        surfaceColor: Color(0xFFfff0e8),
        gradientColors: [Color(0xFFc85103), Color(0xFFe8630a), Color(0xFF4a1e01)],
      ),
    };
    return themes[countryName] ?? CountryTheme(
      primaryColor: Color(0xFF3E2723),
      secondaryColor: Color(0xFF5D4037),
      backgroundColor: Color(0xFFF7F2EC),
      textColor: Color(0xFF2D1810),
      accentColor: Color(0xFF8D7966),
      surfaceColor: Colors.white,
      gradientColors: [Color(0xFF3E2723), Color(0xFF5D4037), Color(0xFF2D1810)],
    );
  }
}
