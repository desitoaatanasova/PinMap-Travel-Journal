import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_journal_app/models/location.dart';
import 'package:travel_journal_app/models/country.dart';
import 'package:travel_journal_app/services/location_search_service.dart';
import 'package:travel_journal_app/services/country_service.dart';
import 'package:travel_journal_app/screens/country_page.dart';
import 'package:travel_journal_app/widgets/premium_card.dart';
import 'package:travel_journal_app/theme/app_theme.dart';

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

  static final LatLng _initialCenter = const LatLng(20.0, 0.0);

  @override
  void initState() {
    super.initState();
    _countries = CountryService.getAllCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      extendBody: true,
      body: Column(
        children: [
          // Map section with rounded corners and shadow
          Container(
            height: MediaQuery.of(context).size.height / 3,
            margin: const EdgeInsets.all(AppTheme.space3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
              boxShadow: AppTheme.shadowMd,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _initialCenter,
                  initialZoom: 1.5,
                  onTap: (_, latLng) => _onMapTapped(latLng),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: const ['a', 'b', 'c'],
                  ),
                ],
              ),
            ),
          ),
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.space4),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Search country or city...',
                    prefixIcon: Icon(Icons.search, color: AppTheme.warmGray),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear, color: AppTheme.warmGray),
                            onPressed: _clearSearch,
                          )
                        : null,
                  ),
                ),
                if (_showSuggestions && _searchResults.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: AppTheme.space2),
                    decoration: BoxDecoration(
                      color: AppTheme.card,
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                      boxShadow: AppTheme.shadowSm,
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _searchResults.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: AppTheme.lightGray.withValues(alpha: 0.5),
                      ),
                      itemBuilder: (context, index) {
                        final location = _searchResults[index];
                        return ListTile(
                          leading: Icon(Icons.location_on, color: AppTheme.primary),
                          title: Text(
                            location.name,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.darkBrown,
                            ),
                          ),
                          subtitle: Text(
                            location.country,
                            style: GoogleFonts.dancingScript(
                              fontSize: 14,
                              color: AppTheme.primary,
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
          const SizedBox(height: AppTheme.space4),
          // Country list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.space4),
              itemCount: _countries.length,
              itemBuilder: (context, index) {
                final country = _countries[index];
                return PremiumCard(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CountryPage(country: country),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.public,
                          color: AppTheme.primary,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: AppTheme.space4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              country.name,
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.darkBrown,
                              ),
                            ),
                            const SizedBox(height: AppTheme.space1),
                            Text(
                              country.description,
                              style: GoogleFonts.dmSans(
                                fontSize: 14,
                                color: AppTheme.warmGray,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
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
    super.dispose();
  }
}
