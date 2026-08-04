import 'package:flutter/material.dart';

class Place {
  final int placeId;
  final String name;
  final String? shortDescription;
  final String? fullDescription;
  final String? address;
  final double? latitude;
  final double? longitude;
  final String? website;
  final String? openingHours;
  final String? imageCover;
  final String? categoryName;
  final String? categoryIcon;
  final String? categoryMarkerColor;
  final List<PlacePhoto> photos;

  const Place({
    required this.placeId,
    required this.name,
    this.shortDescription,
    this.fullDescription,
    this.address,
    this.latitude,
    this.longitude,
    this.website,
    this.openingHours,
    this.imageCover,
    this.categoryName,
    this.categoryIcon,
    this.categoryMarkerColor,
    this.photos = const [],
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      placeId: json['place_id'] ?? 0,
      name: json['name'] ?? '',
      shortDescription: json['short_description'],
      fullDescription: json['full_description'],
      address: json['address'],
      latitude: json['latitude'] != null
          ? (json['latitude'] is String
              ? double.parse(json['latitude'])
              : (json['latitude'] as num)).toDouble()
          : null,
      longitude: json['longitude'] != null
          ? (json['longitude'] is String
              ? double.parse(json['longitude'])
              : (json['longitude'] as num)).toDouble()
          : null,
      website: json['website'],
      openingHours: json['opening_hours'],
      imageCover: json['image_cover'],
      categoryName: json['category_name'],
      categoryIcon: json['category_icon'],
      categoryMarkerColor: json['category_marker_color'],
      photos: (json['photos'] as List?)
              ?.map((p) => PlacePhoto.fromJson(p))
              .toList() ??
          [],
    );
  }

  static IconData iconFromString(String? iconName) {
    switch (iconName?.toLowerCase().replaceAll('_', '')) {
      case 'landmark':
      case 'accountbalance':
        return Icons.account_balance;
      case 'palette':
        return Icons.palette;
      case 'heart':
        return Icons.favorite;
      case 'star':
        return Icons.star;
      case 'mappin':
      case 'explore':
        return Icons.explore;
      case 'visibility':
      case 'remove redeye':
        return Icons.visibility;
      case 'favorite':
        return Icons.favorite;
      case 'place':
        return Icons.place;
      case 'castle':
        return Icons.castle;
      default:
        return Icons.place;
    }
  }
}

class PlacePhoto {
  final int photoId;
  final String imageUrl;

  const PlacePhoto({
    required this.photoId,
    required this.imageUrl,
  });

  factory PlacePhoto.fromJson(Map<String, dynamic> json) {
    return PlacePhoto(
      photoId: json['photo_id'] ?? 0,
      imageUrl: json['image_url'] ?? '',
    );
  }
}
