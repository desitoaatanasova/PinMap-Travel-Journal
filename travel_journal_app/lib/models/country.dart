import 'package:latlong2/latlong.dart';

class Country {
  final int countryId;
  final String name;
  final String continent;
  final String description;
  final String? flagImage;
  final String? primaryColor;
  final String? secondaryColor;
  final List<CityPin> cityPins;

  Country({
    required this.countryId,
    required this.name,
    required this.continent,
    required this.description,
    this.flagImage,
    this.primaryColor,
    this.secondaryColor,
    this.cityPins = const [],
  });

  static Country fromJson(Map<String, dynamic> json) {
    return Country(
      countryId: json['country_id'] ?? 0,
      name: json['name'] ?? '',
      continent: json['continent'] ?? '',
      description: json['description'] ?? '',
      flagImage: json['flag_image'],
      primaryColor: json['primary_color'],
      secondaryColor: json['secondary_color'],
      cityPins: (json['cities'] as List?)
              ?.map((c) => CityPin.fromJson(c))
              .toList() ??
          [],
    );
  }
}

class CityPin {
  final int cityId;
  final String name;
  final String? description;
  final double latitude;
  final double longitude;

  const CityPin({
    required this.cityId,
    required this.name,
    this.description,
    required this.latitude,
    required this.longitude,
  });

  LatLng get latLng => LatLng(latitude, longitude);

  factory CityPin.fromJson(Map<String, dynamic> json) {
    return CityPin(
      cityId: json['city_id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }
}
