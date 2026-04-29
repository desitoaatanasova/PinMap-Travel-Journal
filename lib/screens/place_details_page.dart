import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_journal_app/models/place.dart';

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
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Text(
                widget.place.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image carousel
            if (widget.place.imageUrls.isNotEmpty)
              SizedBox(
                height: 250,
                child: PageView.builder(
                  itemCount: widget.place.imageUrls.length,
                  controller: PageController(viewportFraction: 0.9),
                  itemBuilder: (context, index) {
                    final url = widget.place.imageUrls[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
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
                height: 250,
                decoration: BoxDecoration(
                  color: widget.place.placeholderColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  widget.place.placeholderIcon,
                  size: 80,
                  color: widget.place.placeholderColor,
                ),
              ),
            const SizedBox(height: 16),
            // Place name and subtitle
            Text(
              widget.place.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.place.subtitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 16),
            // Map preview
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
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
            const SizedBox(height: 24),
            // Description section
            Text(
              'About this place',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.place.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.category, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  widget.categoryName,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(width: 16),
                Icon(Icons.location_city, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  widget.cityName,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(height: 24),
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
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _isVisited ? Colors.green : widget.place.placeholderColor,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              icon: Icon(
                _isVisited ? Icons.check_circle : Icons.check_circle_outlined,
              ),
              label: Text(
                _isVisited ? 'Visited' : 'Mark as Visited',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
