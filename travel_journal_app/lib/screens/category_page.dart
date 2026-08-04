import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinmap_travel_journal/models/place.dart';
import 'package:pinmap_travel_journal/services/place_service.dart';
import 'package:pinmap_travel_journal/services/wishlist_service.dart';
import 'package:pinmap_travel_journal/services/visited_places_service.dart';
import 'package:pinmap_travel_journal/screens/place_details_page.dart';
import 'package:pinmap_travel_journal/widgets/section_header.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;
  final String cityName;
  final String countryName;

  const CategoryPage({
    super.key,
    required this.categoryName,
    required this.cityName,
    required this.countryName,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Future<List<Place>>? _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = PlaceService.getPlacesForCategory(
        widget.categoryName, widget.cityName);
  }

  void _toggleVisited(int placeId) async {
    await VisitedPlacesService.toggleVisited(placeId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final categoryColor = _getCategoryColor(widget.categoryName);

    return Scaffold(
      backgroundColor: AppTheme.bg,
      extendBody: true,
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: GoogleFonts.playfairDisplay(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppTheme.darkBrown,
          ),
        ),
        backgroundColor: AppTheme.bg.withValues(alpha: 0.8),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppTheme.space4, AppTheme.space4, AppTheme.space4, AppTheme.space2),
            child: Text(
              '${widget.cityName}, ${widget.countryName}',
              style: GoogleFonts.dancingScript(
                fontSize: 18,
                color: AppTheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.space4),
            child: const SectionHeader(title: 'Places'),
          ),
          Expanded(
            child: FutureBuilder<List<Place>>(
              future: _placesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final places = snapshot.data ?? [];
                return ListView.builder(
                  padding: const EdgeInsets.all(AppTheme.space4),
                  itemCount: places.length,
                  itemBuilder: (context, index) {
                    final place = places[index];
                    final isVisited =
                        VisitedPlacesService.isVisited(place.placeId);
                    return _buildPlaceCard(
                        context, place, isVisited, categoryColor);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String categoryName) {
    switch (categoryName) {
      case 'Historical Sights':
        return const Color(0xFF8B4513);
      case 'For the Art Lovers':
        return const Color(0xFF008080);
      case 'Atmosphere & experience':
        return const Color(0xFFDAA520);
      case 'Hidden Gems':
        return const Color(0xFF8A2BE2);
      case 'Close by':
        return const Color(0xFF228B22);
      case 'My places':
        return const Color(0xFFDC143C);
      default:
        return AppTheme.primary;
    }
  }

  Widget _buildPlaceCard(
      BuildContext context, Place place, bool isVisited, Color categoryColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.space4),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: AppTheme.shadowMd,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlaceDetailsPage(
                  place: place,
                  categoryName: widget.categoryName,
                  cityName: widget.cityName,
                  countryName: widget.countryName,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.space4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildThumbnail(place, categoryColor),
                const SizedBox(width: AppTheme.space4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              place.name,
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.darkBrown,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              WishlistService.isInWishlist(place.placeId)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color:
                                  WishlistService.isInWishlist(place.placeId)
                                      ? Colors.redAccent
                                      : AppTheme.warmGray,
                              size: 20,
                            ),
                            onPressed: () async {
                              final inWish =
                                  WishlistService.isInWishlist(place.placeId);
                              if (inWish) {
                                final item = WishlistService.getAllItems()
                                    .where((i) => i.placeId == place.placeId)
                                    .firstOrNull;
                                if (item != null) {
                                  await WishlistService.removeItem(
                                      item.wishlistId);
                                }
                              } else {
                                await WishlistService.addItem(place.placeId);
                              }
                              setState(() {});
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      inWish
                                          ? '${place.name} removed from wishlist'
                                          : '${place.name} added to wishlist',
                                    ),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          const SizedBox(width: 4),
                          if (isVisited)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppTheme.space2,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.15),
                                borderRadius:
                                    BorderRadius.circular(AppTheme.radiusFull),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    size: 14,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Visited',
                                    style: GoogleFonts.dmSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.space1),
                      if (place.shortDescription != null)
                        Text(
                          place.shortDescription!,
                          style: GoogleFonts.dmSans(
                            fontSize: 13,
                            color: AppTheme.warmGray,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      const SizedBox(height: AppTheme.space2),
                      GestureDetector(
                        onTap: () => _toggleVisited(place.placeId),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.space3,
                            vertical: AppTheme.space1,
                          ),
                          decoration: BoxDecoration(
                            color: isVisited
                                ? Colors.green.withValues(alpha: 0.1)
                                : categoryColor.withValues(alpha: 0.1),
                            borderRadius:
                                BorderRadius.circular(AppTheme.radiusFull),
                            border: Border.all(
                              color: isVisited
                                  ? Colors.green.withValues(alpha: 0.3)
                                  : categoryColor.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            isVisited ? 'Visited' : 'Mark visited',
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color:
                                  isVisited ? Colors.green : categoryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail(Place place, Color categoryColor) {
    final imageUrl = place.imageCover ??
        (place.photos.isNotEmpty ? place.photos.first.imageUrl : null);
    if (imageUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
          placeholder: (context, url) => _buildPlaceholder(categoryColor, place),
          errorWidget: (context, url, error) =>
              _buildPlaceholder(categoryColor, place),
        ),
      );
    }
    return _buildPlaceholder(categoryColor, place);
  }

  Widget _buildPlaceholder(Color categoryColor, Place place) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: categoryColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      child: Icon(
        Place.iconFromString(place.categoryIcon),
        color: categoryColor,
        size: 32,
      ),
    );
  }
}
