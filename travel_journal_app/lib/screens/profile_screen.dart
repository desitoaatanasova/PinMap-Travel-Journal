import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinmap_travel_journal/models/user_profile.dart';
import 'package:pinmap_travel_journal/services/profile_service.dart';
import 'package:pinmap_travel_journal/services/visited_service.dart';
import 'package:pinmap_travel_journal/screens/settings_screen.dart';
import 'package:pinmap_travel_journal/widgets/section_header.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfile? _profile;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final p = await ProfileService.getProfile();
    if (mounted) setState(() => _profile = p);
  }

  @override
  Widget build(BuildContext context) {
    final profile = _profile;

    return Scaffold(
      backgroundColor: AppTheme.bg,
      extendBody: true,
      body: profile == null
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: AppTheme.primary,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  if (profile.travelPhotos.isNotEmpty)
                    CachedNetworkImage(
                      imageUrl: profile.travelPhotos[0],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: AppTheme.primary,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppTheme.primary,
                      ),
                    ),
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
                        _buildAvatar(profile),
                        const SizedBox(width: AppTheme.space4),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                profile.username,
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              if (profile.bio != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  profile.bio!,
                                  style: GoogleFonts.dmSans(
                                    fontSize: 13,
                                    color: AppTheme.warmOffWhite,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                              const SizedBox(height: 4),
                              Text(
                                'Travel enthusiast',
                                style: GoogleFonts.dmSans(
                                  fontSize: 11,
                                  color: AppTheme.warmOffWhite
                                      .withValues(alpha: 0.8),
                                ),
                              ),
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
              child: _buildStatsRow(profile),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.space4),
              child: const SectionHeader(title: 'Travel Photos'),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(AppTheme.space4),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final photo = profile.travelPhotos[index];
                  return _buildPhotoThumbnail(photo);
                },
                childCount: profile.travelPhotos.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: AppTheme.space2,
                mainAxisSpacing: AppTheme.space2,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.space4),
              child: _buildActionButtons(context),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppTheme.space12),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(UserProfile profile) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: AppTheme.shadowMd,
      ),
      child: CircleAvatar(
        radius: 36,
        backgroundColor: AppTheme.card,
        backgroundImage: profile.profilePicture != null
            ? NetworkImage(profile.profilePicture!)
            : null,
        child: profile.profilePicture == null
            ? Text(
                profile.username.isNotEmpty
                    ? profile.username[0].toUpperCase()
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

  Widget _buildStatsRow(UserProfile profile) {
    final placesCount = profile.placesVisited > 0
        ? profile.placesVisited
        : VisitedService.visitedPlaceIds.length;
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
          _buildStat('$placesCount', 'Places', Icons.public),
          _buildStat('${profile.tripsPlanned}', 'Trips', Icons.luggage),
          _buildStat('${profile.followersCount}', 'Followers', Icons.people),
          _buildStat('${profile.followingCount}', 'Following', Icons.person_add),
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

  Widget _buildPhotoThumbnail(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppTheme.radiusSm),
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: AppTheme.lightGray,
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => Container(
          color: AppTheme.lightGray,
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        OutlinedButton.icon(
          onPressed: _showEditProfileDialog,
          icon: const Icon(Icons.person_outline, size: 20),
          label: const Text('Edit Profile'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppTheme.primary,
            side: BorderSide(color: AppTheme.primary, width: 2),
            minimumSize: const Size(double.infinity, 48),
          ),
        ),
        const SizedBox(height: AppTheme.space3),
        OutlinedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsScreen(),
              ),
            );
          },
          icon: const Icon(Icons.settings, size: 20),
          label: const Text('Settings'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppTheme.darkBrown,
            side: BorderSide(color: AppTheme.warmGray),
            minimumSize: const Size(double.infinity, 48),
          ),
        ),
      ],
    );
  }

  void _showEditProfileDialog() {
    final profile = _profile;
    if (profile == null) return;
    final firstNameController =
        TextEditingController(text: profile.firstName ?? '');
    final lastNameController =
        TextEditingController(text: profile.lastName ?? '');
    final bioController = TextEditingController(text: profile.bio ?? '');

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          'Edit Profile',
          style: GoogleFonts.playfairDisplay(
            color: AppTheme.darkBrown,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: AppTheme.space3),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: AppTheme.space3),
              TextField(
                controller: bioController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Bio',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Cancel',
              style: GoogleFonts.dmSans(color: AppTheme.warmGray),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await ProfileService.updateProfile(
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                bio: bioController.text,
              );
              await ProfileService.reloadProfile();
              if (dialogContext.mounted) Navigator.pop(dialogContext);
              if (mounted) {
                await _loadProfile();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Profile updated',
                      style: GoogleFonts.dmSans(),
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            child: Text('Save', style: GoogleFonts.dmSans()),
          ),
        ],
      ),
    );
  }

}
