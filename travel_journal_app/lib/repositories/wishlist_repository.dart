import '../models/wishlist_item.dart';

abstract class WishlistRepository {
  Future<List<WishlistItem>> getAllItems();
  Future<Map<String, List<WishlistItem>>> getItemsByCountry();
  Future<bool> isInWishlist(String id);
  Future<void> addItem(WishlistItem item);
  Future<void> removeItem(String id);
  Future<void> toggleVisited(String id);
}
