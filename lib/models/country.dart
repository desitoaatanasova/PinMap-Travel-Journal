import 'package:latlong2/latlong.dart';

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

  LatLng get latLng => LatLng(latitude, longitude);

  bool contains(LatLng point) {
    const double kmToDeg = 1.0 / 111.0;
    final latDelta = radiusKm * kmToDeg;
    final lngDelta = radiusKm * kmToDeg;
    return (point.latitude >= latitude - latDelta &&
            point.latitude <= latitude + latDelta) &&
        (point.longitude >= longitude - lngDelta &&
            point.longitude <= longitude + lngDelta);
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

  LatLng get latLng => LatLng(latitude, longitude);
}