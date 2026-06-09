import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinmap_travel_journal/models/trip.dart';
import 'package:pinmap_travel_journal/services/trip_service.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class TripPlanScreen extends StatelessWidget {
  final String tripId;
  final Trip? trip;

  const TripPlanScreen({
    super.key,
    required this.tripId,
    this.trip,
  });

  @override
  Widget build(BuildContext context) {
    final trip = this.trip ?? TripService.getTripById(int.tryParse(tripId) ?? 0);

    if (trip == null) {
      return Scaffold(
        backgroundColor: AppTheme.bg,
        body: Center(
          child: Text(
            'Trip not found',
            style: GoogleFonts.playfairDisplay(
              fontSize: 20,
              color: AppTheme.warmGray,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.bg,
      extendBody: true,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(trip),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.space4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildActionButtons(context, trip),
                  const SizedBox(height: AppTheme.space6),
                  Text(
                    'Day-by-Day Itinerary',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkBrown,
                    ),
                  ),
                  const SizedBox(height: AppTheme.space4),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final day = trip.itinerary[index];
                return _buildDayCard(day);
              },
              childCount: trip.itinerary.length,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppTheme.space12),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(Trip trip) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: AppTheme.primary,
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: AppTheme.primary.withValues(alpha: 0.1),
          child: Center(
            child: Icon(
              Icons.luggage,
              size: 48,
              color: AppTheme.primary.withValues(alpha: 0.3),
            ),
          ),
        ),
        titlePadding: const EdgeInsets.only(
            left: AppTheme.space4, bottom: AppTheme.space4),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            trip.title,
            style: GoogleFonts.playfairDisplay(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            '${_formatDate(trip.startDate)} - ${_formatDate(trip.endDate)}',
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: AppTheme.warmOffWhite,
            ),
          ),
        ],
      ),
      titleSpacing: AppTheme.space4,
    );
  }

  Widget _buildActionButtons(BuildContext context, Trip trip) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Map view coming soon!',
                    style: GoogleFonts.dmSans(),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(Icons.map, size: 18),
            label: const Text('Map View'),
          ),
        ),
        const SizedBox(width: AppTheme.space2),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'PDF export coming soon!',
                    style: GoogleFonts.dmSans(),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(Icons.picture_as_pdf, size: 18),
            label: const Text('Export PDF'),
          ),
        ),
        const SizedBox(width: AppTheme.space2),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Edit feature coming soon!',
                    style: GoogleFonts.dmSans(),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(Icons.edit, size: 18),
            label: const Text('Edit'),
          ),
        ),
        const SizedBox(width: AppTheme.space2),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _confirmDelete(context, trip.tripId),
            icon: const Icon(Icons.delete, size: 18),
            label: const Text('Delete'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDayCard(TripDay day) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: AppTheme.space4, vertical: AppTheme.space2),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: AppTheme.shadowMd,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.space3, vertical: AppTheme.space1),
              decoration: BoxDecoration(
                color: AppTheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
              ),
              child: Text(
                'DAY ${day.dayNumber}',
                style: GoogleFonts.dmSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primary,
                ),
              ),
            ),
            const SizedBox(height: AppTheme.space3),
            if (day.morning.isNotEmpty) ...[
              _buildSectionHeader('Morning', Icons.wb_sunny),
              const SizedBox(height: AppTheme.space2),
              ...day.morning.map((activity) => _buildActivityRow(activity)),
              const SizedBox(height: AppTheme.space3),
            ],
            if (day.afternoon.isNotEmpty) ...[
              _buildSectionHeader('Afternoon', Icons.light_mode),
              const SizedBox(height: AppTheme.space2),
              ...day.afternoon.map((activity) => _buildActivityRow(activity)),
              const SizedBox(height: AppTheme.space3),
            ],
            if (day.evening.isNotEmpty) ...[
              _buildSectionHeader('Evening', Icons.nightlight),
              const SizedBox(height: AppTheme.space2),
              ...day.evening.map((activity) => _buildActivityRow(activity)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppTheme.primary),
        const SizedBox(width: AppTheme.space2),
        Text(
          title,
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildActivityRow(TripActivity activity) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.space2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.place,
            size: 16,
            color: AppTheme.warmGray,
          ),
          const SizedBox(width: AppTheme.space2),
          Text(
            activity.timeSlot,
            style: GoogleFonts.dmSans(
              fontSize: 12,
              color: AppTheme.warmGray,
            ),
          ),
          const SizedBox(width: AppTheme.space2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.placeName ?? 'Activity',
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.darkBrown,
                  ),
                ),
                if (activity.notes.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    activity.notes,
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      color: AppTheme.warmGray,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, int tripId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Trip',
          style: GoogleFonts.playfairDisplay(
            color: AppTheme.darkBrown,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this trip?',
          style: GoogleFonts.dmSans(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.dmSans(color: AppTheme.warmGray),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              TripService.deleteTrip(tripId);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text(
              'Delete',
              style: GoogleFonts.dmSans(),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}';
  }
}
