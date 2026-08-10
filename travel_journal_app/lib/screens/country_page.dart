import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinmap_travel_journal/models/country.dart';
import 'package:pinmap_travel_journal/models/country_theme.dart';
import 'package:pinmap_travel_journal/models/map_marker.dart';
import 'package:pinmap_travel_journal/services/country_theme_service.dart';
import 'package:pinmap_travel_journal/services/wishlist_service.dart';
import 'package:pinmap_travel_journal/services/visited_service.dart';
import 'package:pinmap_travel_journal/services/ratings_service.dart';
import 'package:pinmap_travel_journal/screens/city_page.dart';
import 'package:pinmap_travel_journal/widgets/custom_marker.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class CountryPage extends StatefulWidget {
  final Country country;

  const CountryPage({super.key, required this.country});

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  final MapController _mapController = MapController();
  int _rating = 0;
  bool _isWishlisted = false;
  bool _isVisited = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshState();
    });
  }

  Future<void> _refreshState() async {
    await WishlistService.loadItems();
    final rating = await RatingsService.getCountryRating(
        widget.country.countryId);
    if (mounted) {
      setState(() {
        _isWishlisted =
            WishlistService.isCountryInWishlist(widget.country.countryId);
        _isVisited = VisitedService.isCountryVisited(widget.country.countryId);
        _rating = rating?.myRating ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = CountryThemeService.getThemeForCountry(widget.country.name);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      extendBody: true,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(theme),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.space4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppTheme.space4),
                  _buildActionButtons(theme),
                  const SizedBox(height: AppTheme.space6),
                  _buildDescription(theme),
                  const SizedBox(height: AppTheme.space6),
                  _buildCityList(theme),
                  const SizedBox(height: AppTheme.space6),
                  _buildMiniMap(theme),
                  const SizedBox(height: AppTheme.space8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(CountryTheme theme) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: theme.primaryColor,
      iconTheme: IconThemeData(color: theme.backgroundColor),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: widget.country.flagImage ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: theme.primaryColor,
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: theme.primaryColor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    theme.gradientColors.last.withValues(alpha: 0.7),
                    theme.gradientColors.last.withValues(alpha: 0.9),
                  ],
                ),
              ),
            ),
            Positioned(
              left: AppTheme.space4,
              right: AppTheme.space4,
              bottom: AppTheme.space6,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: widget.country.flagImage != null
                        ? CachedNetworkImage(
                            imageUrl: widget.country.flagImage!,
                            width: 40,
                            height: 28,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.flag, size: 28, color: Colors.white70),
                          )
                        : const Icon(Icons.flag, size: 28, color: Colors.white70),
                  ),
                  const SizedBox(width: AppTheme.space3),
                  Expanded(
                    child: Text(
                      widget.country.name,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: theme.backgroundColor,
                        height: 1.1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(CountryTheme theme) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
              foregroundColor: theme.backgroundColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
              ),
              padding: const EdgeInsets.symmetric(vertical: AppTheme.space3),
            ),
            onPressed: () => _showRatingDialog(theme),
            icon: Icon(Icons.star, color: theme.accentColor, size: 20),
            label: Text(
              _rating > 0 ? '$_rating/5' : 'Rate',
              style: GoogleFonts.dmSans(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppTheme.space3),
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: _isVisited ? Colors.green : theme.primaryColor,
              foregroundColor: theme.backgroundColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
              ),
              padding: const EdgeInsets.symmetric(vertical: AppTheme.space3),
            ),
            onPressed: () async {
              await VisitedService.toggleCountry(widget.country.countryId);
              if (mounted) {
                setState(() {
                  _isVisited = VisitedService.isCountryVisited(
                      widget.country.countryId);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _isVisited
                          ? '${widget.country.name} marked as visited'
                          : '${widget.country.name} no longer marked as visited',
                      style: GoogleFonts.dmSans(),
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            icon: Icon(
              _isVisited ? Icons.check_circle : Icons.check_circle_outline,
              color: Colors.white,
              size: 20,
            ),
            label: Text(
              _isVisited ? 'Visited' : 'Visited?',
              style: GoogleFonts.dmSans(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppTheme.space3),
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: _isWishlisted ? Colors.red : theme.primaryColor,
              foregroundColor: theme.backgroundColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
              ),
              padding: const EdgeInsets.symmetric(vertical: AppTheme.space3),
            ),
            onPressed: () async {
              if (_isWishlisted) {
                await WishlistService.removeCountry(widget.country.countryId);
              } else {
                await WishlistService.addCountry(widget.country.countryId);
              }
              await _refreshState();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _isWishlisted
                          ? '${widget.country.name} removed from wishlist'
                          : '${widget.country.name} added to wishlist',
                      style: GoogleFonts.dmSans(),
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            icon: Icon(
              _isWishlisted ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
              size: 20,
            ),
            label: Text(
              _isWishlisted ? 'Wishlisted' : 'Wishlist',
              style: GoogleFonts.dmSans(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(CountryTheme theme) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.space4),
      decoration: BoxDecoration(
        color: theme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: AppTheme.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About ${widget.country.name}',
            style: GoogleFonts.playfairDisplay(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          const SizedBox(height: AppTheme.space2),
          Text(
            widget.country.description,
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: theme.textColor,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCityList(CountryTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Major Cities',
          style: GoogleFonts.playfairDisplay(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: theme.primaryColor,
          ),
        ),
        const SizedBox(height: AppTheme.space3),
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: widget.country.cityPins.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: AppTheme.space3),
            itemBuilder: (context, index) {
              final city = widget.country.cityPins[index];
              return _buildCityCard(city, theme);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCityCard(CityPin city, CountryTheme theme) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CityPage(
              cityName: city.name,
              countryName: widget.country.name,
            ),
          ),
        );
      },
      child: Container(
        width: 110,
        decoration: BoxDecoration(
          color: theme.surfaceColor,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          boxShadow: AppTheme.shadowSm,
          border: Border.all(
            color: theme.primaryColor.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppTheme.radiusMd - 1),
                  topRight: Radius.circular(AppTheme.radiusMd - 1),
                ),
                child: CachedNetworkImage(
                        imageUrl: 'https://source.unsplash.com/200x150/?${city.name},city',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: theme.primaryColor.withValues(alpha: 0.1),
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: theme.primaryColor.withValues(alpha: 0.1),
                          child: Icon(
                            Icons.location_city,
                            color: theme.primaryColor,
                            size: 28,
                          ),
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppTheme.space2),
              child: Column(
                children: [
                  Text(
                    city.name,
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: theme.textColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () async {
                      final cityVisited =
                          VisitedService.isCityVisited(city.cityId);
                      await VisitedService.toggleCity(
                        city.cityId,
                        countryId: cityVisited
                            ? null
                            : widget.country.countryId,
                      );
                      if (mounted) setState(() {});
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          VisitedService.isCityVisited(city.cityId)
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                          size: 12,
                          color: VisitedService.isCityVisited(city.cityId)
                              ? Colors.green
                              : theme.primaryColor.withValues(alpha: 0.5),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          VisitedService.isCityVisited(city.cityId)
                              ? 'Visited'
                              : 'Mark',
                          style: GoogleFonts.dmSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: VisitedService.isCityVisited(city.cityId)
                                ? Colors.green
                                : theme.primaryColor.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniMap(CountryTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Map Preview',
          style: GoogleFonts.playfairDisplay(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: theme.primaryColor,
          ),
        ),
        const SizedBox(height: AppTheme.space3),
        Container(
          height: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            boxShadow: AppTheme.shadowMd,
            border: Border.all(
              color: theme.primaryColor.withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppTheme.radiusLg - 1),
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: widget.country.cityPins.isNotEmpty
                    ? widget.country.cityPins.first.latLng
                    : const LatLng(48.8566, 2.3522),
                initialZoom: 5.0,
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
                  markers: widget.country.cityPins.map((city) {
                    return Marker(
                      point: city.latLng,
                      width: 44,
                      height: 52,
                      child: CustomMarker(
                        marker: MapMarker(
                          id: city.name,
                          position: city.latLng,
                          title: city.name,
                          category: MarkerCategory.hiddenGems,
                          isVisited: VisitedService.isCityVisited(city.cityId),
                        ),
                        size: 36,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showRatingDialog(CountryTheme theme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.surfaceColor,
        title: Text(
          'Rate ${widget.country.name}',
          style: GoogleFonts.playfairDisplay(
            color: theme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < _rating ? Icons.star : Icons.star_border,
                color: theme.accentColor,
                size: 36,
              ),
              onPressed: () {
                final rating = index + 1;
                setState(() {
                  _rating = rating;
                });
                RatingsService.rateCountry(widget.country.countryId, rating);
                Navigator.pop(context);
              },
            );
          }),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.dmSans(color: theme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
