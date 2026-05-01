import 'package:pinmap_travel_journal/models/location.dart';

class LocationSearchService {
  static const List<Location> _locations = [
    Location(name: 'New York', country: 'USA', latitude: 40.7128, longitude: -74.0060),
    Location(name: 'Los Angeles', country: 'USA', latitude: 34.0522, longitude: -118.2437),
    Location(name: 'Chicago', country: 'USA', latitude: 41.8781, longitude: -87.6298),
    Location(name: 'Miami', country: 'USA', latitude: 25.7617, longitude: -80.1918),
    Location(name: 'San Francisco', country: 'USA', latitude: 37.7749, longitude: -122.4194),
    Location(name: 'London', country: 'UK', latitude: 51.5074, longitude: -0.1278),
    Location(name: 'Paris', country: 'France', latitude: 48.8566, longitude: 2.3522),
    Location(name: 'Tokyo', country: 'Japan', latitude: 35.6762, longitude: 139.6503),
    Location(name: 'Sydney', country: 'Australia', latitude: -33.8688, longitude: 151.2093),
    Location(name: 'Rome', country: 'Italy', latitude: 41.9028, longitude: 12.4964),
    Location(name: 'Barcelona', country: 'Spain', latitude: 41.3874, longitude: 2.1686),
    Location(name: 'Amsterdam', country: 'Netherlands', latitude: 52.3676, longitude: 4.9041),
    Location(name: 'Berlin', country: 'Germany', latitude: 52.5200, longitude: 13.4050),
    Location(name: 'Dubai', country: 'UAE', latitude: 25.2048, longitude: 55.2708),
    Location(name: 'Singapore', country: 'Singapore', latitude: 1.3521, longitude: 103.8198),
    Location(name: 'Bangkok', country: 'Thailand', latitude: 13.7563, longitude: 100.5018),
    Location(name: 'Istanbul', country: 'Turkey', latitude: 41.0082, longitude: 28.9784),
    Location(name: 'Cairo', country: 'Egypt', latitude: 30.0444, longitude: 31.2357),
    Location(name: 'Cape Town', country: 'South Africa', latitude: -33.9249, longitude: 18.4241),
    Location(name: 'Rio de Janeiro', country: 'Brazil', latitude: -22.9068, longitude: -43.1729),
    Location(name: 'Mexico City', country: 'Mexico', latitude: 19.4326, longitude: -99.1332),
    Location(name: 'Moscow', country: 'Russia', latitude: 55.7558, longitude: 37.6173),
    Location(name: 'Beijing', country: 'China', latitude: 39.9042, longitude: 116.4074),
    Location(name: 'Mumbai', country: 'India', latitude: 19.0760, longitude: 72.8777),
    Location(name: 'Toronto', country: 'Canada', latitude: 43.6532, longitude: -79.3832),
  ];

  static List<Location> searchLocations(String query) {
    if (query.isEmpty) {
      return [];
    }
    
    final lowerQuery = query.toLowerCase();
    return _locations.where((location) {
      return location.name.toLowerCase().contains(lowerQuery) ||
             location.country.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}