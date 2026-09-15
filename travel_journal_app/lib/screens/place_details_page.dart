import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pinmap_travel_journal/models/place.dart';
import 'package:pinmap_travel_journal/widgets/authenticated_image.dart';
import 'package:pinmap_travel_journal/services/marker_service.dart';
import 'package:pinmap_travel_journal/services/wishlist_service.dart';
import 'package:pinmap_travel_journal/services/country_service.dart';
import 'package:pinmap_travel_journal/services/visited_service.dart';
import 'package:pinmap_travel_journal/widgets/section_header.dart';
import 'package:pinmap_travel_journal/widgets/custom_marker.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

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
    _isInWishlist = WishlistService.isInWishlist(widget.place.placeId);
    _isVisited = VisitedService.isPlaceVisited(widget.place.placeId);
  }

  Future<void> _toggleWishlist() async {
    if (_isInWishlist) {
      final item =
          WishlistService.getAllItems()
              .where((i) => i.placeId == widget.place.placeId)
              .firstOrNull;
      if (item != null) {
        await WishlistService.removeItem(item.wishlistId);
      }
    } else {
      await WishlistService.addItem(widget.place.placeId);
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

  Future<void> _launchWebsite(String raw) async {
    var url = raw.trim();
    if (url.isEmpty) return;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Could not open website',
              style: GoogleFonts.dmSans(),
            ),
          ),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Could not open website',
              style: GoogleFonts.dmSans(),
            ),
          ),
        );
      }
    }
  }

  LatLng get _placeLocation {
    if (widget.place.latitude != null && widget.place.longitude != null) {
      return LatLng(widget.place.latitude!, widget.place.longitude!);
    }
    return const LatLng(48.8566, 2.3522);
  }

  Color _getCategoryColor() {
    switch (widget.categoryName) {
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

  Color _categoryFg(BuildContext context, Color color) {
    if (Theme.of(context).brightness != Brightness.dark) return color;
    if (color == const Color(0xFF8B4513)) return const Color(0xFFD29A5B);
    if (color == const Color(0xFF008080)) return const Color(0xFF63B3B3);
    if (color == const Color(0xFF228B22)) return const Color(0xFF7BC47F);
    return color;
  }

  @override
  Widget build(BuildContext context) {
    final place = widget.place;
    final categoryColor = _getCategoryColor();

    return Scaffold(
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
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            if (_isVisited)
              const Icon(Icons.check_circle, color: Colors.green, size: 28),
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
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPhotoCarousel(context, place, categoryColor),
            const SizedBox(height: AppTheme.space4),
            _buildCategoryBadge(context, categoryColor, widget.categoryName),
            const SizedBox(height: AppTheme.space4),
            _buildPlaceNameAndLocation(place),
            const SizedBox(height: AppTheme.space6),
            if (place.shortDescription != null ||
                place.fullDescription != null) ...[
              const SectionHeader(title: 'About this place'),
              const SizedBox(height: AppTheme.space3),
              Text(
                place.fullDescription ?? place.shortDescription ?? '',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(height: 1.6),
              ),
              const SizedBox(height: AppTheme.space6),
            ],
            if (place.address != null) ...[
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Theme.of(context).colorScheme.onSurfaceVariant
                            : const Color(0xFF8B7355),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      place.address!,
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.space4),
            ],
            if (place.website != null && place.website!.trim().isNotEmpty) ...[
              InkWell(
                onTap: () => _launchWebsite(place.website!),
                child: Row(
                  children: [
                    Icon(
                      Icons.language,
                      size: 16,
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Theme.of(context).colorScheme.onSurfaceVariant
                              : const Color(0xFF8B7355),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        place.website!.trim(),
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.space3),
            ],
            if (place.openingHours != null &&
                place.openingHours!.trim().isNotEmpty) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Theme.of(context).colorScheme.onSurfaceVariant
                            : const Color(0xFF8B7355),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      place.openingHours!.trim(),
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.space4),
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

  Widget _buildPhotoCarousel(
    BuildContext context,
    Place place,
    Color categoryColor,
  ) {
    final photos = [
      if (place.imageCover != null) place.imageCover!,
      ...place.photos.map((p) => p.imageUrl),
    ];
    if (photos.isNotEmpty) {
      return SizedBox(
        height: 280,
        child: PageView.builder(
          itemCount: photos.length,
          controller: PageController(viewportFraction: 0.9),
          itemBuilder: (context, index) {
            final url = photos[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: AppTheme.space1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                boxShadow: AppTheme.shadowMd,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                child: AuthenticatedCachedImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                  errorWidget:
                      (context, url, error) => Container(
                        color: categoryColor.withValues(alpha: 0.3),
                        child: Icon(
                          Icons.place,
                          size: 80,
                          color: _categoryFg(context, categoryColor),
                        ),
                      ),
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
        color: categoryColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Icon(
        Icons.place,
        size: 80,
        color: _categoryFg(context, categoryColor),
      ),
    );
  }

  Widget _buildCategoryBadge(
    BuildContext context,
    Color color,
    String categoryName,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.space3,
        vertical: AppTheme.space2,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.category,
            size: 16,
            color: _categoryFg(context, color),
          ),
          const SizedBox(width: AppTheme.space2),
          Text(
            categoryName,
            style: GoogleFonts.dmSans(
              color: _categoryFg(context, color),
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
            color: Theme.of(context).colorScheme.onSurface,
            height: 1.2,
          ),
        ),
        const SizedBox(height: AppTheme.space1),
        Row(
          children: [
            Icon(Icons.location_on, size: 16, color: AppTheme.warmGray),
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
        border: Border.all(color: AppTheme.lightGray.withValues(alpha: 0.5)),
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
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
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
      onPressed: () async {
        await VisitedService.togglePlace(
          widget.place.placeId,
          cityId: widget.place.cityId,
          countryId:
              widget.place.cityId != 0
                  ? CountryService.countryIdForCity(widget.place.cityId)
                  : 0,
        );
        setState(() {
          _isVisited = VisitedService.isPlaceVisited(widget.place.placeId);
        });
        if (context.mounted) {
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
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _isVisited ? Colors.green : categoryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
        ),
      ),
      icon: Icon(_isVisited ? Icons.check_circle : Icons.check_circle_outline),
      label: Text(
        _isVisited ? 'Visited' : 'Mark as Visited',
        style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}
