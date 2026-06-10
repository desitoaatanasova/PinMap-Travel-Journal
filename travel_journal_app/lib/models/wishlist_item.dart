class WishlistItem {
  final int wishlistId;
  final int? placeId;
  final int? countryId;
  final String name;
  final String? image;
  final String? description;
  final String? categoryName;
  final String? categoryColor;
  final String type;

  const WishlistItem({
    required this.wishlistId,
    this.placeId,
    this.countryId,
    required this.name,
    this.image,
    this.description,
    this.categoryName,
    this.categoryColor,
    this.type = 'place',
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      wishlistId: json['wishlist_id'] ?? int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      placeId: json['place_id'],
      countryId: json['country_id'],
      name: json['name'] ?? '',
      image: json['image'] ?? json['image_url'],
      description: json['description'],
      categoryName: json['category_name'],
      categoryColor: json['category_color'],
      type: json['type'] ?? 'place',
    );
  }
}
