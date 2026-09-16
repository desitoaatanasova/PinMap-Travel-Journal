import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinmap_travel_journal/models/journal.dart';
import 'package:pinmap_travel_journal/models/user_profile.dart';
import 'package:pinmap_travel_journal/l10n/app_localizations.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';
import 'package:pinmap_travel_journal/services/image_compressor.dart';
import 'package:pinmap_travel_journal/services/journal_service.dart';
import 'package:pinmap_travel_journal/services/profile_service.dart';
import 'package:pinmap_travel_journal/widgets/authenticated_image.dart';
import 'package:pinmap_travel_journal/services/visited_service.dart';
import 'package:pinmap_travel_journal/screens/journal_view_screen.dart';
import 'package:pinmap_travel_journal/screens/settings_screen.dart';
import 'package:pinmap_travel_journal/screens/user_search_screen.dart';
import 'package:pinmap_travel_journal/widgets/section_header.dart';
import 'package:pinmap_travel_journal/utils/snackbar_helper.dart';
import 'package:pinmap_travel_journal/utils/dialog_helper.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfile? _profile;
  bool _uploadingPhoto = false;
  List<Journal> _journals = [];

  @override
  void initState() {
    super.initState();
    _loadProfile();
    JournalService.version.addListener(_onJournalsChanged);
  }

  @override
  void dispose() {
    JournalService.version.removeListener(_onJournalsChanged);
    super.dispose();
  }

  void _onJournalsChanged() {
    final p = _profile;
    if (p == null) return;
    _loadJournals(p.userId);
  }

  Future<void> _loadProfile() async {
    final p = await ProfileService.getProfile();
    if (mounted) setState(() => _profile = p);
    _loadJournals(p.userId);
  }

  Future<void> _loadJournals(int userId) async {
    try {
      final js = await JournalService.getPublicJournals(userId);
      if (mounted) setState(() => _journals = js);
    } catch (_) {
      if (mounted) setState(() => _journals = []);
    }
  }

  Future<void> _uploadPhoto() async {
    final l10n = AppLocalizations.of(context);
    final picker = ImagePicker();
    final file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 88,
      maxWidth: 1080,
    );
    if (file == null) return;
    Uint8List bytes = await file.readAsBytes();

    if (!mounted) return;
    setState(() => _uploadingPhoto = true);
    try {
      await ApiClient.uploadMultipart(
        '/profile/photos',
        fields: const {},
        files: [
          MultipartFileSpec(
            field: 'photo',
            bytes: bytes,
            filename: 'photo.jpg',
            contentType: 'image/jpeg',
          ),
        ],
      );
      await ProfileService.reloadProfile();
      if (!mounted) return;
      await _loadProfile();
      showAppSnackBar(context, l10n.profilePhotoDone);
    } catch (e) {
      if (!mounted) return;
      showAppSnackBar(context, l10n.profilePhotoError);
    } finally {
      if (mounted) setState(() => _uploadingPhoto = false);
    }
  }

  Future<void> _deletePhoto(int photoId) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showAppConfirmDialog(
      context,
      title: l10n.profileDeletePhotoTitle,
      content: l10n.profileDeletePhotoText,
      confirmText: l10n.settingsDelete,
      cancelText: l10n.commonCancel,
      confirmColor: Colors.red,
    );
    if (confirmed != true) return;
    try {
      await ApiClient.delete('/profile/photos/$photoId');
      await ProfileService.reloadProfile();
      if (!mounted) return;
      await _loadProfile();
    } catch (e) {
      if (!mounted) return;
      showAppSnackBar(context, l10n.profilePhotoDeleteError);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final profile = _profile;

    return Scaffold(
      extendBody: true,
      body:
          profile == null
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
                            AuthenticatedCachedImage(
                              imageUrl: profile.travelPhotos[0],
                              fit: BoxFit.cover,
                              placeholder:
                                  (context, url) => Container(
                                    color: AppTheme.primary,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                              errorWidget:
                                  (context, url, error) =>
                                      Container(color: AppTheme.primary),
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
                                _buildAvatar(context, profile),
                                const SizedBox(width: AppTheme.space4),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        l10n.profileTagline,
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
                      child: _buildStatsRow(context, profile, l10n),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppTheme.space4,
                        0,
                        AppTheme.space4,
                        AppTheme.space2,
                      ),
                      child: _buildSearchBar(context),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.space4,
                      ),
                      child: SectionHeader(title: l10n.profilePhotos),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(AppTheme.space4),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        if (index == 0) {
                          return _buildUploadTile(context);
                        }
                        final photoIndex = index - 1;
                        final photo = profile.travelPhotos[photoIndex];
                        final photoId =
                            profile.travelPhotoIds.length > photoIndex
                                ? profile.travelPhotoIds[photoIndex]
                                : null;
                        return _buildPhotoThumbnail(photo, photoId);
                      }, childCount: profile.travelPhotos.length + 1),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: AppTheme.space2,
                            mainAxisSpacing: AppTheme.space2,
                          ),
                    ),
                  ),
                  if (_journals.isNotEmpty) ...[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.space4,
                        ),
                        child: SectionHeader(title: l10n.profileJournals),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(AppTheme.space4),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return _buildJournalCard(_journals[index]);
                        }, childCount: _journals.length),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: AppTheme.space4,
                              mainAxisSpacing: AppTheme.space4,
                              childAspectRatio: 0.75,
                            ),
                      ),
                    ),
                  ],
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

  Widget _buildAvatar(BuildContext context, UserProfile profile) {
    final pic = profile.profilePicture;
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
                  child: Text(
                    profile.username.isNotEmpty
                        ? profile.username[0].toUpperCase()
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
          profile.username.isNotEmpty ? profile.username[0].toUpperCase() : '?',
          style: GoogleFonts.playfairDisplay(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow(
    BuildContext context,
    UserProfile profile,
    AppLocalizations l10n,
  ) {
    final placesCount =
        profile.placesVisited > 0
            ? profile.placesVisited
            : VisitedService.visitedPlaceIds.length;
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(AppTheme.space4),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: AppTheme.shadowSm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStat(context, '$placesCount', l10n.profileStatPlaces, Icons.public),
          _buildStat(
            context,
            '${profile.tripsPlanned}',
            l10n.profileStatTrips,
            Icons.luggage,
          ),
          _buildStat(
            context,
            '${profile.followersCount}',
            l10n.profileStatFollowers,
            Icons.people,
          ),
          _buildStat(
            context,
            '${profile.followingCount}',
            l10n.profileStatFollowing,
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

  Widget _buildSearchBar(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UserSearchScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(AppTheme.space3),
        decoration: BoxDecoration(
          color:
              Theme.of(context).cardTheme.color ??
              Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, size: 20, color: AppTheme.warmGray),
            const SizedBox(width: AppTheme.space2),
            Text(
              l10n.profileFindTravellers,
              style: GoogleFonts.dmSans(fontSize: 14, color: AppTheme.warmGray),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadTile(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final primary = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: _uploadingPhoto ? null : _uploadPhoto,
      child: Container(
        decoration: BoxDecoration(
          color: primary.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
          border: Border.all(color: primary.withValues(alpha: 0.25)),
        ),
        child:
            _uploadingPhoto
                ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_a_photo,
                      size: 28,
                      color: primary.withValues(alpha: 0.7),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.profileAdd,
                      style: GoogleFonts.dmSans(fontSize: 12, color: primary),
                    ),
                  ],
                ),
      ),
    );
  }

  Widget _buildPhotoThumbnail(String url, int? photoId) {
    return GestureDetector(
      onLongPress: photoId == null ? null : () => _deletePhoto(photoId),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
        child: AuthenticatedCachedImage(
          imageUrl: url,
          fit: BoxFit.cover,
          placeholder:
              (context, url) => Container(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: const Center(child: CircularProgressIndicator()),
              ),
          errorWidget:
              (context, url, error) => Container(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
        ),
      ),
    );
  }

  Widget _buildJournalCard(Journal journal) {
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
                        'Public',
                        style: GoogleFonts.dmSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppTheme.space3),
              child: Text(
                journal.title,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 15,
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

  Widget _buildActionButtons(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        OutlinedButton.icon(
          onPressed: _showEditProfileDialog,
          icon: const Icon(Icons.person_outline, size: 20),
          label: Text(l10n.profileEdit),
          style: OutlinedButton.styleFrom(
            foregroundColor: colorScheme.primary,
            side: BorderSide(color: colorScheme.primary, width: 2),
            minimumSize: const Size(double.infinity, 48),
          ),
        ),
        const SizedBox(height: AppTheme.space3),
        OutlinedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
          icon: const Icon(Icons.settings, size: 20),
          label: Text(l10n.settingsTitle),
          style: OutlinedButton.styleFrom(
            foregroundColor: colorScheme.onSurface,
            side: BorderSide(color: colorScheme.outlineVariant),
            minimumSize: const Size(double.infinity, 48),
          ),
        ),
      ],
    );
  }

  void _showEditProfileDialog() {
    final l10n = AppLocalizations.of(context);
    final profile = _profile;
    if (profile == null) return;
    final firstNameController = TextEditingController(
      text: profile.firstName ?? '',
    );
    final lastNameController = TextEditingController(
      text: profile.lastName ?? '',
    );
    final bioController = TextEditingController(text: profile.bio ?? '');

    showDialog<void>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(
              l10n.profileEdit,
              style: GoogleFonts.playfairDisplay(
                color: Theme.of(dialogContext).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      labelText: l10n.profileFirstName,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: AppTheme.space3),
                  TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      labelText: l10n.profileLastName,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: AppTheme.space3),
                  TextField(
                    controller: bioController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: l10n.profileBio,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  firstNameController.dispose();
                  lastNameController.dispose();
                  bioController.dispose();
                  Navigator.pop(dialogContext);
                },
                child: Text(
                  l10n.commonCancel,
                  style: GoogleFonts.dmSans(color: AppTheme.warmGray),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final first = firstNameController.text;
                  final last = lastNameController.text;
                  final bio = bioController.text;
                  firstNameController.dispose();
                  lastNameController.dispose();
                  bioController.dispose();
                  await ProfileService.updateProfile(
                    firstName: first,
                    lastName: last,
                    bio: bio,
                  );
                  await ProfileService.reloadProfile();
                  if (dialogContext.mounted) Navigator.pop(dialogContext);
                  if (mounted) {
                    await _loadProfile();
                    showAppSnackBar(context, l10n.profileSaved);
                  }
                },
                child: Text(l10n.commonSave, style: GoogleFonts.dmSans()),
              ),
            ],
          ),
    ).whenComplete(() {
      firstNameController.dispose();
      lastNameController.dispose();
      bioController.dispose();
    });
  }
}
