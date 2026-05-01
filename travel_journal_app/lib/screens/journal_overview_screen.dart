import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinmap_travel_journal/models/country.dart';
import 'package:pinmap_travel_journal/services/country_service.dart';
import 'package:pinmap_travel_journal/screens/journal_editor_screen.dart';
import 'package:pinmap_travel_journal/widgets/premium_card.dart';
import 'package:pinmap_travel_journal/widgets/empty_state.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class JournalOverviewPage extends StatelessWidget {
  const JournalOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final visitedCountries = CountryService.getAllCountries()
        .where((c) => c.isVisited)
        .toList();

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
                'Journal Overview',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkBrown,
                ),
              ),
              titlePadding: const EdgeInsets.only(
                  left: AppTheme.space4, bottom: AppTheme.space4),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.space4),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Download journal coming soon!',
                              style: GoogleFonts.dmSans(),
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.download, size: 18),
                      label: const Text('Download Journal'),
                    ),
                  ),
                  const SizedBox(width: AppTheme.space2),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Post to profile coming soon!',
                              style: GoogleFonts.dmSans(),
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.person_add, size: 18),
                      label: const Text('Post to Profile'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppTheme.space4),
          ),
          if (visitedCountries.isEmpty)
            SliverFillRemaining(
              child: EmptyState(
                icon: Icons.book_outlined,
                message: 'No visited countries yet',
                buttonText: 'Explore Map',
                onButtonPressed: () {
                  // Navigate to home/map tab
                },
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(AppTheme.space4),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final country = visitedCountries[index];
                    return _buildCountryCard(context, country);
                  },
                  childCount: visitedCountries.length,
                ),
              ),
            ),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppTheme.space12),
          ),
        ],
      ),
    );
  }

  Widget _buildCountryCard(BuildContext context, Country country) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.space4),
      child: PremiumCard(
        padding: EdgeInsets.zero,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JournalEditorScreen(
                countryName: country.name,
              ),
            ),
          );
        },
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.primary.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppTheme.radiusLg),
                  bottomLeft: Radius.circular(AppTheme.radiusLg),
                ),
              ),
              child: Center(
                child: Text(
                  country.flag,
                  style: const TextStyle(fontSize: 36),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.space3),
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
                    const SizedBox(height: 2),
                    Text(
                      '${country.cityPins.length} cities',
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        color: AppTheme.warmGray,
                      ),
                    ),
                    const SizedBox(height: AppTheme.space1),
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 14,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Visited',
                          style: GoogleFonts.dmSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppTheme.space3),
              child: Icon(
                Icons.chevron_right,
                color: AppTheme.warmGray,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
