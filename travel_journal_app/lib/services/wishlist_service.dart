import 'package:pinmap_travel_journal/models/wishlist_item.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';

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
      _loaded = false;
    }
  }

  static Future<void> reloadItems() async {
    try {
      final data = await ApiClient.get('/wishlist');
      _items = (data as List).map((json) => WishlistItem.fromJson(json)).toList();
    } catch (_) {}
  }

  static List<WishlistItem> getAllItems() {
    return List.from(_items);
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
        placeName: '',
      );
      _items.add(newItem);
      await reloadItems();
    } catch (_) {}
  }

  static Future<void> removeItem(int wishlistId) async {
    try {
      await ApiClient.delete('/wishlist/$wishlistId');
      _items.removeWhere((item) => item.wishlistId == wishlistId);
    } catch (_) {}
  }

  static bool isInWishlist(int placeId) {
    return _items.any((item) => item.placeId == placeId);
  }
}
