import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinmap_travel_journal/models/journal.dart';
import 'package:pinmap_travel_journal/services/journal_service.dart';
import 'package:pinmap_travel_journal/services/country_service.dart';
import 'package:pinmap_travel_journal/screens/journal_editor_screen.dart';
import 'package:pinmap_travel_journal/widgets/premium_card.dart';
import 'package:pinmap_travel_journal/widgets/empty_state.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  String _countryName(int countryId) {
    final country = CountryService.getAllCountries()
        .where((c) => c.countryId == countryId)
        .firstOrNull;
    return country?.name ?? 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    final journals = JournalService.getAllJournals();

    final grouped = <String, List<Journal>>{};
    for (final journal in journals) {
      final name = _countryName(journal.countryId);
      grouped.putIfAbsent(name, () => []).add(journal);
    }

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
                'Journal',
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
              padding: const EdgeInsets.all(AppTheme.space4),
              child: _buildNewJournalCard(context),
            ),
          ),
          if (journals.isEmpty)
            SliverFillRemaining(
              child: EmptyState(
                icon: Icons.book_outlined,
                message: 'No journal entries yet',
                buttonText: 'Start Writing',
                onButtonPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const JournalEditorScreen(),
                    ),
                  );
                },
              ),
            )
          else
            ...grouped.entries.map((entry) {
              final country = entry.key;
              final countryJournals = entry.value;
              return SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.space4, vertical: AppTheme.space2),
                      child: Row(
                        children: [
                          Icon(
                            Icons.public,
                            size: 18,
                            color: AppTheme.primary,
                          ),
                          const SizedBox(width: AppTheme.space2),
                          Text(
                            country.toUpperCase(),
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.primary,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.space4),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: AppTheme.space4,
                          mainAxisSpacing: AppTheme.space4,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: countryJournals.length,
                        itemBuilder: (context, index) {
                          final journal = countryJournals[index];
                          return _buildJournalCard(context, journal);
                        },
                      ),
                    ),
                    const SizedBox(height: AppTheme.space4),
                  ],
                ),
              );
            }),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppTheme.space12),
          ),
        ],
      ),
    );
  }

  Widget _buildNewJournalCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primary,
            AppTheme.primary.withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: AppTheme.shadowMd,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const JournalEditorScreen(),
              ),
            );
          },
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.space6),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: AppTheme.space4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'New Journal',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: AppTheme.space1),
                      Text(
                        'Start documenting your journey',
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildJournalCard(BuildContext context, Journal journal) {
    return PremiumCard(
      padding: EdgeInsets.zero,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                JournalEditorScreen(chapterId: journal.journalId.toString()),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppTheme.radiusLg),
                topRight: Radius.circular(AppTheme.radiusLg),
              ),
              child: journal.coverImage != null
                  ? CachedNetworkImage(
                      imageUrl: journal.coverImage!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => _buildCoverFallback(),
                      errorWidget: (context, url, error) =>
                          _buildCoverFallback(),
                    )
                  : _buildCoverFallback(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppTheme.space3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  journal.title,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkBrown,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppTheme.space1),
                Row(
                  children: [
                    Icon(
                      Icons.article_outlined,
                      size: 14,
                      color: AppTheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${journal.pages.length} pages',
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.primary,
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

  Widget _buildCoverFallback() {
    return Container(
      color: AppTheme.primary.withValues(alpha: 0.15),
      child: Center(
        child: Icon(
          Icons.book,
          size: 48,
          color: AppTheme.primary.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
