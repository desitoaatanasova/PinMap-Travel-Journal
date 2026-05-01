import 'package:flutter/material.dart';

class CityCategory {
  final String name;
  final IconData icon;
  final Color color;
  final Color pinColor;

  const CityCategory({
    required this.name,
    required this.icon,
    required this.color,
    required this.pinColor,
  });

  // Predefined categories with exact colors
  static const historicalSights = CityCategory(
    name: 'Historical sights',
    icon: Icons.account_balance,
    color: Color(0xFF8B4513), // Paper brown
    pinColor: Color(0xFF8B4513),
  );

  static const artLovers = CityCategory(
    name: 'For the art lovers',
    icon: Icons.palette,
    color: Color(0xFF008080), // Teal
    pinColor: Color(0xFF008080),
  );

  static const atmosphere = CityCategory(
    name: 'Atmosphere & experience',
    icon: Icons.visibility,
    color: Color(0xFFDAA520), // Gold
    pinColor: Color(0xFFDAA520),
  );

  static const hiddenGems = CityCategory(
    name: 'Hidden gems',
    icon: Icons.star,
    color: Color(0xFF8A2BE2), // Violet
    pinColor: Color(0xFF8A2BE2),
  );

  static const closeBy = CityCategory(
    name: 'Close by',
    icon: Icons.explore,
    color: Color(0xFF228B22), // Green
    pinColor: Color(0xFF228B22),
  );

  static const myPlaces = CityCategory(
    name: 'My places',
    icon: Icons.place,
    color: Color(0xFFDC143C), // Red
    pinColor: Color(0xFFDC143C),
  );
}
