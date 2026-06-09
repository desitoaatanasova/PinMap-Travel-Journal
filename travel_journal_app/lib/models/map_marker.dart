import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

enum MarkerCategory {
  historical,
  art,
  atmosphere,
  hiddenGems,
  closeBy,
  myPlaces,
}

class MapMarker {
  final String id;
  final LatLng position;
  final String title;
  final MarkerCategory category;
  final bool isSelected;
  final bool isVisited;

  const MapMarker({
    required this.id,
    required this.position,
    required this.title,
    required this.category,
    this.isSelected = false,
    this.isVisited = false,
  });

  Color get color {
    switch (category) {
      case MarkerCategory.historical:
        return const Color(0xFF8B4513); // Paper brown
      case MarkerCategory.art:
        return const Color(0xFF008080); // Teal
      case MarkerCategory.atmosphere:
        return const Color(0xFFDAA520); // Gold
      case MarkerCategory.hiddenGems:
        return const Color(0xFF8A2BE2); // Violet
      case MarkerCategory.closeBy:
        return const Color(0xFF228B22); // Green
      case MarkerCategory.myPlaces:
        return const Color(0xFFDC143C); // Red
    }
  }

  IconData get icon {
    switch (category) {
      case MarkerCategory.historical:
        return Icons.castle; // Castle/tower icon
      case MarkerCategory.art:
        return Icons.palette; // Palette icon
      case MarkerCategory.atmosphere:
        return Icons.remove_red_eye; // Binoculars alternative
      case MarkerCategory.hiddenGems:
        return Icons.star; // Star icon
      case MarkerCategory.closeBy:
        return Icons.explore; // Compass alternative
      case MarkerCategory.myPlaces:
        return Icons.place; // Classic map pin
    }
  }

  String get label {
    switch (category) {
      case MarkerCategory.historical:
        return 'Historical';
      case MarkerCategory.art:
        return 'Art';
      case MarkerCategory.atmosphere:
        return 'Atmosphere';
      case MarkerCategory.hiddenGems:
        return 'Hidden';
      case MarkerCategory.closeBy:
        return 'Close by';
      case MarkerCategory.myPlaces:
        return 'My Place';
    }
  }
}
