import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class VisitedPlacesService {
  static const String _storageKey = 'visited_places';
  static Set<String> _visitedPlaces = {};
  static bool _loaded = false;

  static Future<void> loadVisitedPlaces() async {
    if (_loaded) return;
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);
    if (jsonString != null) {
      try {
        final List<dynamic> decoded = jsonDecode(jsonString);
        _visitedPlaces = decoded.map((e) => e as String).toSet();
      } catch (e) {
        _visitedPlaces = {};
      }
    }
    _loaded = true;
  }

  static Future<void> _saveVisitedPlaces() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(_visitedPlaces.toList());
    await prefs.setString(_storageKey, jsonString);
  }

  static bool isVisited(String placeName) {
    return _visitedPlaces.contains(placeName);
  }

  static Future<void> toggleVisited(String placeName) async {
    if (_visitedPlaces.contains(placeName)) {
      _visitedPlaces.remove(placeName);
    } else {
      _visitedPlaces.add(placeName);
    }
    await _saveVisitedPlaces();
  }

  static Set<String> getAllVisited() {
    return Set.from(_visitedPlaces);
  }
}
