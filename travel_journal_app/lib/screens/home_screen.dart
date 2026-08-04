import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinmap_travel_journal/models/country.dart';
import 'package:pinmap_travel_journal/models/location.dart';
import 'package:pinmap_travel_journal/models/map_marker.dart';
import 'package:pinmap_travel_journal/services/country_service.dart';
import 'package:pinmap_travel_journal/services/location_search_service.dart';
import 'package:pinmap_travel_journal/screens/country_page.dart';
import 'package:pinmap_travel_journal/widgets/travel_progress_bar.dart';
import 'package:pinmap_travel_journal/widgets/custom_marker.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  List<Location> _searchResults = [];
  bool _showSuggestions = false;
  List<Country> _countries = [];
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();

  static final LatLng _initialCenter = const LatLng(20.0, 0.0);

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await CountryService.reloadCountries();
    if (mounted) {
      setState(() {
        _countries = CountryService.getAllCountries();
      });
    }
  }

  void _retryLoad() {
    setState(() {
      _countries = [];
    });
    _loadData();
  }

  List<Marker> get _mapMarkers {
    return _countries.expand((country) {
      return country.cityPins.map((city) {
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
            ),
            size: 36,
          ),
        );
      });
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      extendBody: true,
      body: Stack(
        children: [
          // Full-screen map
          Positioned.fill(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _initialCenter,
                initialZoom: 1.8,
                onTap: (_, latLng) => _onMapTapped(latLng),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(markers: _mapMarkers),
              ],
            ),
          ),

          // Floating search bar
          Positioned(
            top: MediaQuery.of(context).padding.top + AppTheme.space3,
            left: AppTheme.space4,
            right: AppTheme.space4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.card,
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    boxShadow: AppTheme.shadowMd,
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      color: AppTheme.darkBrown,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search country or city...',
                      hintStyle: GoogleFonts.dmSans(
                        color: AppTheme.warmGray,
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(Icons.search,
                          color: AppTheme.warmGray, size: 20),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear,
                                  color: AppTheme.warmGray, size: 18),
                              onPressed: _clearSearch,
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.space4,
                        vertical: AppTheme.space3,
                      ),
                    ),
                  ),
                ),
                if (_showSuggestions && _searchResults.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: AppTheme.space2),
                    decoration: BoxDecoration(
                      color: AppTheme.card,
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                      boxShadow: AppTheme.shadowMd,
                    ),
                    constraints: const BoxConstraints(maxHeight: 250),
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: _searchResults.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: AppTheme.lightGray.withValues(alpha: 0.5),
                      ),
                      itemBuilder: (context, index) {
                        final location = _searchResults[index];
                        return ListTile(
                          dense: true,
                          leading: Icon(Icons.location_on,
                              color: AppTheme.primary, size: 18),
                          title: Text(
                            location.name,
                            style: GoogleFonts.dmSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.darkBrown,
                            ),
                          ),
                          subtitle: Text(
                            location.country,
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              color: AppTheme.warmGray,
                            ),
                          ),
                          onTap: () => _onLocationSelected(location),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),

          // Travel progress bar
          Positioned(
            top: MediaQuery.of(context).padding.top + 72,
            left: AppTheme.space4,
            right: AppTheme.space4,
            child: const TravelProgressBar(),
          ),

          // Draggable country list
          DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize: 0.32,
            minChildSize: 0.15,
            maxChildSize: 0.65,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: AppTheme.bg,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppTheme.radiusLg),
                    topRight: Radius.circular(AppTheme.radiusLg),
                  ),
                  boxShadow: AppTheme.shadowLg,
                ),
                child: Column(
                  children: [
                    // Handle bar
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: AppTheme.space2),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppTheme.lightGray,
                        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.space4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Countries',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.darkBrown,
                            ),
                          ),
                          if (CountryService.hasError)
                            GestureDetector(
                              onTap: _retryLoad,
                              child: Row(
                                children: [
                                  Icon(Icons.refresh,
                                      size: 16, color: AppTheme.primary),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Retry',
                                    style: GoogleFonts.dmSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            Text(
                              '${_countries.length} countries',
                              style: GoogleFonts.dmSans(
                                fontSize: 12,
                                color: AppTheme.warmGray,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppTheme.space2),
                    if (_countries.isEmpty && !CountryService.hasError)
                      Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppTheme.primary,
                          ),
                        ),
                      )
                    else if (_countries.isEmpty && CountryService.hasError)
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            onTap: _retryLoad,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.cloud_off,
                                    size: 48, color: AppTheme.warmGray),
                                const SizedBox(height: AppTheme.space2),
                                Text(
                                  'Could not load countries',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 14,
                                    color: AppTheme.warmGray,
                                  ),
                                ),
                                const SizedBox(height: AppTheme.space2),
                                Text(
                                  'Tap to retry',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.space4),
                          itemCount: _countries.length,
                          itemBuilder: (context, index) {
                            final country = _countries[index];
                            return _CountryListCard(country: country);
                          },
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onMapTapped(LatLng position) {
    final country = CountryService.findCountryByLocation(
      position.latitude,
      position.longitude,
    );
    if (country != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CountryPage(country: country),
        ),
      );
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchResults = LocationSearchService.searchLocations(query);
      _showSuggestions = query.isNotEmpty;
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchResults = [];
      _showSuggestions = false;
    });
  }

  void _onLocationSelected(Location location) {
    _mapController.move(
      LatLng(location.latitude, location.longitude),
      10.0,
    );
    setState(() {
      _showSuggestions = false;
    });
    _searchController.clear();
  }

  @override
  void dispose() {
    _mapController.dispose();
    _searchController.dispose();
    _sheetController.dispose();
    super.dispose();
  }
}

class _CountryListCard extends StatelessWidget {
  final Country country;

  const _CountryListCard({required this.country});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CountryPage(country: country),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppTheme.space3),
        decoration: BoxDecoration(
          color: AppTheme.card,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          boxShadow: AppTheme.shadowSm,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.radiusFull),
              child: country.flagImage != null
                  ? CachedNetworkImage(
                      imageUrl: country.flagImage!,
                      width: 52,
                      height: 52,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => _buildFlagPlaceholder(country),
                    )
                  : _buildFlagPlaceholder(country),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    country.name,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBrown,
                    ),
                  ),
                  Text(
                    country.continent,
                    style: GoogleFonts.dmSans(
                      fontSize: 13,
                      color: AppTheme.warmGray,
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(AppTheme.radiusMd),
                bottomRight: Radius.circular(AppTheme.radiusMd),
              ),
              child: country.flagImage != null
                  ? CachedNetworkImage(
                      imageUrl: country.flagImage!,
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => _buildCardImagePlaceholder(),
                      errorWidget: (context, url, error) =>
                          _buildCardImagePlaceholder(),
                    )
                  : _buildCardImagePlaceholder(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlagPlaceholder(Country country) {
    return Container(
      width: 52,
      height: 52,
      decoration: const BoxDecoration(
        color: Color(0xFFE8DCD1),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        country.name.isNotEmpty ? country.name[0].toUpperCase() : '?',
        style: GoogleFonts.playfairDisplay(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF8B7355),
        ),
      ),
    );
  }

  Widget _buildCardImagePlaceholder() {
    return Container(
      width: 72,
      height: 72,
      color: AppTheme.lightGray.withValues(alpha: 0.3),
      child: Icon(
        Icons.public,
        color: AppTheme.warmGray,
        size: 24,
      ),
    );
  }
}
