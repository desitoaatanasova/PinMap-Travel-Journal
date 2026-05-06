import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinmap_travel_journal/models/trip.dart';
import 'package:pinmap_travel_journal/services/trip_service.dart';
import 'package:pinmap_travel_journal/screens/new_trip_screen.dart';
import 'package:pinmap_travel_journal/screens/trip_plan_screen.dart';
import 'package:pinmap_travel_journal/widgets/premium_card.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final trips = TripService.getAllTrips();

    return Scaffold(
      backgroundColor: AppTheme.bg,
      extendBody: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            backgroundColor: AppTheme.bg,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Trips',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkBrown,
                ),
              ),
              titlePadding: const EdgeInsets.only(
                  left: AppTheme.space4,
                  bottom: AppTheme.space4),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.space4),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewTripScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_location_alt),
                  label: const Text('New Trip'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppTheme.space3),
                  ),
                ),
              ),
            ),
          ),
          if (trips.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.luggage,
                      size: 64,
                      color: AppTheme.warmGray.withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: AppTheme.space4),
                    Text(
                      'No trips yet',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 20,
                        color: AppTheme.warmGray,
                      ),
                    ),
                    const SizedBox(height: AppTheme.space2),
                    Text(
                      'Tap "New Trip" to start planning',
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        color: AppTheme.warmGray,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final trip = trips[index];
                  return _buildTripCard(context, trip);
                },
                childCount: trips.length,
              ),
            ),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppTheme.space12),
          ),
        ],
      ),
    );
  }

  Widget _buildTripCard(BuildContext context, Trip trip) {
    return PremiumCard(
      padding: EdgeInsets.zero,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TripPlanScreen(tripId: trip.id),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppTheme.radiusLg),
              topRight: Radius.circular(AppTheme.radiusLg),
            ),
            child: trip.heroImageUrl != null
                ? CachedNetworkImage(
                    imageUrl: trip.heroImageUrl!,
                    height: 160,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => _buildHeroPlaceholder(trip.destination),
                    errorWidget: (context, url, error) => _buildHeroPlaceholder(trip.destination),
                  )
                : _buildHeroPlaceholder(trip.destination),
          ),
          Padding(
            padding: const EdgeInsets.all(AppTheme.space4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip.destination,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkBrown,
                  ),
                ),
                const SizedBox(height: AppTheme.space2),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: AppTheme.warmGray,
                    ),
                    const SizedBox(width: AppTheme.space2),
                    Text(
                      '${_formatDate(trip.startDate)} - ${_formatDate(trip.endDate)}',
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        color: AppTheme.warmGray,
                      ),
                    ),
                    Text(
                      ' (${trip.durationDays} days)',
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        color: AppTheme.warmGray,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.space2),
                Row(
                  children: [
                    Icon(
                      trip.isSolo ? Icons.person : Icons.group,
                      size: 16,
                      color: AppTheme.warmGray,
                    ),
                    const SizedBox(width: AppTheme.space2),
                    Text(
                      trip.isSolo ? 'Solo' : 'Group',
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        color: AppTheme.warmGray,
                      ),
                    ),
                    const SizedBox(width: AppTheme.space4),
                    Text(
                      trip.budget,
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        color: AppTheme.warmGray,
                      ),
                    ),
                    const SizedBox(width: AppTheme.space4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.space2,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withValues(alpha: 0.1),
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusFull),
                      ),
                      child: Text(
                        trip.tripType,
                        style: GoogleFonts.dmSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroPlaceholder(String destination) {
    return Container(
      height: 160,
      color: AppTheme.primary.withValues(alpha: 0.1),
      child: Center(
        child: Icon(
          Icons.luggage,
          size: 48,
          color: AppTheme.primary.withValues(alpha: 0.3),
        ),
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
