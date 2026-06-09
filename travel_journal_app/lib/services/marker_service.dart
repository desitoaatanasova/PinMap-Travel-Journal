import 'package:latlong2/latlong.dart';
import 'package:pinmap_travel_journal/models/map_marker.dart';
import 'package:pinmap_travel_journal/models/country.dart';
import 'package:pinmap_travel_journal/services/country_service.dart';

class MarkerService {
  static MapMarker fromCountry(Country country) {
    final lat = country.cityPins.isNotEmpty ? country.cityPins.first.latitude : 0.0;
    final lng = country.cityPins.isNotEmpty ? country.cityPins.first.longitude : 0.0;
    return MapMarker(
      id: country.name,
      position: LatLng(lat, lng),
      title: country.name,
      category: MarkerCategory.hiddenGems,
    );
  }

  static MapMarker fromCityPin(CityPin city, String countryName) {
    return MapMarker(
      id: city.name,
      position: city.latLng,
      title: city.name,
      category: MarkerCategory.hiddenGems,
    );
  }

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

  static MarkerCategory _getCategoryForPlace(String categoryName) {
    switch (categoryName) {
      case 'Historical Sights':
        return MarkerCategory.historical;
      case 'For the Art Lovers':
        return MarkerCategory.art;
      case 'Atmosphere & experience':
        return MarkerCategory.atmosphere;
      case 'Hidden Gems':
        return MarkerCategory.hiddenGems;
      case 'Close by':
        return MarkerCategory.closeBy;
      case 'My places':
        return MarkerCategory.myPlaces;
      default:
        return MarkerCategory.hiddenGems;
    }
  }

  static List<MapMarker> buildCountryMarkers() {
    final countries = CountryService.getAllCountries();
    return countries.map((country) => fromCountry(country)).toList();
  }
}
