import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinmap_travel_journal/models/country.dart';
import 'package:pinmap_travel_journal/models/journal.dart';
import 'package:pinmap_travel_journal/services/country_service.dart';
import 'package:pinmap_travel_journal/services/visited_service.dart';
import 'package:pinmap_travel_journal/services/journal_service.dart';
import 'package:pinmap_travel_journal/screens/journal_editor_screen.dart';
import 'package:pinmap_travel_journal/screens/journal_view_screen.dart';
import 'package:pinmap_travel_journal/widgets/premium_card.dart';
import 'package:pinmap_travel_journal/widgets/empty_state.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class JournalOverviewPage extends StatefulWidget {
  const JournalOverviewPage({super.key});

  @override
  State<JournalOverviewPage> createState() => _JournalOverviewPageState();
}

class _JournalOverviewPageState extends State<JournalOverviewPage> {
  @override
  void initState() {
    super.initState();
    VisitedService.reloadVisited().then((_) {
      if (mounted) setState(() {});
    });
  }

  String _countryName(int countryId) {
    final country =
        CountryService.getAllCountries()
            .where((c) => c.countryId == countryId)
            .firstOrNull;
    return country?.name ?? 'Unknown';
  }

  void _showNoJournalSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'No journal yet for this country.',
          style: GoogleFonts.dmSans(),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _openOwnerJournal(int journalId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => JournalViewScreen(journalId: journalId, isPublic: false),
      ),
    );
  }

  Future<void> _downloadJournalFlow() async {
    await JournalService.loadJournals();
    if (!mounted) return;
    final journals = JournalService.getAllJournals();
    if (journals.isEmpty) {
      _showNoJournalSnackBar();
      return;
    }
    final byCountry = <int, List<Journal>>{};
    for (final journal in journals) {
      byCountry.putIfAbsent(journal.countryId, () => []).add(journal);
    }
    if (byCountry.length == 1) {
      final entry = byCountry.entries.single;
      await _openForCountry(entry.key, entry.value);
      return;
    }
    final pickedCountry = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder:
          (sheetContext) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppTheme.space4),
                  child: Text(
                    'Choose country',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(sheetContext).colorScheme.onSurface,
                    ),
                  ),
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (final entry in byCountry.entries)
                        ListTile(
                          title: Text(
                            _countryName(entry.key),
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(sheetContext).colorScheme.onSurface,
                            ),
                          ),
                          subtitle: Text(
                            '${entry.value.length} journal${entry.value.length == 1 ? '' : 's'}',
                            style: GoogleFonts.dmSans(color: AppTheme.warmGray),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => Navigator.pop(sheetContext, entry.key),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
    if (pickedCountry == null || !mounted) return;
    await _openForCountry(pickedCountry, byCountry[pickedCountry] ?? []);
  }

  Future<void> _openForCountry(int countryId, List<Journal> journals) async {
    if (journals.isEmpty) {
      _showNoJournalSnackBar();
      return;
    }
    if (journals.length == 1) {
      _openOwnerJournal(journals.single.journalId);
      return;
    }
    final pickedJournal = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder:
          (sheetContext) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppTheme.space4),
                  child: Text(
                    _countryName(countryId),
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(sheetContext).colorScheme.onSurface,
                    ),
                  ),
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (final journal in journals)
                        ListTile(
                          title: Text(
                            journal.title.isEmpty
                                ? 'Untitled journal'
                                : journal.title,
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(sheetContext).colorScheme.onSurface,
                            ),
                          ),
                          subtitle: Text(
                            '${journal.pages.length} page${journal.pages.length == 1 ? '' : 's'}',
                            style: GoogleFonts.dmSans(color: AppTheme.warmGray),
                          ),
                          trailing: const Icon(Icons.download),
                          onTap:
                              () => Navigator.pop(
                                sheetContext,
                                journal.journalId,
                              ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
    if (pickedJournal == null || !mounted) return;
    _openOwnerJournal(pickedJournal);
  }

  @override
  Widget build(BuildContext context) {
    final allCountries = CountryService.getAllCountries();

    return Scaffold(
      extendBody: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Journal Overview',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              titlePadding: const EdgeInsets.only(
                left: AppTheme.space4,
                bottom: AppTheme.space4,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.space4),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _downloadJournalFlow,
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
          const SliverToBoxAdapter(child: SizedBox(height: AppTheme.space4)),
          if (allCountries.isEmpty)
            SliverFillRemaining(
              child: EmptyState(
                icon: Icons.menu_book_outlined,
                message: 'No countries loaded yet',
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
                delegate: SliverChildBuilderDelegate((context, index) {
                  final country = allCountries[index];
                  return _buildCountryCard(context, country);
                }, childCount: allCountries.length),
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: AppTheme.space12)),
        ],
      ),
    );
  }

  Widget _buildCountryCard(BuildContext context, Country country) {
    final isVisited = VisitedService.isCountryVisited(country.countryId);
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.space4),
      child: PremiumCard(
        padding: EdgeInsets.zero,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => JournalEditorScreen(countryName: country.name),
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
              child:
                  country.flagImage != null
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: country.flagImage!,
                          width: 40,
                          height: 28,
                          memCacheWidth: 120,
                          memCacheHeight: 84,
                          maxWidthDiskCache: 120,
                          maxHeightDiskCache: 84,
                          fit: BoxFit.cover,
                          errorWidget:
                              (context, url, error) => const Icon(
                                Icons.flag,
                                size: 24,
                                color: Color(0xFF8B7355),
                              ),
                        ),
                      )
                      : const Icon(
                        Icons.flag,
                        size: 24,
                        color: Color(0xFF8B7355),
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
                        color: Theme.of(context).colorScheme.onSurface,
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
                    GestureDetector(
                      onTap: () async {
                        await VisitedService.toggleCountry(country.countryId);
                        if (mounted) setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.space2,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isVisited
                                  ? Colors.green.withValues(alpha: 0.15)
                                  : Theme.of(
                                    context,
                                  ).colorScheme.primary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusFull,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isVisited
                                  ? Icons.check_circle
                                  : Icons.check_circle_outline,
                              size: 14,
                              color:
                                  isVisited
                                      ? Colors.green
                                      : Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              isVisited ? 'Visited' : 'Mark visited',
                              style: GoogleFonts.dmSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color:
                                    isVisited
                                        ? Colors.green
                                        : Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
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
