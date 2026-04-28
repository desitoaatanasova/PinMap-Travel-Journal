import 'package:google_maps_flutter/google_maps_flutter.dart';

class Country {
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final double radiusKm;
  final List<CityPin> cityPins;

  const Country({
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.radiusKm,
    required this.cityPins,
  });

  LatLng get capital => LatLng(latitude, longitude);

  LatLngBounds get bounds {
    const double kmToDeg = 1.0 / 111.0;
    final latDelta = radiusKm * kmToDeg;
    final lngDelta = radiusKm * kmToDeg;
    return LatLngBounds(
      southwest: LatLng(latitude - latDelta, longitude - lngDelta),
      northeast: LatLng(latitude + latDelta, longitude + lngDelta),
    );
  }

  bool contains(LatLng point) {
    return bounds.contains(point);
  }
}

class CityPin {
  final String name;
  final double latitude;
  final double longitude;

  const CityPin({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  LatLng get position => LatLng(latitude, longitude);
}