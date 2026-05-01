import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pinmap_travel_journal/models/wishlist_item.dart';

class WishlistService {
  static const _storageKey = 'wishlist_items';
  static List<WishlistItem> _items = [];
  static bool _loaded = false;

  static Future<void> loadItems() async {
    if (_loaded) return;
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      _items = jsonList.map((e) => WishlistItem.fromJson(e)).toList();
    }
    _loaded = true;
  }

  static Future<void> _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(_items.map((e) => e.toJson()).toList());
    await prefs.setString(_storageKey, jsonString);
  }

  static List<WishlistItem> getAllItems() {
    return List<WishlistItem>.from(_items);
  }

  static Future<void> addItem(WishlistItem item) async {
    if (_items.any((e) => e.id == item.id)) return;
    _items.add(item);
    await _saveItems();
  }

  static Future<void> removeItem(String id) async {
    _items.removeWhere((item) => item.id == id);
    await _saveItems();
  }

  static Future<void> toggleVisited(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      final item = _items[index];
      _items[index] = WishlistItem(
        id: item.id,
        name: item.name,
        country: item.country,
        city: item.city,
        imageUrl: item.imageUrl,
        description: item.description,
        isVisited: !item.isVisited,
        type: item.type,
        category: item.category,
        latitude: item.latitude,
        longitude: item.longitude,
      );
      await _saveItems();
    }
  }

  static Map<String, List<WishlistItem>> getItemsByCountry() {
    final grouped = <String, List<WishlistItem>>{};
    for (final item in _items) {
      grouped.putIfAbsent(item.country, () => []).add(item);
    }
    return grouped;
  }

  static bool isInWishlist(String id) {
    return _items.any((item) => item.id == id);
  }
}
