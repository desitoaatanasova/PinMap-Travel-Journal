import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinmap_travel_journal/models/journal.dart';
import 'package:pinmap_travel_journal/l10n/app_localizations.dart';
import 'package:pinmap_travel_journal/services/journal_service.dart';
import 'package:pinmap_travel_journal/services/country_service.dart';
import 'package:pinmap_travel_journal/screens/journal_editor_screen.dart';
import 'package:pinmap_travel_journal/screens/journal_view_screen.dart';
import 'package:pinmap_travel_journal/widgets/authenticated_image.dart';
import 'package:pinmap_travel_journal/widgets/premium_card.dart';
import 'package:pinmap_travel_journal/widgets/empty_state.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  String _countryName(int countryId, AppLocalizations l10n) {
    final country =
        CountryService.getAllCountries()
            .where((c) => c.countryId == countryId)
            .firstOrNull;
    return country?.name ?? l10n.journalUnknown;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: JournalService.version,
      builder: (context, _, __) {
        return ValueListenableBuilder<int>(
          valueListenable: CountryService.version,
          builder: (context, _, __) {
            return _buildScaffold(context);
          },
        );
      },
    );
  }

  Widget _buildScaffold(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final journals = JournalService.getAllJournals();

    final grouped = <String, List<Journal>>{};
    for (final journal in journals) {
      final name = _countryName(journal.countryId, l10n);
      grouped.putIfAbsent(name, () => []).add(journal);
    }

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
                l10n.navJournal,
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
              padding: const EdgeInsets.all(AppTheme.space4),
              child: _buildNewJournalCard(context),
            ),
          ),
          if (journals.isEmpty)
            SliverFillRemaining(
              child: EmptyState(
                icon: Icons.menu_book_outlined,
                message: l10n.journalEmpty,
                buttonText: l10n.journalStartWriting,
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
              return SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.space4,
                ),
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppTheme.space2,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.public,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: AppTheme.space2),
                        Text(
                          country.toUpperCase(),
                          style: GoogleFonts.dmSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.primary,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          if (journals.isNotEmpty)
            ...grouped.entries.map((entry) {
              final countryJournals = entry.value;
              return SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.space4,
                ),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                        _buildJournalCard(context, countryJournals[index]),
                    childCount: countryJournals.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppTheme.space4,
                    mainAxisSpacing: AppTheme.space4,
                    childAspectRatio: 0.75,
                  ),
                ),
              );
            }),
          if (journals.isNotEmpty)
            const SliverToBoxAdapter(child: SizedBox(height: AppTheme.space4)),
          const SliverToBoxAdapter(child: SizedBox(height: AppTheme.space12)),
        ],
      ),
    );
  }

  Widget _buildNewJournalCard(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primary, AppTheme.primary.withValues(alpha: 0.7)],
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
                        l10n.journalNew,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: AppTheme.space1),
                      Text(
                        l10n.journalNewHint,
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

  Future<void> _toggleVisibility(BuildContext context, Journal journal) async {
    final l10n = AppLocalizations.of(context);
    final isPublic = journal.visibility == 'public';
    final target = isPublic ? 'private' : 'public';
    final title = isPublic ? l10n.journalRemoveTitle : l10n.journalPostTitle;
    final content =
        isPublic ? l10n.journalRemoveText : l10n.journalPostText;
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(
              title,
              style: GoogleFonts.playfairDisplay(
                color: Theme.of(ctx).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(content, style: GoogleFonts.dmSans()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(
                  l10n.commonCancel,
                  style: GoogleFonts.dmSans(color: AppTheme.warmGray),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(
                  isPublic ? l10n.journalRemoveShort : l10n.journalPost,
                  style: GoogleFonts.dmSans(),
                ),
              ),
            ],
          ),
    );
    if (confirmed != true) return;
    try {
      await JournalService.updateVisibility(journal.journalId, target);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isPublic ? l10n.journalRemoved : l10n.journalPosted,
              style: GoogleFonts.dmSans(),
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              l10n.journalVisibilityError(e.toString()),
              style: GoogleFonts.dmSans(),
            ),
          ),
        );
      }
    }
  }

  Widget _buildJournalCard(BuildContext context, Journal journal) {
    final l10n = AppLocalizations.of(context);
    final isPublic = journal.visibility == 'public';
    final cover = journal.coverImage;
    Widget coverWidget;
    if (cover != null && cover.isNotEmpty) {
      final isUpload = cover.startsWith('/uploads/');
      coverWidget =
          isUpload
              ? AuthenticatedCachedImage(
                imageUrl: cover,
                fit: BoxFit.cover,
                placeholder: (c, u) => _buildCoverFallback(),
                errorWidget: (c, u, e) => _buildCoverFallback(),
              )
              : CachedNetworkImage(
                imageUrl: cover,
                fit: BoxFit.cover,
                memCacheWidth: 400,
                maxWidthDiskCache: 400,
                placeholder: (c, u) => _buildCoverFallback(),
                errorWidget: (c, u, e) => _buildCoverFallback(),
              );
    } else {
      coverWidget = _buildCoverFallback();
    }
    return PremiumCard(
      padding: EdgeInsets.zero,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => JournalEditorScreen(
                  chapterId: journal.journalId.toString(),
                ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppTheme.radiusLg),
                      topRight: Radius.circular(AppTheme.radiusLg),
                    ),
                    child: coverWidget,
                  ),
                ),
                if (isPublic)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        l10n.journalPublic,
                        style: GoogleFonts.dmSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: PopupMenuButton<String>(
                    onSelected: (v) {
                      if (v == 'toggle') _toggleVisibility(context, journal);
                      if (v == 'view') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => JournalViewScreen(
                                  journalId: journal.journalId,
                                  isPublic: false,
                                ),
                          ),
                        );
                      }
                    },
                    itemBuilder:
                        (_) => [
                          PopupMenuItem(
                            value: 'toggle',
                            child: Text(
                              isPublic
                                  ? l10n.journalRemoveProfile
                                  : l10n.journalPost,
                              style: GoogleFonts.dmSans(fontSize: 13),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'view',
                            child: Text(l10n.journalView),
                          ),
                        ],
                  ),
                ),
              ],
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
                    color: Theme.of(context).colorScheme.onSurface,
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
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      l10n.journalPageCount(journal.pages.length),
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary,
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
