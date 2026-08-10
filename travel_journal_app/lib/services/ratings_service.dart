import 'package:flutter/foundation.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';
import 'package:pinmap_travel_journal/services/sync_queue_service.dart';

class RatingSummary {
  final double average;
  final int count;
  final int? myRating;

  const RatingSummary({
    required this.average,
    required this.count,
    this.myRating,
  });

  factory RatingSummary.fromJson(Map<String, dynamic> json) {
    return RatingSummary(
      average: (json['average'] as num?)?.toDouble() ?? 0,
      count: (json['count'] as num?)?.toInt() ?? 0,
      myRating: (json['myRating'] as num?)?.toInt(),
    );
  }
}

/// Place and country ratings, cached in memory and queued when offline.
class RatingsService {
  static final Map<int, RatingSummary> _placeCache = {};
  static final Map<int, RatingSummary> _countryCache = {};

  static Future<void> ratePlace(
    int placeId,
    int rating, {
    String? reviewText,
  }) async {
    _placeCache[placeId] = RatingSummary(
      average: _placeCache[placeId]?.average ?? rating.toDouble(),
      count: (_placeCache[placeId]?.count ?? 0) + 1,
      myRating: rating,
    );
    try {
      final data = await ApiClient.post('/ratings', body: {
        'placeId': placeId,
        'rating': rating,
        'reviewText': reviewText,
      });
      _placeCache[placeId] = RatingSummary(
        average: (data['average'] as num).toDouble(),
        count: (data['count'] as num).toInt(),
        myRating: (data['myRating'] as num?)?.toInt() ?? rating,
      );
    } catch (e) {
      debugPrint('RatingsService.ratePlace offline: $e');
      await SyncQueueService.enqueue(SyncAction(
        type: SyncActionType.ratePlace,
        data: {
          'placeId': placeId,
          'rating': rating,
          'reviewText': reviewText,
        },
        timestamp: DateTime.now(),
      ));
    }
  }

  static Future<void> rateCountry(
    int countryId,
    int rating, {
    String? reviewText,
  }) async {
    _countryCache[countryId] = RatingSummary(
      average: _countryCache[countryId]?.average ?? rating.toDouble(),
      count: (_countryCache[countryId]?.count ?? 0) + 1,
      myRating: rating,
    );
    try {
      final data = await ApiClient.post('/ratings', body: {
        'countryId': countryId,
        'rating': rating,
        'reviewText': reviewText,
      });
      _countryCache[countryId] = RatingSummary(
        average: (data['average'] as num).toDouble(),
        count: (data['count'] as num).toInt(),
        myRating: (data['myRating'] as num?)?.toInt() ?? rating,
      );
    } catch (e) {
      debugPrint('RatingsService.rateCountry offline: $e');
      await SyncQueueService.enqueue(SyncAction(
        type: SyncActionType.rateCountry,
        data: {
          'countryId': countryId,
          'rating': rating,
          'reviewText': reviewText,
        },
        timestamp: DateTime.now(),
      ));
    }
  }

  static Future<RatingSummary?> getPlaceRating(int placeId) async {
    if (_placeCache.containsKey(placeId)) return _placeCache[placeId];
    try {
      final data = await ApiClient.get('/ratings/place/$placeId');
      final summary = RatingSummary.fromJson(data);
      _placeCache[placeId] = summary;
      return summary;
    } catch (e) {
      debugPrint('RatingsService.getPlaceRating error: $e');
      return null;
    }
  }

  static Future<RatingSummary?> getCountryRating(int countryId) async {
    if (_countryCache.containsKey(countryId)) {
      return _countryCache[countryId];
    }
    try {
      final data = await ApiClient.get('/ratings/country/$countryId');
      final summary = RatingSummary.fromJson(data);
      _countryCache[countryId] = summary;
      return summary;
    } catch (e) {
      debugPrint('RatingsService.getCountryRating error: $e');
      return null;
    }
  }

  static Future<void> removePlaceRating(int placeId) async {
    _placeCache.remove(placeId);
    try {
      await ApiClient.delete('/ratings/place/$placeId');
    } catch (e) {
      debugPrint('RatingsService.removePlaceRating offline: $e');
      await SyncQueueService.enqueue(SyncAction(
        type: SyncActionType.deletePlaceRating,
        data: {'placeId': placeId},
        timestamp: DateTime.now(),
      ));
    }
  }

  static Future<void> removeCountryRating(int countryId) async {
    _countryCache.remove(countryId);
    try {
      await ApiClient.delete('/ratings/country/$countryId');
    } catch (e) {
      debugPrint('RatingsService.removeCountryRating offline: $e');
      await SyncQueueService.enqueue(SyncAction(
        type: SyncActionType.deleteCountryRating,
        data: {'countryId': countryId},
        timestamp: DateTime.now(),
      ));
    }
  }

  static void reset() {
    _placeCache.clear();
    _countryCache.clear();
  }
}
