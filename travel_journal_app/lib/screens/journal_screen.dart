import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinmap_travel_journal/models/journal.dart';
import 'package:pinmap_travel_journal/services/journal_service.dart';
import 'package:pinmap_travel_journal/screens/journal_editor_screen.dart';
import 'package:pinmap_travel_journal/widgets/premium_card.dart';
import 'package:pinmap_travel_journal/widgets/empty_state.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chapters = JournalService.getAllChapters();

    // Group chapters by country
    final grouped = <String, List<JournalChapter>>{};
    for (final chapter in chapters) {
      grouped.putIfAbsent(chapter.country, () => []).add(chapter);
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
              child: _buildNewChapterCard(context),
            ),
          ),
          if (chapters.isEmpty)
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
              final countryChapters = entry.value;
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
                        itemCount: countryChapters.length,
                        itemBuilder: (context, index) {
                          final chapter = countryChapters[index];
                          return _buildChapterCard(context, chapter);
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

  Widget _buildNewChapterCard(BuildContext context) {
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
                        'New Chapter',
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

  Widget _buildChapterCard(BuildContext context, JournalChapter chapter) {
    return PremiumCard(
      padding: EdgeInsets.zero,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                JournalEditorScreen(chapterId: chapter.id),
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
              child: chapter.coverImageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: chapter.coverImageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => _buildCoverFallback(chapter),
                      errorWidget: (context, url, error) => _buildCoverFallback(chapter),
                    )
                  : _buildCoverFallback(chapter),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppTheme.space3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chapter.title,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkBrown,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 12,
                      color: AppTheme.warmGray,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${_monthName(chapter.date.month)} ${chapter.date.day}',
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        color: AppTheme.warmGray,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.space1),
                Text(
                  chapter.previewText,
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    color: AppTheme.warmGray,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppTheme.space2),
                Row(
                  children: [
                    Icon(
                      Icons.article_outlined,
                      size: 14,
                      color: chapter.accentColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${chapter.entries.length} entries',
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: chapter.accentColor,
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

  Widget _buildCoverFallback(JournalChapter chapter) {
    return Container(
      color: chapter.accentColor.withValues(alpha: 0.15),
      child: Center(
        child: Icon(
          Icons.book,
          size: 48,
          color: chapter.accentColor.withValues(alpha: 0.5),
        ),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}
