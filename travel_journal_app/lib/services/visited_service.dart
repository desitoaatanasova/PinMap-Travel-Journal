import 'package:flutter/foundation.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';
import 'package:pinmap_travel_journal/services/sync_queue_service.dart';

/// Tracks explicitly visited places, cities and countries.
///
/// Marking a place visited cascades upward (place -> city -> country).
/// Unmarking removes only the tapped level, never lower levels. When the
/// device is offline, changes are mirrored locally and queued for sync.
class VisitedService {
  static Set<int> _placeIds = {};
  static Set<int> _cityIds = {};
  static Set<int> _countryIds = {};
  static bool _loaded = false;

  static Future<void> loadVisited() async {
    if (_loaded) return;
    await _fetchAll();
  }

  static Future<void> reloadVisited() async {
    _loaded = false;
    await _fetchAll();
  }

  static Future<void> _fetchAll() async {
    try {
      final places = await ApiClient.get('/visited/places');
      final cities = await ApiClient.get('/visited/cities');
      final countries = await ApiClient.get('/visited/countries');
      _placeIds = (places as List)
          .map((e) => (e['place_id'] as num).toInt())
          .toSet();
      _cityIds =
          (cities as List).map((e) => (e['city_id'] as num).toInt()).toSet();
      _countryIds = (countries as List)
          .map((e) => (e['country_id'] as num).toInt())
          .toSet();
      _loaded = true;
    } catch (e) {
      debugPrint('VisitedService._fetchAll error: $e');
      _loaded = false;
    }
  }

  static void reset() {
    _placeIds = {};
    _cityIds = {};
    _countryIds = {};
    _loaded = false;
  }

  static bool isPlaceVisited(int placeId) => _placeIds.contains(placeId);
  static bool isCityVisited(int cityId) => _cityIds.contains(cityId);
  static bool isCountryVisited(int countryId) => _countryIds.contains(countryId);

  static Set<int> get visitedPlaceIds => Set.unmodifiable(_placeIds);
  static Set<int> get visitedCityIds => Set.unmodifiable(_cityIds);
  static Set<int> get visitedCountryIds => Set.unmodifiable(_countryIds);

  static void _addIfValid(Set<int> set, dynamic raw) {
    final id = raw == null ? 0 : (raw as num).toInt();
    if (id > 0) set.add(id);
  }

  static Future<void> togglePlace(
    int placeId, {
    int? cityId,
    int? countryId,
    String? visitDate,
    String? notes,
  }) async {
    final nowVisited = !_placeIds.contains(placeId);
    if (nowVisited) {
      _placeIds.add(placeId);
      if (cityId != null && cityId > 0) _cityIds.add(cityId);
      if (countryId != null && countryId > 0) _countryIds.add(countryId);
    } else {
      // Unmarking removes only the place level.
      _placeIds.remove(placeId);
    }
    try {
      final data = await ApiClient.post('/visited/places/toggle', body: {
        'placeId': placeId,
        'visited': nowVisited,
        'visitDate': visitDate,
        'notes': notes,
      });
      if (data['visited'] == true) {
        _placeIds.add(placeId);
        _addIfValid(_cityIds, data['cityId']);
        _addIfValid(_countryIds, data['countryId']);
      } else {
        _placeIds.remove(placeId);
      }
    } catch (e) {
      debugPrint('VisitedService.togglePlace offline: $e');
      await SyncQueueService.enqueue(SyncAction(
        type: SyncActionType.toggleVisited,
        data: {
          'placeId': placeId,
          'visited': nowVisited,
          'visitDate': visitDate,
          'notes': notes,
        },
        timestamp: DateTime.now(),
      ));
    }
  }

  static Future<void> toggleCity(
    int cityId, {
    int? countryId,
    String? visitDate,
    String? notes,
  }) async {
    final nowVisited = !_cityIds.contains(cityId);
    if (nowVisited) {
      _cityIds.add(cityId);
      if (countryId != null && countryId > 0) _countryIds.add(countryId);
    } else {
      _cityIds.remove(cityId);
    }
    try {
      final data = await ApiClient.post('/visited/cities/toggle', body: {
        'cityId': cityId,
        'visited': nowVisited,
        'visitDate': visitDate,
        'notes': notes,
      });
      if (data['visited'] == true) {
        _cityIds.add(cityId);
        _addIfValid(_countryIds, data['countryId']);
      } else {
        _cityIds.remove(cityId);
      }
    } catch (e) {
      debugPrint('VisitedService.toggleCity offline: $e');
      await SyncQueueService.enqueue(SyncAction(
        type: SyncActionType.toggleCityVisited,
        data: {
          'cityId': cityId,
          'visited': nowVisited,
          'visitDate': visitDate,
          'notes': notes,
        },
        timestamp: DateTime.now(),
      ));
    }
  }

  static Future<void> toggleCountry(
    int countryId, {
    String? visitDate,
    String? notes,
  }) async {
    final nowVisited = !_countryIds.contains(countryId);
    if (nowVisited) {
      _countryIds.add(countryId);
    } else {
      _countryIds.remove(countryId);
    }
    try {
      final data = await ApiClient.post('/visited/countries/toggle', body: {
        'countryId': countryId,
        'visited': nowVisited,
        'visitDate': visitDate,
        'notes': notes,
      });
      if (data['visited'] == true) {
        _countryIds.add(countryId);
      } else {
        _countryIds.remove(countryId);
      }
    } catch (e) {
      debugPrint('VisitedService.toggleCountry offline: $e');
      await SyncQueueService.enqueue(SyncAction(
        type: SyncActionType.toggleCountryVisited,
        data: {
          'countryId': countryId,
          'visited': nowVisited,
          'visitDate': visitDate,
          'notes': notes,
        },
        timestamp: DateTime.now(),
      ));
    }
  }
}
