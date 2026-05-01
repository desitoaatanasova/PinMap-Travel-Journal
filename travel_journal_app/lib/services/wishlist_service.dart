import 'package:flutter/material.dart';
import 'package:travel_journal_app/models/wishlist_item.dart';

class WishlistService {
  static List<WishlistItem> getAllItems() {
    return _mockItems;
  }

  static void removeItem(String id) {
    _mockItems.removeWhere((item) => item.id == id);
  }

  static void toggleVisited(String id) {
    final index = _mockItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      final item = _mockItems[index];
      _mockItems[index] = WishlistItem(
        id: item.id,
        name: item.name,
        country: item.country,
        city: item.city,
        imageUrl: item.imageUrl,
        description: item.description,
        isVisited: !item.isVisited,
      );
    }
  }

  static Map<String, List<WishlistItem>> getItemsByCountry() {
    final grouped = <String, List<WishlistItem>>{};
    for (final item in _mockItems) {
      grouped.putIfAbsent(item.country, () => []).add(item);
    }
    return grouped;
  }

  static final List<WishlistItem> _mockItems = [
    WishlistItem(
      id: 'paris-eiffel',
      name: 'Eiffel Tower',
      country: 'France',
      city: 'Paris',
      imageUrl: 'https://picsum.photos/seed/eiffel/400/300',
      description: 'Iconic iron lattice tower on the Champ de Mars',
    ),
    WishlistItem(
      id: 'paris-louvre',
      name: 'Louvre Museum',
      country: 'France',
      city: 'Paris',
      imageUrl: 'https://picsum.photos/seed/louvre/400/300',
      description: 'World\'s largest art museum',
    ),
    WishlistItem(
      id: 'tokyo-shibuya',
      name: 'Shibuya Crossing',
      country: 'Japan',
      city: 'Tokyo',
      imageUrl: 'https://picsum.photos/seed/shibuya/400/300',
      description: 'Busiest pedestrian crossing in the world',
    ),
    WishlistItem(
      id: 'tokyo-sensoji',
      name: 'Senso-ji Temple',
      country: 'Japan',
      city: 'Tokyo',
      imageUrl: 'https://picsum.photos/seed/sensoji/400/300',
      description: 'Tokyo\'s oldest temple',
    ),
    WishlistItem(
      id: 'rome-colosseum',
      name: 'Colosseum',
      country: 'Italy',
      city: 'Rome',
      imageUrl: 'https://picsum.photos/seed/colosseum/400/300',
      description: 'Ancient amphitheatre, icon of Rome',
      isVisited: true,
    ),
    WishlistItem(
      id: 'nyc-liberty',
      name: 'Statue of Liberty',
      country: 'USA',
      city: 'New York',
      imageUrl: 'https://picsum.photos/seed/liberty/400/300',
      description: 'Iconic symbol of freedom',
    ),
    WishlistItem(
      id: 'sydney-opera',
      name: 'Sydney Opera House',
      country: 'Australia',
      city: 'Sydney',
      imageUrl: 'https://picsum.photos/seed/opera/400/300',
      description: 'Multi-venue performing arts center',
    ),
  ];
}
