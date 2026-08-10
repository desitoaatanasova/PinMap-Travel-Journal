import 'package:flutter/foundation.dart';
import 'package:pinmap_travel_journal/models/wishlist_item.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';
import 'package:pinmap_travel_journal/services/sync_queue_service.dart';

class WishlistService {
  static List<WishlistItem> _items = [];
  static bool _loaded = false;

  static Future<void> loadItems() async {
    if (_loaded) return;
    try {
      final data = await ApiClient.get('/wishlist');
      _items = (data as List).map((json) => WishlistItem.fromJson(json)).toList();
      _loaded = true;
    } catch (e) {
      debugPrint('WishlistService.loadItems error: $e');
      _loaded = false;
    }
  }

  static Future<void> reloadItems() async {
    try {
      final data = await ApiClient.get('/wishlist');
      _items = (data as List).map((json) => WishlistItem.fromJson(json)).toList();
    } catch (e) {
      debugPrint('WishlistService.reloadItems error: $e');
    }
  }

  static Future<void> addItem(int placeId) async {
    if (_items.any((e) => e.placeId == placeId)) return;
    try {
      final data = await ApiClient.post('/wishlist', body: {
        'placeId': placeId,
      });
      final newItem = WishlistItem(
        wishlistId: data['id'] is int ? data['id'] : int.tryParse(data['id'].toString()) ?? 0,
        placeId: placeId,
        name: '',
      );
      _items.add(newItem);
      await reloadItems();
    } catch (e) {
      debugPrint('WishlistService.addItem offline: $e');
      _items.add(WishlistItem(
        wishlistId: -placeId,
        placeId: placeId,
        name: '',
      ));
      await SyncQueueService.enqueue(SyncAction(
        type: SyncActionType.addWishlist,
        data: {'placeId': placeId},
        timestamp: DateTime.now(),
      ));
    }
  }

  static Future<void> removeItem(int wishlistId) async {
    _items.removeWhere((item) => item.wishlistId == wishlistId);
    if (wishlistId <= 0) {
      // Unsynced optimistic item — the server never saw the add.
      return;
    }
    try {
      await ApiClient.delete('/wishlist/$wishlistId');
    } catch (e) {
      debugPrint('WishlistService.removeItem offline: $e');
      await SyncQueueService.enqueue(SyncAction(
        type: SyncActionType.removeWishlist,
        data: {'id': wishlistId},
        timestamp: DateTime.now(),
      ));
    }
  }

  static bool isInWishlist(int placeId) {
    return _items.any((item) => item.placeId == placeId);
  }

  static Future<void> addCountry(int countryId) async {
    if (_items.any((e) => e.countryId == countryId)) return;
    try {
      final data = await ApiClient.post('/wishlist', body: {
        'countryId': countryId,
      });
      final newItem = WishlistItem(
        wishlistId: data['id'] is int ? data['id'] : int.tryParse(data['id'].toString()) ?? 0,
        countryId: countryId,
        name: '',
        type: 'country',
      );
      _items.add(newItem);
      await reloadItems();
    } catch (e) {
      debugPrint('WishlistService.addCountry offline: $e');
      _items.add(WishlistItem(
        wishlistId: -countryId,
        countryId: countryId,
        name: '',
        type: 'country',
      ));
      await SyncQueueService.enqueue(SyncAction(
        type: SyncActionType.addWishlist,
        data: {'countryId': countryId},
        timestamp: DateTime.now(),
      ));
    }
  }

  static bool isCountryInWishlist(int countryId) {
    return _items.any((item) => item.countryId == countryId);
  }

  static List<WishlistItem> getAllItems() => _items;

  static Future<void> removeCountry(int countryId) async {
    final item = _items.firstWhere(
      (e) => e.countryId == countryId,
      orElse: () => const WishlistItem(wishlistId: 0, name: ''),
    );
    if (item.wishlistId == 0) return;
    await removeItem(item.wishlistId);
  }

  static void reset() {
    _items = [];
    _loaded = false;
  }
}
