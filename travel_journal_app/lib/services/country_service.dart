import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'package:pinmap_travel_journal/models/country.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';

class CountryService {
  static List<Country> _countries = [];
  static bool _loaded = false;
  static String? _lastError;

  static String? get lastError => _lastError;
  static bool get hasError => _lastError != null;

  static Future<void> loadCountries() async {
    if (_loaded) return;
    try {
      _lastError = null;
      final data = await ApiClient.get('/countries');
      _countries = (data as List).map((json) => Country.fromJson(json)).toList();
      for (var i = 0; i < _countries.length; i++) {
        final detail = await ApiClient.get('/countries/${_countries[i].countryId}');
        if (detail['cities'] != null) {
          _countries[i] = Country.fromJson(detail);
        }
      }
      _loaded = true;
    } catch (e) {
      debugPrint('CountryService.loadCountries error: $e');
      _lastError = e.toString();
      _loaded = false;
    }
  }

  static Future<void> reloadCountries() async {
    _loaded = false;
    await loadCountries();
  }

  static List<Country> getAllCountries() {
    return _countries;
  }

  static Country? findCountryByLocation(double lat, double lng) {
    final point = LatLng(lat, lng);
    for (final country in _countries) {
      for (final city in country.cityPins) {
        final cityPoint = city.latLng;
        const double kmToDeg = 1.0 / 111.0;
        final latDelta = 5.0 * kmToDeg;
        final lngDelta = 5.0 * kmToDeg;
        if ((point.latitude >= cityPoint.latitude - latDelta &&
                point.latitude <= cityPoint.latitude + latDelta) &&
            (point.longitude >= cityPoint.longitude - lngDelta &&
                point.longitude <= cityPoint.longitude + lngDelta)) {
          return country;
        }
      }
    }
    return null;
  }

  static int countryIdByName(String name) {
    final idx = _countries.indexWhere((c) => c.name == name);
    return idx >= 0 ? _countries[idx].countryId : 0;
  }

  /// Returns the country id that a city belongs to, or 0 if unknown.
  static int countryIdForCity(int cityId) {
    for (final country in _countries) {
      for (final city in country.cityPins) {
        if (city.cityId == cityId) return country.countryId;
      }
    }
    return 0;
  }

  static String? cityName(int cityId) {
    for (final country in _countries) {
      for (final city in country.cityPins) {
        if (city.cityId == cityId) return city.name;
      }
    }
    return null;
  }

  static void reset() {
    _countries = [];
    _loaded = false;
  }
}
