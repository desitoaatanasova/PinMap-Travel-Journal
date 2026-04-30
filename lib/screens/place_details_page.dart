import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_journal_app/models/place.dart';
import 'package:travel_journal_app/widgets/section_header.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      extendBody: true,
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Text(
                widget.place.name,
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
        backgroundColor: AppTheme.bg.withValues(alpha: 0.8),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image carousel
            if (widget.place.imageUrls.isNotEmpty)
              SizedBox(
                height: 280,
                child: PageView.builder(
                  itemCount: widget.place.imageUrls.length,
                  controller: PageController(viewportFraction: 0.9),
                  itemBuilder: (context, index) {
                    final url = widget.place.imageUrls[index];
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
                              color: widget.place.placeholderColor.withValues(alpha: 0.3),
                              child: Icon(
                                widget.place.placeholderIcon,
                                size: 80,
                                color: widget.place.placeholderColor,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              Container(
                height: 280,
                decoration: BoxDecoration(
                  color: widget.place.placeholderColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                ),
                child: Icon(
                  widget.place.placeholderIcon,
                  size: 80,
                  color: widget.place.placeholderColor,
                ),
              ),
            const SizedBox(height: AppTheme.space6),
            // Place name and subtitle
            Text(
              widget.place.name,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: AppTheme.space2),
            Text(
              widget.place.subtitle,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: AppTheme.space6),
            // Map preview
            const SectionHeader(title: 'Location'),
            const SizedBox(height: AppTheme.space3),
            Container(
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
                    initialCenter: const LatLng(48.8566, 2.3522),
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
                          point: const LatLng(48.8566, 2.3522),
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.location_on,
                            color: widget.place.placeholderColor,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTheme.space6),
            // Description section
            const SectionHeader(title: 'About this place'),
            const SizedBox(height: AppTheme.space3),
            Text(
              widget.place.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                  ),
            ),
            const SizedBox(height: AppTheme.space4),
            Row(
              children: [
                Icon(Icons.category, size: 16, color: AppTheme.warmGray),
                const SizedBox(width: AppTheme.space2),
                Text(
                  widget.categoryName,
                  style: GoogleFonts.dmSans(
                    color: AppTheme.warmGray,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: AppTheme.space4),
                Icon(Icons.location_city, size: 16, color: AppTheme.warmGray),
                const SizedBox(width: AppTheme.space2),
                Text(
                  widget.cityName,
                  style: GoogleFonts.dmSans(
                    color: AppTheme.warmGray,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.space8),
            // Visited button
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _isVisited = !_isVisited;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _isVisited
                          ? 'Marked as visited!'
                          : 'Removed visited status',
                      style: GoogleFonts.dmSans(),
                    ),
                    backgroundColor: AppTheme.primary,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _isVisited ? Colors.green : widget.place.placeholderColor,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
              ),
              icon: Icon(
                _isVisited ? Icons.check_circle : Icons.check_circle_outlined,
              ),
              label: Text(
                _isVisited ? 'Visited' : 'Mark as Visited',
                style: GoogleFonts.dmSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
