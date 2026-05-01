import 'package:flutter/material.dart';

class WishlistItem {
  final String id;
  final String name;
  final String country;
  final String? city;
  final String? imageUrl;
  final String? description;
  final bool isVisited;

  const WishlistItem({
    required this.id,
    required this.name,
    required this.country,
    this.city,
    this.imageUrl,
    this.description,
    this.isVisited = false,
  });
}
