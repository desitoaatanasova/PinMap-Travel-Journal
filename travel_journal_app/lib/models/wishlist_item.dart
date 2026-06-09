class WishlistItem {
  final int wishlistId;
  final int placeId;
  final String placeName;
  final String? placeImage;
  final String? placeDescription;
  final String? categoryName;
  final String? categoryColor;

  const WishlistItem({
    required this.wishlistId,
    required this.placeId,
    required this.placeName,
    this.placeImage,
    this.placeDescription,
    this.categoryName,
    this.categoryColor,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      wishlistId: json['wishlist_id'] ?? int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      placeId: json['place_id'] ?? 0,
      placeName: json['place_name'] ?? json['name'] ?? '',
      placeImage: json['place_image'] ?? json['image_url'],
      placeDescription: json['place_description'],
      categoryName: json['category_name'],
      categoryColor: json['category_color'],
    );
  }
}
