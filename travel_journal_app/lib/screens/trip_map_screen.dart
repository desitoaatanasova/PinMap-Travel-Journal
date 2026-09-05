import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:pinmap_travel_journal/models/trip.dart';
import 'package:pinmap_travel_journal/screens/place_details_page.dart';
import 'package:pinmap_travel_journal/services/country_service.dart';
import 'package:pinmap_travel_journal/services/place_service.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class TripMapScreen extends StatefulWidget {
  final Trip trip;

  const TripMapScreen({super.key, required this.trip});

  @override
  State<TripMapScreen> createState() => _TripMapScreenState();
}

class _TripMapScreenState extends State<TripMapScreen> {
  final MapController _mapController = MapController();
  int? _selectedDay;
  bool _didFitInitial = false;

  static const List<Color> _dayColors = [
    Color(0xFF8B4513),
    Color(0xFF008080),
    Color(0xFFDAA520),
    Color(0xFF8A2BE2),
    Color(0xFF228B22),
    Color(0xFFDC143C),
    Color(0xFF1565C0),
    Color(0xFF6A1B9A),
    Color(0xFF2E7D32),
    Color(0xFFEF6C00),
    Color(0xFFAD1457),
    Color(0xFF00695C),
    Color(0xFF5D4037),
    Color(0xFF283593),
  ];

  Color _dayColor(int dayNumber) {
    return _dayColors[(dayNumber - 1) % _dayColors.length];
  }

  List<TripDay> get _visibleDays {
    final days = widget.trip.itinerary;
    if (_selectedDay == null) return days;
    return days.where((d) => d.dayNumber == _selectedDay).toList();
  }

  List<LatLng> _pointsForDays(List<TripDay> days) {
    final points = <LatLng>[];
    for (final day in days) {
      for (final a in day.allActivities) {
        if (a.latitude != null && a.longitude != null) {
          if (a.latitude! < -90 || a.latitude! > 90 || a.longitude! < -180 || a.longitude! > 180) continue;
          points.add(LatLng(a.latitude!, a.longitude!));
        }
      }
    }
    return points;
  }

  LatLng? _centerOrNull(List<LatLng> points) {
    if (points.isEmpty) return null;
    final lat = points.map((p) => p.latitude).reduce((a, b) => a + b) / points.length;
    final lng = points.map((p) => p.longitude).reduce((a, b) => a + b) / points.length;
    return LatLng(lat, lng);
  }

  int get _validCount => _pointsForDays(_visibleDays).length;

