import 'package:flutter/material.dart';
import 'package:travel_journal_app/models/country_theme.dart';

class CountryThemeService {
  static CountryTheme getThemeForCountry(String countryName) {
    final themes = <String, CountryTheme>{
      'Italy': CountryTheme(
        primaryColor: Color(0xFF7e6350),
        secondaryColor: Color(0xFF7e6350),
        backgroundColor: Color(0xFFe1d3b7),
        textColor: Color(0xFFe1d3b7),
      ),
      'France': CountryTheme(
        primaryColor: Color(0xFF641919),
        secondaryColor: Color(0xFF641919),
        backgroundColor: Color(0xFFebcfd2),
        textColor: Color(0xFFebcfd2),
      ),
      'Spain': CountryTheme(
        primaryColor: Color(0xFFa8521f),
        secondaryColor: Color(0xFFa8521f),
        backgroundColor: Color(0xFFffeea8),
        textColor: Color(0xFFffeea8),
      ),
      'Portugal': CountryTheme(
        primaryColor: Color(0xFF8f1402),
        secondaryColor: Color(0xFF8f1402),
        backgroundColor: Color(0xFFbfd8b8),
        textColor: Color(0xFFbfd8b8),
      ),
      'Ireland': CountryTheme(
        primaryColor: Color(0xFF2f5d3a),
        secondaryColor: Color(0xFF2f5d3a),
        backgroundColor: Color(0xFFe1d3b7),
        textColor: Color(0xFFe1d3b7),
      ),
      'England': CountryTheme(
        primaryColor: Color(0xFF042d62),
        secondaryColor: Color(0xFF042d62),
        backgroundColor: Color(0xFFffe6c2),
        textColor: Color(0xFFffe6c2),
      ),
      'Scotland': CountryTheme(
        primaryColor: Color(0xFF244357),
        secondaryColor: Color(0xFF244357),
        backgroundColor: Color(0xFFcce7f1),
        textColor: Color(0xFFcce7f1),
      ),
      'Belgium': CountryTheme(
        primaryColor: Color(0xFF9e3b3b),
        secondaryColor: Color(0xFF9e3b3b),
        backgroundColor: Color(0xFFfffaa0),
        textColor: Color(0xFFfffaa0),
      ),
      'The Netherlands': CountryTheme(
        primaryColor: Color(0xFFc85103),
        secondaryColor: Color(0xFFc85103),
        backgroundColor: Color(0xFFffd0a6),
        textColor: Color(0xFFffd0a6),
      ),
    };
    return themes[countryName] ?? CountryTheme(
      primaryColor: Colors.blue,
      secondaryColor: Colors.blue,
      backgroundColor: Colors.white,
      textColor: Colors.black87,
    );
  }
}
