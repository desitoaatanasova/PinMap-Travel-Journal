import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinmap_travel_journal/models/user_profile.dart';
import 'package:pinmap_travel_journal/services/social_service.dart';
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

  @override
  void initState() {
    super.initState();
    _user = widget.user;
  }

  Future<void> _refresh() async {
    final u = await SocialService.getUserProfile(_user.userId);
    if (mounted) setState(() => _user = u);
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
      backgroundColor: AppTheme.bg,
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
                    CachedNetworkImage(
                      imageUrl: _user.travelPhotos[0],
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(color: AppTheme.primary),
                      errorWidget: (context, url, error) =>
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
                              if (_user.bio != null && _user.bio!.isNotEmpty) ...[
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
                  _buildStatsRow(),
                  const SizedBox(height: AppTheme.space4),
                  ElevatedButton.icon(
                    onPressed: _busy ? null : _toggleFollow,
                    icon: _busy
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
                    style: _user.isFollowing
                        ? ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.card,
                            foregroundColor: AppTheme.primary,
                            side: BorderSide(
                              color: AppTheme.primary,
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
                        color: AppTheme.card,
                        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                        border: Border.all(color: AppTheme.lightGray),
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
                ],
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

  Widget _buildAvatar() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: AppTheme.shadowMd,
      ),
      child: CircleAvatar(
        radius: 36,
        backgroundColor: AppTheme.card,
        backgroundImage: _user.profilePicture != null
            ? NetworkImage(_user.profilePicture!)
            : null,
        child: _user.profilePicture == null
            ? Text(
                _user.username.isNotEmpty
                    ? _user.username[0].toUpperCase()
                    : '?',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary,
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildStatsRow() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.space4),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: AppTheme.shadowSm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStat('${_user.placesVisited}', 'Places', Icons.public),
          _buildStat('${_user.tripsPlanned}', 'Trips', Icons.luggage),
          _buildStat('${_user.followersCount}', 'Followers', Icons.people),
          _buildStat('${_user.followingCount}', 'Following', Icons.person_add),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20, color: AppTheme.primary),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.playfairDisplay(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkBrown,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.dmSans(
            fontSize: 11,
            color: AppTheme.warmGray,
          ),
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
            color: AppTheme.darkBrown,
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
              child: CachedNetworkImage(
                imageUrl: _user.travelPhotos[index],
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppTheme.lightGray,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) =>
                    Container(color: AppTheme.lightGray),
              ),
            );
          },
        ),
      ],
    );
  }
}
