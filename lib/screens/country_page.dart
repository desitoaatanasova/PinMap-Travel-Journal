import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:travel_journal_app/models/country.dart';
import 'package:travel_journal_app/models/country_theme.dart';
import 'package:travel_journal_app/services/country_theme_service.dart';
import 'package:travel_journal_app/screens/city_page.dart';

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
      appBar: AppBar(
        title: Text(widget.country.name),
        backgroundColor: theme.primaryColor,
      ),
      body: Container(
        color: theme.backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 250,
                margin: const EdgeInsets.all(16),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            foregroundColor: theme.backgroundColor,
                          ),
                          onPressed: () => _showRatingDialog(theme),
                            icon: const Icon(Icons.star),
                            label: const Text('Rate'),
                          ),
                        ),
                        const SizedBox(width: 16),
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
                              color: _isInWishList
                                  ? theme.primaryColor
                                  : null,
                            ),
                            label: Text(
                              _isInWishList
                                  ? 'In Wish List'
                                  : 'Add to Wish List',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'About ${widget.country.name}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.country.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: theme.textColor,
                          ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Major Cities',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    ...widget.country.cityPins.map(
                      (city) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          Icons.location_city,
                          color: theme.primaryColor,
                        ),
                        title: Text(
                          city.name,
                          style: TextStyle(color: theme.textColor),
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