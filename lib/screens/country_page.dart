import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_journal_app/models/country.dart';
import 'package:travel_journal_app/models/country_theme.dart';
import 'package:travel_journal_app/services/country_theme_service.dart';
import 'package:travel_journal_app/screens/city_page.dart';
import 'package:travel_journal_app/theme/app_theme.dart';

class CountryPage extends StatefulWidget {
  final Country country;

  const CountryPage({super.key, required this.country});

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  final MapController _mapController = MapController();
  int _rating = 0;
  bool _isInWishList = false;

  @override
  Widget build(BuildContext context) {
    final theme = CountryThemeService.getThemeForCountry(widget.country.name);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      extendBody: true,
      appBar: AppBar(
        title: Text(
          widget.country.name,
          style: GoogleFonts.playfairDisplay(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: theme.textColor ?? AppTheme.darkBrown,
          ),
        ),
        backgroundColor: theme.primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Map with rounded corners and shadow
            Container(
              height: 250,
              margin: const EdgeInsets.all(AppTheme.space4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                boxShadow: AppTheme.shadowMd,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: widget.country.latLng,
                    initialZoom: 4.0,
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
                          width: 40,
                          height: 40,
                          child: GestureDetector(
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
                            child: Icon(
                              Icons.location_on,
                              color: theme.primaryColor,
                              size: 40,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.space4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            foregroundColor: theme.backgroundColor ?? Colors.white,
                          ),
                          onPressed: () => _showRatingDialog(theme),
                          icon: const Icon(Icons.star),
                          label: const Text('Rate'),
                        ),
                      ),
                      const SizedBox(width: AppTheme.space4),
                      Expanded(
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: theme.primaryColor,
                            side: BorderSide(color: theme.primaryColor),
                          ),
                          onPressed: _toggleWishList,
                          icon: Icon(
                            _isInWishList
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: _isInWishList ? theme.primaryColor : null,
                          ),
                          label: Text(
                            _isInWishList ? 'In Wish List' : 'Add to Wish List',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.space6),
                  // About section
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
                      color: theme.textColor ?? AppTheme.warmGray,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: AppTheme.space6),
                  // Cities section
                  Text(
                    'Major Cities',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: AppTheme.space2),
                  ...widget.country.cityPins.map(
                    (city) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.location_city,
                        color: theme.primaryColor,
                      ),
                      title: Text(
                        city.name,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: theme.textColor ?? AppTheme.darkBrown,
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
    );
  }

  void _showRatingDialog(CountryTheme theme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rate this country'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < _rating ? Icons.star : Icons.star_border,
                color: theme.primaryColor,
                size: 32,
              ),
              onPressed: () {
                setState(() {
                  _rating = index + 1;
                });
                Navigator.pop(context);
              },
            );
          }),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _toggleWishList() {
    setState(() {
      _isInWishList = !_isInWishList;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isInWishList
              ? '${widget.country.name} added to wish list'
              : '${widget.country.name} removed from wish list',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}