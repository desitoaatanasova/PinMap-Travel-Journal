import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:pinmap_travel_journal/models/trip.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';
import 'package:pinmap_travel_journal/services/sync_queue_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TripService {
  static List<Trip> _trips = [];
  static bool _loaded = false;
  static const String _legacyDraftKey = 'ai_trip_draft';

  static String _draftKey() {
    final uid = SyncQueueService.activeUserId;
    if (uid != null) return 'ai_trip_draft_$uid';
    return _legacyDraftKey;
  }

  static String _scopedDraftKey() => _draftKey();

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

  static String _clientIdFor(Trip trip) => 'c_${trip.tripId}_${trip.startDate.millisecondsSinceEpoch}';

  static Future<void> addTrip(Trip trip) async {
    final clientId = _clientIdFor(trip);
    final body = trip.toJson();
    body['clientId'] = clientId;
    body['id'] = trip.tripId;
    try {
      final data = await ApiClient.post('/trips', body: body);
      final serverId = data['id'] is int ? data['id'] : int.tryParse(data['id'].toString()) ?? 0;
      final newTrip = trip.copyWith(tripId: serverId);
      _trips.add(newTrip);
    } catch (e) {
      debugPrint('TripService.addTrip offline: $e');
      _trips.add(trip);
      await SyncQueueService.enqueue(SyncAction(
        type: SyncActionType.addTrip,
        data: body,
        timestamp: DateTime.now(),
      ));
    }
  }

  static Future<void> deleteTrip(int id) async {
    try {
      await ApiClient.delete('/trips/$id');
      _trips.removeWhere((trip) => trip.tripId == id);
    } catch (e) {
      debugPrint('TripService.deleteTrip offline: $e');
      _trips.removeWhere((trip) => trip.tripId == id);
      await SyncQueueService.enqueue(SyncAction(
        type: SyncActionType.deleteTrip,
        data: {'id': id},
        timestamp: DateTime.now(),
      ));
    }
  }

  static Future<void> updateTrip(Trip trip) async {
    final idx = _trips.indexWhere((t) => t.tripId == trip.tripId);
    if (idx >= 0) {
      _trips[idx] = trip;
    } else {
      _trips.add(trip);
    }
    final body = trip.toJson();
    body['id'] = trip.tripId;
    try {
      await ApiClient.put('/trips/${trip.tripId}', body: body);
    } catch (e) {
      debugPrint('TripService.updateTrip offline: $e');
      await SyncQueueService.enqueue(SyncAction(
        type: SyncActionType.updateTrip,
        data: body,
        timestamp: DateTime.now(),
      ));
    }
  }

  /// Asks the server (Gemini) to generate an itinerary draft.
  /// The returned trip has trip_id == 0 and is NOT saved to the database yet.
  static Future<Trip> generateTrip({
    required int countryId,
    String countryName = '',
    required int numberOfDays,
    required DateTime startDate,
    required DateTime endDate,
    required String tripType,
    required String travelStyle,
    List<int> cityIds = const [],
    List<String> cityNames = const [],
    String? arrivalCity,
    String? departureCity,
    List<TripParticipant> participants = const [],
  }) async {
    final data = await ApiClient.post('/ai/generate-trip', body: {
      'countryId': countryId,
      'countryName': countryName,
      'numberOfDays': numberOfDays,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'tripType': tripType,
      'travelStyle': travelStyle,
      'cityIds': cityIds,
      'cityNames': cityNames,
      'arrivalCity': arrivalCity,
      'departureCity': departureCity,
      'participants': participants
          .map((p) => {
                'userId': p.userId,
                'username': p.username,
                'name': p.displayName,
              })
          .toList(),
    });
    return Trip.fromJson(data as Map<String, dynamic>);
  }

  /// Persists a generated draft to the database, clears the stored draft,
  /// and adds the new trip to the in-memory list.
  static Future<Trip> saveDraftTrip(Trip draft) async {
    final data = await ApiClient.post('/trips', body: draft.toJson());
    final id = data['id'] is int
        ? data['id']
        : int.tryParse(data['id'].toString()) ?? 0;
    final saved = draft.copyWith(tripId: id);
    final idx = _trips.indexWhere((t) => t.tripId == id);
    if (idx >= 0) {
      _trips[idx] = saved;
    } else {
      _trips.add(saved);
    }
    await clearDraft();
    return saved;
  }

  /// Persists the AI draft locally so it survives navigation/app restarts.
  static Future<void> saveDraft(Trip draft) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_scopedDraftKey(), jsonEncode(_toApiJson(draft)));
  }

  static Future<Trip?> loadDraft() async {
    final prefs = await SharedPreferences.getInstance();
    final key = _scopedDraftKey();
    String? raw = prefs.getString(key);
    if (raw == null && key != _legacyDraftKey) {
      raw = prefs.getString(_legacyDraftKey);
      if (raw != null) {
        try {
          await prefs.setString(key, raw);
        } catch (_) {}
        await prefs.remove(_legacyDraftKey);
      }
    }
    if (raw == null) return null;
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return Trip.fromJson(json);
    } catch (e) {
      debugPrint('TripService.loadDraft error: $e');
      return null;
    }
  }

  static Future<void> clearDraft() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_scopedDraftKey());
    if (_scopedDraftKey() != _legacyDraftKey) {
      await prefs.remove(_legacyDraftKey);
    }
  }

  static Map<String, dynamic> _toApiJson(Trip trip) {
    return {
      'trip_id': trip.tripId,
      'title': trip.title,
      'country_id': trip.countryId,
      'start_date': trip.startDate.toIso8601String(),
      'end_date': trip.endDate.toIso8601String(),
      'trip_type': trip.tripType,
      'travel_style': trip.travelStyle,
      'number_of_days': trip.numberOfDays,
      'arrival_city': trip.arrivalCity,
      'departure_city': trip.departureCity,
      'city_ids': trip.cityIds,
      'participant_ids': trip.participants.map((p) => p.userId).toList(),
      'itinerary': trip.itinerary
          .map((d) => {
                'day_number': d.dayNumber,
                'date': d.date,
                'morning': d.morning.map(_activityToApi).toList(),
                'afternoon': d.afternoon.map(_activityToApi).toList(),
                'evening': d.evening.map(_activityToApi).toList(),
              })
          .toList(),
    };
  }

  static Map<String, dynamic> _activityToApi(TripActivity a) {
    return {
      'place_id': a.placeId,
      'place_name': a.placeName,
      'place_image': a.placeImage,
      'time_slot': a.timeSlot,
      'notes': a.notes,
      'latitude': a.latitude,
      'longitude': a.longitude,
      'category_id': a.categoryId,
      'city_name': a.cityName,
    };
  }

  static void reset() {
    _trips = [];
    _loaded = false;
  }
}
