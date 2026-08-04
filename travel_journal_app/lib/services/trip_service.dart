import 'package:flutter/foundation.dart';
import 'package:pinmap_travel_journal/models/trip.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';

class TripService {
  static List<Trip> _trips = [];
  static bool _loaded = false;

  static Future<void> loadTrips() async {
    if (_loaded) return;
    try {
      final data = await ApiClient.get('/trips');
      _trips = (data as List).map((json) => Trip.fromJson(json)).toList();
      _loaded = true;
    } catch (e) {
      debugPrint('TripService.loadTrips error: $e');
      _loaded = false;
    }
  }

  static Future<void> reloadTrips() async {
    try {
      final data = await ApiClient.get('/trips');
      _trips = (data as List).map((json) => Trip.fromJson(json)).toList();
    } catch (e) {
      debugPrint('TripService.reloadTrips error: $e');
    }
  }

  static Trip? getTripById(int id) {
    try {
      return _trips.firstWhere((trip) => trip.tripId == id);
    } catch (e) {
      return null;
    }
  }

  static List<Trip> getAllTrips() => _trips;

  static Future<void> addTrip(Trip trip) async {
    try {
      final data = await ApiClient.post('/trips', body: trip.toJson());
      final newTrip = Trip(
        tripId: data['id'] is int ? data['id'] : int.tryParse(data['id'].toString()) ?? 0,
        title: trip.title,
        countryId: trip.countryId,
        startDate: trip.startDate,
        endDate: trip.endDate,
        tripType: trip.tripType,
        travelStyle: trip.travelStyle,
        itinerary: trip.itinerary,
      );
      _trips.add(newTrip);
    } catch (e) {
      debugPrint('TripService.addTrip error: $e');
    }
  }

  static Future<void> deleteTrip(int id) async {
    try {
      await ApiClient.delete('/trips/$id');
      _trips.removeWhere((trip) => trip.tripId == id);
    } catch (e) {
      debugPrint('TripService.deleteTrip error: $e');
    }
  }
}