  void _fitVisible() {
    final points = _pointsForDays(_visibleDays);
    if (points.isEmpty) return;
    if (points.length >= 2) {
      try {
        _mapController.fitCamera(
          CameraFit.bounds(
            bounds: LatLngBounds.fromPoints(points),
            padding: const EdgeInsets.all(64),
          ),
        );
      } catch (_) {}
    } else if (points.length == 1) {
      try {
        _mapController.move(points.first, 12);
      } catch (_) {}
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _didFitInitial) return;
      _didFitInitial = true;
      _fitVisible();
    });
  }

  void _selectDay(int? dayNumber) {
    setState(() => _selectedDay = dayNumber);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _fitVisible();
    });
  }

  List<Marker> _buildMarkers() {
    final markers = <Marker>[];
    for (final day in _visibleDays) {
      for (final a in day.allActivities) {
        if (a.latitude == null || a.longitude == null) continue;
        if (a.latitude! < -90 || a.latitude! > 90 || a.longitude! < -180 || a.longitude! > 180) continue;
        markers.add(
          Marker(
            point: LatLng(a.latitude!, a.longitude!),
            width: 48,
            height: 48,
            child: GestureDetector(
              onTap: () => _showActivitySheet(a, day.dayNumber),
              child: _DayMarker(
                color: _dayColor(day.dayNumber),
                label: '${day.dayNumber}',
              ),
            ),
          ),
        );
      }
    }
    return markers;
  }

  List<Polyline> _buildPolylines() {
    final lines = <Polyline>[];
    for (final day in _visibleDays) {
      final points = <LatLng>[];
      for (final a in day.allActivities) {
        if (a.latitude != null && a.longitude != null) {
          points.add(LatLng(a.latitude!, a.longitude!));
        }
      }
      if (points.length >= 2) {
        lines.add(
          Polyline(
            points: points,
            color: _dayColor(day.dayNumber),
            strokeWidth: 4,
          ),
        );
      }
    }
    return lines;
  }

  void _showActivitySheet(TripActivity activity, int dayNumber) {
    final hasPlace = activity.placeId != null;
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radiusLg)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(AppTheme.space4, AppTheme.space4, AppTheme.space4, AppTheme.space4 + 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(color: _dayColor(dayNumber), shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Text('$dayNumber', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: AppTheme.space3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(activity.placeName ?? 'Activity', style: GoogleFonts.playfairDisplay(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.darkBrown)),
                      if ((activity.cityName ?? '').isNotEmpty)
                        Text(activity.cityName!, style: GoogleFonts.dmSans(fontSize: 12, color: AppTheme.warmGray)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.space3),
            Wrap(
              spacing: AppTheme.space2,
              children: [
                _InfoChip(icon: Icons.calendar_today, label: 'Day $dayNumber'),
                _InfoChip(icon: Icons.wb_sunny, label: activity.timeSlot),
                if (activity.categoryId != null) _InfoChip(icon: Icons.category, label: 'Category ${activity.categoryId}'),
              ],
            ),
            if (activity.notes.isNotEmpty) ...[
              const SizedBox(height: AppTheme.space3),
              Text(activity.notes, style: GoogleFonts.dmSans(fontSize: 13, color: AppTheme.darkBrown)),
            ],
            const SizedBox(height: AppTheme.space4),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Close', style: GoogleFonts.dmSans()),
                  ),
                ),
                const SizedBox(width: AppTheme.space3),
                Expanded(
                  child: ElevatedButton(
                    onPressed: hasPlace ? () { Navigator.pop(context); _openPlace(activity); } : null,
                    child: Text('View details', style: GoogleFonts.dmSans()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openPlace(TripActivity activity) async {
    final placeId = activity.placeId;
    if (placeId == null) return;
    final place = await PlaceService.getPlaceById(placeId);
    if (!mounted) return;
    if (place == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Could not load place details',
            style: GoogleFonts.dmSans(),
          ),
        ),
      );
      return;
    }
    String countryName = '';
    try {
      countryName = CountryService.getAllCountries()
          .firstWhere((c) => c.countryId == widget.trip.countryId)
          .name;
    } catch (_) {}
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceDetailsPage(
          place: place,
          categoryName: place.categoryName ?? '',
          cityName: activity.cityName ?? '',
          countryName: countryName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final points = _pointsForDays(_visibleDays);
    final center = _centerOrNull(points);
    final polylines = _buildPolylines();
    final markers = _buildMarkers();
    final hasValid = points.isNotEmpty;
    return Scaffold(
      backgroundColor: AppTheme.bg,
      extendBody: true,
      appBar: AppBar(
        title: Text(
          'Trip Map',
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkBrown,
          ),
        ),
        backgroundColor: AppTheme.bg,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildDaySelector(),
          Expanded(
            child: hasValid
                ? FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: center ?? const LatLng(20, 0),
                      initialZoom: center != null ? 8 : 2,
                      onMapReady: () {
                        if (!_didFitInitial) {
                          _didFitInitial = true;
                          WidgetsBinding.instance.addPostFrameCallback((_) => _fitVisible());
                        }
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.pinmap_travel_journal',
                      ),
                      if (polylines.isNotEmpty) PolylineLayer(polylines: polylines),
                      MarkerLayer(markers: markers),
                    ],
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppTheme.space4),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.map_outlined, size: 56, color: AppTheme.warmGray.withValues(alpha: 0.6)),
                          const SizedBox(height: AppTheme.space3),
                          Text(
                            'No mapped locations',
                            style: GoogleFonts.playfairDisplay(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.darkBrown),
                          ),
                          const SizedBox(height: AppTheme.space2),
                          Text(
                            'This itinerary does not contain places with coordinates. Basic itineraries and empty days are not shown on the map.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.dmSans(fontSize: 13, color: AppTheme.warmGray),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildDaySelector() {
    final days = widget.trip.itinerary.map((d) => d.dayNumber).toList();
    return SizedBox(
      height: 56,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.space3, vertical: AppTheme.space2),
        children: [
          _DayChip(
            label: 'All',
            selected: _selectedDay == null,
            color: AppTheme.primary,
            onTap: () => _selectDay(null),
          ),
          for (final d in days)
            _DayChip(
              label: 'Day $d',
              selected: _selectedDay == d,
              color: _dayColor(d),
              onTap: () => _selectDay(d),
            ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    final days = widget.trip.itinerary;
    return Container(
      padding: const EdgeInsets.all(AppTheme.space3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_selectedDay == null) ...[
            SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (final day in days)
                    Padding(
                      padding: const EdgeInsets.only(right: AppTheme.space3),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: _dayColor(day.dayNumber),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: AppTheme.space1),
                          Text(
                            'Day ${day.dayNumber}',
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              color: AppTheme.warmGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.space2),
          ],
          Text(
            '$_validCount places shown${_validCount == 0 ? " — no coordinates" : ""}',
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
              fontSize: 12,
              color: AppTheme.warmGray,
            ),
          ),
        ],
      ),
    );
  }

  // Straight-line visualization per day (not real routing).
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: AppTheme.bg, borderRadius: BorderRadius.circular(AppTheme.radiusFull), border: Border.all(color: AppTheme.lightGray)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 14, color: AppTheme.warmGray),
        const SizedBox(width: 4),
        Text(label, style: GoogleFonts.dmSans(fontSize: 12, color: AppTheme.darkBrown, fontWeight: FontWeight.w500)),
      ]),
    );
  }
}

class _DayMarker extends StatelessWidget {
  final Color color;
  final String label;

  const _DayMarker({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

class _DayChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _DayChip({
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppTheme.space2),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.space3),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? color : AppTheme.card,
            borderRadius: BorderRadius.circular(AppTheme.radiusFull),
            border: Border.all(color: selected ? color : AppTheme.lightGray),
          ),
          child: Text(
            label,
            style: GoogleFonts.dmSans(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : AppTheme.darkBrown,
            ),
          ),
        ),
      ),
    );
  }
}
