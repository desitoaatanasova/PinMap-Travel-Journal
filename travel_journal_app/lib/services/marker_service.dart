import 'package:latlong2/latlong.dart';
import 'package:travel_journal_app/models/map_marker.dart';
import 'package:travel_journal_app/models/country.dart';
import 'package:travel_journal_app/services/country_service.dart';

class MarkerService {
  // Convert Country to MapMarker
  static MapMarker fromCountry(Country country) {
    return MapMarker(
      id: country.name,
      position: country.latLng,
      title: country.name,
      category: MarkerCategory.hiddenGems, // Default, can be customized
      isVisited: country.isVisited,
    );
  }

  // Convert CityPin to MapMarker
  static MapMarker fromCityPin(CityPin city, String countryName) {
    return MapMarker(
      id: city.name,
      position: city.latLng,
      title: city.name,
      category: _getCategoryForCity(city.name),
    );
  }

  // Get category for a place based on category name
  static MapMarker buildPlaceMarker({
    required String id,
    required LatLng position,
    required String title,
    required String categoryName,
  }) {
    return MapMarker(
      id: id,
      position: position,
      title: title,
      category: _getCategoryForPlace(categoryName),
    );
  }

  // Determine category based on city name (simple logic)
  static MarkerCategory _getCategoryForCity(String cityName) {
    // This can be expanded with more logic
    return MarkerCategory.hiddenGems;
  }

  // Determine category based on place category name
  static MarkerCategory _getCategoryForPlace(String categoryName) {
    switch (categoryName) {
      case 'Historical sights':
        return MarkerCategory.historical;
      case 'For the art lovers':
        return MarkerCategory.art;
      case 'Atmosphere & experience':
        return MarkerCategory.atmosphere;
      case 'Hidden gems':
        return MarkerCategory.hiddenGems;
      case 'Close by':
        return MarkerCategory.closeBy;
      case 'My places':
        return MarkerCategory.myPlaces;
      default:
        return MarkerCategory.hiddenGems;
    }
  }

  // Build markers for all countries
  static List<MapMarker> buildCountryMarkers() {
    final countries = CountryService.getAllCountries();
    return countries.map((country) => fromCountry(country)).toList();
  }
}
