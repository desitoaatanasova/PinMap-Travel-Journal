import 'package:flutter/material.dart';

class Place {
  final String name;
  final String subtitle;
  final String description;
  final IconData placeholderIcon;
  final Color placeholderColor;
  final List<String> imageUrls;

  const Place({
    required this.name,
    required this.subtitle,
    required this.description,
    this.placeholderIcon = Icons.place,
    this.placeholderColor = Colors.grey,
    this.imageUrls = const [],
  });
}
