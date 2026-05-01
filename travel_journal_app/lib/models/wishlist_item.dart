class WishlistItem {
  final String id;
  final String name;
  final String country;
  final String? city;
  final String? imageUrl;
  final String? description;
  final bool isVisited;
  final String type; // 'country', 'city', 'place'
  final String? category;
  final double? latitude;
  final double? longitude;

  const WishlistItem({
    required this.id,
    required this.name,
    required this.country,
    this.city,
    this.imageUrl,
    this.description,
    this.isVisited = false,
    this.type = 'place',
    this.category,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'country': country,
        'city': city,
        'imageUrl': imageUrl,
        'description': description,
        'isVisited': isVisited,
        'type': type,
        'category': category,
        'latitude': latitude,
        'longitude': longitude,
      };

  factory WishlistItem.fromJson(Map<String, dynamic> json) => WishlistItem(
        id: json['id'],
        name: json['name'],
        country: json['country'],
        city: json['city'],
        imageUrl: json['imageUrl'],
        description: json['description'],
        isVisited: json['isVisited'] ?? false,
        type: json['type'] ?? 'place',
        category: json['category'],
        latitude: json['latitude'],
        longitude: json['longitude'],
      );
}
