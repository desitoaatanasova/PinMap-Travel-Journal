import 'package:flutter/foundation.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';

class VisitedPlacesService {
  static Set<int> _visitedPlaceIds = {};
  static bool _loaded = false;

  static Future<void> loadVisitedPlaces() async {
    if (_loaded) return;
    try {
      final data = await ApiClient.get('/visited/places');
      _visitedPlaceIds = (data as List).map((e) => e['place_id'] as int).toSet();
      _loaded = true;
    } catch (e) {
      debugPrint('VisitedPlacesService.loadVisitedPlaces error: $e');
      _loaded = false;
    }
  }

  static bool isVisited(int placeId) {
    return _visitedPlaceIds.contains(placeId);
  }

  static Future<void> toggleVisited(int placeId, {String? visitDate, String? notes}) async {
    try {
      final data = await ApiClient.post('/visited/places/toggle', body: {
        'placeId': placeId,
        'visitDate': visitDate,
        'notes': notes,
      });
      if (data['visited'] as bool) {
        _visitedPlaceIds.add(placeId);
      } else {
        _visitedPlaceIds.remove(placeId);
      }
    } catch (e) {
      debugPrint('VisitedPlacesService.toggleVisited error: $e');
      if (_visitedPlaceIds.contains(placeId)) {
        _visitedPlaceIds.remove(placeId);
      } else {
        _visitedPlaceIds.add(placeId);
      }
    }
  }
}
