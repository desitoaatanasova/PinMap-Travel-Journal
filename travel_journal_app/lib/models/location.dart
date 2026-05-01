class Location {
  final String name;
  final String country;
  final double latitude;
  final double longitude;

  const Location({
    required this.name,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  String get displayName => '$name, $country';
}