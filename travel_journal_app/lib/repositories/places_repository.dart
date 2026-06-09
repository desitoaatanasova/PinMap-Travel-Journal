import '../models/country.dart';
import '../models/location.dart';
import '../models/place.dart';

abstract class PlacesRepository {
  Future<List<Country>> getAllCountries();
  Future<Country?> getCountryByName(String name);
  Future<void> toggleCountryVisited(String countryName);
  Future<List<Place>> getPlacesForCategory(String category, String city);
  Future<bool> isPlaceVisited(String placeName);
  Future<void> togglePlaceVisited(String placeName);
  Future<List<Location>> searchLocations(String query);
}
