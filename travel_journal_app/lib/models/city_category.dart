import 'package:flutter/material.dart';

class CityCategory {
  final String name;
  final IconData icon;
  final Color color;
  final Color markerColor;

  const CityCategory({
    required this.name,
    required this.icon,
    required this.color,
    required this.markerColor,
  });

  static const historicalSights = CityCategory(
    name: 'Historical Sights',
    icon: Icons.account_balance,
    color: Color(0xFF8B4513),
    markerColor: Color(0xFF8B4513),
  );

  static const artLovers = CityCategory(
    name: 'For the Art Lovers',
    icon: Icons.palette,
    color: Color(0xFF008080),
    markerColor: Color(0xFF008080),
  );

  static const atmosphere = CityCategory(
    name: 'Atmosphere & experience',
    icon: Icons.visibility,
    color: Color(0xFFDAA520),
    markerColor: Color(0xFFDAA520),
  );

  static const hiddenGems = CityCategory(
    name: 'Hidden Gems',
    icon: Icons.star,
    color: Color(0xFF8A2BE2),
    markerColor: Color(0xFF8A2BE2),
  );

  static const closeBy = CityCategory(
    name: 'Close by',
    icon: Icons.explore,
    color: Color(0xFF228B22),
    markerColor: Color(0xFF228B22),
  );

  static const myPlaces = CityCategory(
    name: 'My places',
    icon: Icons.place,
    color: Color(0xFFDC143C),
    markerColor: Color(0xFFDC143C),
  );
}
