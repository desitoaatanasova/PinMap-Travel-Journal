import 'package:flutter/foundation.dart';
import 'package:pinmap_travel_journal/services/country_service.dart';
import 'package:pinmap_travel_journal/services/journal_service.dart';
import 'package:pinmap_travel_journal/services/profile_service.dart';
import 'package:pinmap_travel_journal/services/ratings_service.dart';
import 'package:pinmap_travel_journal/services/settings_service.dart';
import 'package:pinmap_travel_journal/services/sync_queue_service.dart';
import 'package:pinmap_travel_journal/services/trip_service.dart';
import 'package:pinmap_travel_journal/services/visited_service.dart';
import 'package:pinmap_travel_journal/services/wishlist_service.dart';

/// Loads all user data after authentication succeeds. All in-memory caches
/// are reset first so switching users never leaks stale data.
class DataLoader {
  static Future<void> resetAll() async {
    CountryService.reset();
    VisitedService.reset();
    WishlistService.reset();
    TripService.reset();
    JournalService.reset();
    ProfileService.reset();
    RatingsService.reset();
    SettingsService.reset();
  }

  static Future<void> resetUserData() async {
    VisitedService.reset();
    WishlistService.reset();
    TripService.reset();
    JournalService.reset();
    ProfileService.reset();
    RatingsService.reset();
    SettingsService.reset();
  }

  static Future<void> loadAll() async {
    await resetAll();
    try {
      await Future.wait([
        CountryService.loadCountries(),
        VisitedService.loadVisited(),
        WishlistService.loadItems(),
        TripService.loadTrips(),
        JournalService.loadJournals(),
      ]);
      await ProfileService.reloadProfile();
      await SettingsService.getSettings();
    } catch (e) {
      debugPrint('DataLoader.loadAll error: $e');
    }
    SyncQueueService.processQueue();
  }
}
