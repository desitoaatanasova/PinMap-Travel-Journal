import 'package:flutter/foundation.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';
import 'package:pinmap_travel_journal/services/country_service.dart';
import 'package:pinmap_travel_journal/services/journal_service.dart';
import 'package:pinmap_travel_journal/services/profile_service.dart';
import 'package:pinmap_travel_journal/services/ratings_service.dart';
import 'package:pinmap_travel_journal/services/settings_service.dart';
import 'package:pinmap_travel_journal/services/sync_queue_service.dart';
import 'package:pinmap_travel_journal/services/trip_service.dart';
import 'package:pinmap_travel_journal/services/visited_service.dart';
import 'package:pinmap_travel_journal/services/wishlist_service.dart';

/// Structured result of the initial post-auth data load.
///
/// Non-critical partial failures (e.g. trips offline) are reported in
/// [failed] and must NOT block navigation to /home — the UI surfaces a
/// retry instead. Only [criticalOk] == false blocks navigation.
class InitialLoadResult {
  final bool criticalOk;
  final List<String> failed;

  const InitialLoadResult({required this.criticalOk, this.failed = const []});

  bool get allowHome => criticalOk;
  bool get hasPartial => failed.isNotEmpty;
}

/// Lifecycle coordinator for per-user data. Owns the activate/deactivate/
/// load/clear sequence but contains no business logic itself.
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

  /// User A logs in: clear any previous user's cache, then activate.
  static Future<void> activateUser(int userId) async {
    await resetUserData();
    SyncQueueService.clearAuthPause();
    await SyncQueueService.activateUser(userId);
  }

  /// User logs out: persist the queue, then clear ALL user-specific memory.
  static Future<void> deactivateUser() async {
    await SyncQueueService.deactivateUser();
    await resetUserData();
  }

  static Future<void> clearUserData() => resetUserData();

  static Future<void> _guard(
    String name,
    Future<void> Function() load,
    List<String> failed,
  ) async {
    try {
      await load();
    } catch (e) {
      debugPrint('DataLoader.loadInitialData $name failed: $e');
      failed.add(name);
    }
  }

  /// Loads all post-auth data. Individual service failures are collected
  /// into [InitialLoadResult.failed]; only a lost auth session
  /// (logout raced the load) yields criticalOk == false.
  static Future<InitialLoadResult> loadInitialData() async {
    await resetAll();
    final failed = <String>[];
    await Future.wait([
      _guard('countries', CountryService.loadCountries, failed),
      _guard('visited', VisitedService.loadVisited, failed),
      _guard('wishlist', WishlistService.loadItems, failed),
      _guard('trips', TripService.loadTrips, failed),
      _guard('journals', JournalService.loadJournals, failed),
    ]);
    await _guard('profile', ProfileService.reloadProfile, failed);
    await _guard('settings', () async {
      await SettingsService.getSettings();
    }, failed);
    try {
      await SyncQueueService.processQueue();
    } catch (e) {
      debugPrint('DataLoader.loadInitialData processQueue failed: $e');
    }
    var criticalOk = true;
    try {
      if (await ApiClient.getToken() == null) criticalOk = false;
    } catch (e) {
      debugPrint('DataLoader.loadInitialData token check failed: $e');
      criticalOk = false;
    }
    return InitialLoadResult(criticalOk: criticalOk, failed: failed);
  }
}
