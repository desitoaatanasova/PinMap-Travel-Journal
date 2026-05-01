import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_journal_app/models/place.dart';
import 'package:travel_journal_app/models/wishlist_item.dart';
import 'package:travel_journal_app/services/marker_service.dart';
import 'package:travel_journal_app/services/wishlist_service.dart';
import 'package:travel_journal_app/widgets/section_header.dart';
import 'package:travel_journal_app/widgets/custom_marker.dart';
import 'package:travel_journal_app/theme/app_theme.dart';

class PlaceDetailsPage extends StatefulWidget {
  final Place place;
  final String categoryName;
  final String cityName;
  final String countryName;

  const PlaceDetailsPage({
    super.key,
    required this.place,
    required this.categoryName,
    required this.cityName,
    required this.countryName,
  });

  @override
  State<PlaceDetailsPage> createState() => _PlaceDetailsPageState();
}

class _PlaceDetailsPageState extends State<PlaceDetailsPage> {
  bool _isVisited = false;
  bool _isInWishlist = false;

  @override
  void initState() {
    super.initState();
    _isInWishlist = WishlistService.isInWishlist(widget.place.name);
  }

  Future<void> _toggleWishlist() async {
    if (_isInWishlist) {
      await WishlistService.removeItem(widget.place.name);
    } else {
      await WishlistService.addItem(WishlistItem(
        id: widget.place.name,
        name: widget.place.name,
        country: widget.countryName,
        city: widget.cityName,
        imageUrl: widget.place.imageUrls.isNotEmpty
            ? widget.place.imageUrls.first
            : null,
        category: widget.categoryName,
        type: 'place',
        latitude: widget.place.latitude,
        longitude: widget.place.longitude,
      ));
    }
    setState(() {
      _isInWishlist = !_isInWishlist;
    });
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isInWishlist
                ? '${widget.place.name} added to wishlist'
                : '${widget.place.name} removed from wishlist',
            style: GoogleFonts.dmSans(),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  LatLng get _placeLocation {
    if (widget.place.latitude != null && widget.place.longitude != null) {
      return LatLng(widget.place.latitude!, widget.place.longitude!);
    }
    return const LatLng(48.8566, 2.3522);
  }

  @override
  Widget build(BuildContext context) {
    final place = widget.place;
    final categoryColor = place.placeholderColor;

    return Scaffold(
      backgroundColor: AppTheme.bg,
      extendBody: true,
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Text(
                place.name,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkBrown,
                ),
              ),
            ),
            if (_isVisited)
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 28,
              ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isInWishlist ? Icons.favorite : Icons.favorite_border,
              color: _isInWishlist ? Colors.redAccent : AppTheme.warmGray,
            ),
            onPressed: _toggleWishlist,
          ),
        ],
        backgroundColor: AppTheme.bg.withValues(alpha: 0.8),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPhotoCarousel(place),
            const SizedBox(height: AppTheme.space4),
            _buildCategoryBadge(context, categoryColor, widget.categoryName),
            const SizedBox(height: AppTheme.space4),
            _buildPlaceNameAndLocation(place),
            const SizedBox(height: AppTheme.space6),
            if (place.description.isNotEmpty) ...[
              const SectionHeader(title: 'About this place'),
              const SizedBox(height: AppTheme.space3),
              Text(
                place.description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                    ),
              ),
              const SizedBox(height: AppTheme.space6),
            ],
            const SectionHeader(title: 'Location'),
            const SizedBox(height: AppTheme.space3),
            _buildMapPreview(place, categoryColor),
            const SizedBox(height: AppTheme.space8),
            _buildVisitedButton(categoryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoCarousel(Place place) {
    if (place.imageUrls.isNotEmpty) {
      return SizedBox(
        height: 280,
        child: PageView.builder(
          itemCount: place.imageUrls.length,
          controller: PageController(viewportFraction: 0.9),
          itemBuilder: (context, index) {
            final url = place.imageUrls[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: AppTheme.space1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                boxShadow: AppTheme.shadowMd,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: place.placeholderColor.withValues(alpha: 0.3),
                      child: Icon(
                        place.placeholderIcon,
                        size: 80,
                        color: place.placeholderColor,
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      );
    }
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: place.placeholderColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Icon(
        place.placeholderIcon,
        size: 80,
        color: place.placeholderColor,
      ),
    );
  }

  Widget _buildCategoryBadge(
      BuildContext context, Color color, String categoryName) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.space3,
        vertical: AppTheme.space2,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
        border: Border.all(
          color: color.withValues(alpha: 0.4),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.category,
            size: 16,
            color: color,
          ),
          const SizedBox(width: AppTheme.space2),
          Text(
            categoryName,
            style: GoogleFonts.dmSans(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceNameAndLocation(Place place) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          place.name,
          style: GoogleFonts.playfairDisplay(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkBrown,
            height: 1.2,
          ),
        ),
        const SizedBox(height: AppTheme.space1),
        Row(
          children: [
            Icon(
              Icons.location_on,
              size: 16,
              color: AppTheme.warmGray,
            ),
            const SizedBox(width: AppTheme.space1),
            Expanded(
              child: Text(
                '${widget.cityName}, ${widget.countryName}',
                style: GoogleFonts.dmSans(
                  color: AppTheme.warmGray,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMapPreview(Place place, Color markerColor) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
            color: AppTheme.lightGray.withValues(alpha: 0.5)),
        boxShadow: AppTheme.shadowSm,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        child: FlutterMap(
          options: MapOptions(
            initialCenter: _placeLocation,
            initialZoom: 13.0,
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.none,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate:
                  "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: const ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: _placeLocation,
                  width: 44,
                  height: 52,
                  child: CustomMarker(
                    marker: MarkerService.buildPlaceMarker(
                      id: place.name,
                      position: _placeLocation,
                      title: place.name,
                      categoryName: widget.categoryName,
                    ),
                    size: 36,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisitedButton(Color categoryColor) {
    return ElevatedButton.icon(
      onPressed: () {
        setState(() {
          _isVisited = !_isVisited;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isVisited ? 'Marked as visited!' : 'Removed visited status',
              style: GoogleFonts.dmSans(),
            ),
            backgroundColor: _isVisited ? Colors.green : categoryColor,
            duration: const Duration(seconds: 2),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _isVisited ? Colors.green : categoryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
        ),
      ),
      icon: Icon(
        _isVisited ? Icons.check_circle : Icons.check_circle_outline,
      ),
      label: Text(
        _isVisited ? 'Visited' : 'Mark as Visited',
        style: GoogleFonts.dmSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
