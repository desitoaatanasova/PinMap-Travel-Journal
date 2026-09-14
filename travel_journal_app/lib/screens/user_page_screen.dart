import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinmap_travel_journal/models/journal.dart';
import 'package:pinmap_travel_journal/models/user_profile.dart';
import 'package:pinmap_travel_journal/widgets/authenticated_image.dart';
import 'package:pinmap_travel_journal/screens/journal_view_screen.dart';
import 'package:pinmap_travel_journal/services/journal_service.dart';
import 'package:pinmap_travel_journal/services/social_service.dart';
import 'package:pinmap_travel_journal/widgets/section_header.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class UserPageScreen extends StatefulWidget {
  final UserProfile user;

  const UserPageScreen({super.key, required this.user});

  @override
  State<UserPageScreen> createState() => _UserPageScreenState();
}

class _UserPageScreenState extends State<UserPageScreen> {
  late UserProfile _user;
  bool _busy = false;
  List<Journal> _journals = [];

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _loadJournals();
  }

  Future<void> _refresh() async {
    final u = await SocialService.getUserProfile(_user.userId);
    if (mounted) setState(() => _user = u);
    await _loadJournals();
  }

  Future<void> _loadJournals() async {
    if (_user.isPrivate) {
      if (mounted) setState(() => _journals = []);
      return;
    }
    try {
      final js = await JournalService.getPublicJournals(_user.userId);
      if (mounted) setState(() => _journals = js);
    } catch (_) {
      if (mounted) setState(() => _journals = []);
    }
  }

  Future<void> _toggleFollow() async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      if (_user.isFollowing) {
        await SocialService.unfollow(_user.userId);
      } else {
        await SocialService.follow(_user.userId);
      }
      await _refresh();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Could not update follow status',
              style: GoogleFonts.dmSans(),
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: AppTheme.primary,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  if (_user.travelPhotos.isNotEmpty)
                    AuthenticatedCachedImage(
                      imageUrl: _user.travelPhotos[0],
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) => Container(color: AppTheme.primary),
                      errorWidget:
                          (context, url, error) =>
                              Container(color: AppTheme.primary),
                    )
                  else
                    Container(color: AppTheme.primary),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppTheme.primary.withValues(alpha: 0.85),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: AppTheme.space4,
                    right: AppTheme.space4,
                    bottom: AppTheme.space6,
                    child: Row(
                      children: [
                        _buildAvatar(),
                        const SizedBox(width: AppTheme.space4),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _user.username,
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              if (_user.bio != null &&
                                  _user.bio!.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Text(
                                  _user.bio!,
                                  style: GoogleFonts.dmSans(
                                    fontSize: 13,
                                    color: AppTheme.warmOffWhite,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.space4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildStatsRow(context),
                  const SizedBox(height: AppTheme.space4),
                  ElevatedButton.icon(
                    onPressed: _busy ? null : _toggleFollow,
                    icon:
                        _busy
                            ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                            : Icon(
                              _user.isFollowing
                                  ? Icons.person_remove
                                  : Icons.person_add,
                              size: 20,
                            ),
                    label: Text(
                      _user.isFollowing ? 'Unfollow' : 'Follow',
                      style: GoogleFonts.dmSans(),
                    ),
                    style:
                        _user.isFollowing
                            ? ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).cardTheme.color ??
                                  Theme.of(context).colorScheme.surface,
                              foregroundColor:
                                  Theme.of(context).colorScheme.primary,
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2,
                              ),
                              minimumSize: const Size(double.infinity, 48),
                            )
                            : ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 48),
                            ),
                  ),
                  const SizedBox(height: AppTheme.space4),
                  if (_user.isPrivate) ...[
                    Container(
                      padding: const EdgeInsets.all(AppTheme.space4),
                      decoration: BoxDecoration(
                        color:
                            Theme.of(context).cardTheme.color ??
                            Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                      ),
                      child: Text(
                        'This profile is private. Follow ${_user.username} to see their travel photos.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          color: AppTheme.warmGray,
                        ),
                      ),
                    ),
                  ] else if (_user.travelPhotos.isNotEmpty) ...[
                    _buildPhotosGrid(),
                  ],
                  if (!_user.isPrivate && _journals.isNotEmpty) ...[
                    const SizedBox(height: AppTheme.space6),
                    _buildJournalsGrid(),
                  ],
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppTheme.space12)),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    final pic = _user.profilePicture;
    if (pic != null) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: AppTheme.shadowMd,
        ),
        child: ClipOval(
          child: AuthenticatedCachedImage(
            imageUrl: pic,
            width: 72,
            height: 72,
            fit: BoxFit.cover,
            placeholder:
                (context, url) => Container(
                  width: 72,
                  height: 72,
                  color:
                      Theme.of(context).cardTheme.color ??
                      Theme.of(context).colorScheme.surface,
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
            errorWidget:
                (context, url, error) => Container(
                  width: 72,
                  height: 72,
                  color:
                      Theme.of(context).cardTheme.color ??
                      Theme.of(context).colorScheme.surface,
                  child: Center(
                    child: Text(
                      _user.username.isNotEmpty
                          ? _user.username[0].toUpperCase()
                          : '?',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
                ),
          ),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: AppTheme.shadowMd,
      ),
      child: CircleAvatar(
        radius: 36,
        backgroundColor:
            Theme.of(context).cardTheme.color ??
            Theme.of(context).colorScheme.surface,
        child: Text(
          _user.username.isNotEmpty ? _user.username[0].toUpperCase() : '?',
          style: GoogleFonts.playfairDisplay(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.space4),
      decoration: BoxDecoration(
        color:
            Theme.of(context).cardTheme.color ??
            Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: AppTheme.shadowSm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStat(context, '${_user.placesVisited}', 'Places', Icons.public),
          _buildStat(context, '${_user.tripsPlanned}', 'Trips', Icons.luggage),
          _buildStat(
            context,
            '${_user.followersCount}',
            'Followers',
            Icons.people,
          ),
          _buildStat(
            context,
            '${_user.followingCount}',
            'Following',
            Icons.person_add,
          ),
        ],
      ),
    );
  }

  Widget _buildStat(
    BuildContext context,
    String value,
    String label,
    IconData icon,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Icon(icon, size: 20, color: colorScheme.primary),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.playfairDisplay(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.dmSans(fontSize: 11, color: AppTheme.warmGray),
        ),
      ],
    );
  }

  Widget _buildPhotosGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Travel Photos',
          style: GoogleFonts.playfairDisplay(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppTheme.space3),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _user.travelPhotos.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: AppTheme.space2,
            mainAxisSpacing: AppTheme.space2,
          ),
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              child: AuthenticatedCachedImage(
                imageUrl: _user.travelPhotos[index],
                fit: BoxFit.cover,
                placeholder:
                    (context, url) => Container(
                      color:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                errorWidget:
                    (context, url, error) => Container(
                      color:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                    ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildJournalsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Journals'),
        const SizedBox(height: AppTheme.space3),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _journals.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppTheme.space4,
            mainAxisSpacing: AppTheme.space4,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final journal = _journals[index];
            final cover = journal.coverImage;
            Widget coverWidget;
            if (cover != null && cover.isNotEmpty) {
              final isUpload = cover.startsWith('/uploads/');
              coverWidget =
                  isUpload
                      ? AuthenticatedCachedImage(
                        imageUrl: cover,
                        fit: BoxFit.cover,
                        errorWidget: (c, u, e) => _buildCoverFallback(),
                      )
                      : CachedNetworkImage(
                        imageUrl: cover,
                        fit: BoxFit.cover,
                        errorWidget: (c, u, e) => _buildCoverFallback(),
                      );
            } else {
              coverWidget = _buildCoverFallback();
            }
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => JournalViewScreen(
                          journalId: journal.journalId,
                          isPublic: true,
                        ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
              child: Container(
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).cardTheme.color ??
                      Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                  boxShadow: AppTheme.shadowSm,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(AppTheme.radiusLg),
                          topRight: Radius.circular(AppTheme.radiusLg),
                        ),
                        child: coverWidget,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppTheme.space3),
                      child: Text(
                        journal.title,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCoverFallback() {
    return Container(
      color: AppTheme.primary.withValues(alpha: 0.15),
      child: Center(
        child: Icon(
          Icons.book,
          size: 36,
          color: AppTheme.primary.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
