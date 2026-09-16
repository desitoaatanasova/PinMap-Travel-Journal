import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinmap_travel_journal/screens/trips_screen.dart';
import 'package:pinmap_travel_journal/screens/wishlist_screen.dart';
import 'package:pinmap_travel_journal/screens/storage_manager_screen.dart';
import 'package:pinmap_travel_journal/services/api_config.dart';
import 'package:pinmap_travel_journal/services/auth_service.dart';
import 'package:pinmap_travel_journal/services/language_service.dart';
import 'package:pinmap_travel_journal/services/profile_service.dart';
import 'package:pinmap_travel_journal/services/settings_service.dart';
import 'package:pinmap_travel_journal/services/theme_service.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';
import 'package:pinmap_travel_journal/l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _offlineModeEnabled = false;
  bool _isProfilePrivate = false;
  ThemeMode _themeMode = ThemeMode.system;
  String _selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await SettingsService.getSettings();
    final profile = await ProfileService.getProfile();
    await LanguageService.syncFromServer(settings.language);
    if (mounted) {
      setState(() {
        _notificationsEnabled = settings.notificationsEnabled;
        _offlineModeEnabled = settings.offlineModeEnabled;
        _selectedLanguage = LanguageService.currentLanguage;
        _isProfilePrivate = profile.profileStatus == 'private';
        _themeMode = ThemeService.mode;
      });
    }
  }

  String _themeLabel(ThemeMode mode, AppLocalizations l10n) {
    switch (mode) {
      case ThemeMode.light:
        return l10n.settingsThemeLight;
      case ThemeMode.dark:
        return l10n.settingsThemeDark;
      case ThemeMode.system:
        return l10n.settingsThemeSystem;
    }
  }

  void _onNotificationsChanged(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });
    SettingsService.updateSettings(notificationsEnabled: value);
  }

  void _onOfflineChanged(bool value) {
    setState(() {
      _offlineModeEnabled = value;
    });
    SettingsService.updateSettings(offlineModeEnabled: value);
  }

  void _onProfileStatusChanged(bool value) {
    setState(() {
      _isProfilePrivate = value;
    });
    ProfileService.updateProfile(profileStatus: value ? 'private' : 'public');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBody: true,
      appBar: AppBar(
        title: Text(
          l10n.settingsTitle,
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionHeader(context, l10n.settingsAccount),
            const SizedBox(height: AppTheme.space2),
            _buildSettingsRow(
              context,
              icon: Icons.work_outline,
              title: l10n.settingsMyTrips,
              subtitle: l10n.settingsMyTripsSubtitle,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TripsScreen()),
                );
              },
            ),
            _buildSettingsRow(
              context,
              icon: Icons.bookmark_border_outlined,
              title: l10n.settingsMyWishlist,
              subtitle: l10n.settingsMyWishlistSubtitle,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WishListScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: AppTheme.space6),
            _buildSectionHeader(context, l10n.settingsPreferences),
            const SizedBox(height: AppTheme.space2),
            _buildToggleRow(
              context,
              icon: Icons.notifications_outlined,
              title: l10n.settingsNotifications,
              subtitle: l10n.settingsNotificationsSubtitle,
              value: _notificationsEnabled,
              onChanged: _onNotificationsChanged,
            ),
            _buildToggleRow(
              context,
              icon: Icons.cloud_off_outlined,
              title: l10n.settingsOffline,
              subtitle:
                  _offlineModeEnabled
                      ? l10n.settingsOfflineEnabled
                      : l10n.settingsOfflineDisabled,
              value: _offlineModeEnabled,
              onChanged: _onOfflineChanged,
            ),
            _buildToggleRow(
              context,
              icon: Icons.lock_outlined,
              title: l10n.settingsProfileStatus,
              subtitle:
                  _isProfilePrivate
                      ? l10n.settingsProfilePrivate
                      : l10n.settingsProfilePublic,
              value: _isProfilePrivate,
              onChanged: _onProfileStatusChanged,
            ),
            const SizedBox(height: AppTheme.space6),
            _buildSectionHeader(context, l10n.settingsGeneral),
            const SizedBox(height: AppTheme.space2),
            _buildLanguageSelector(context),
            _buildSettingsRow(
              context,
              icon: Icons.palette_outlined,
              title: l10n.settingsTheme,
              subtitle: _themeLabel(_themeMode, l10n),
              onTap: _showThemePicker,
            ),
            _buildServerAddressRow(context),
            _buildSettingsRow(
              context,
              icon: Icons.storage_outlined,
              title: l10n.settingsStorage,
              subtitle: l10n.settingsStorageSubtitle,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StorageManagerScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: AppTheme.space6),
            _buildSectionHeader(context, l10n.settingsDangerZone),
            const SizedBox(height: AppTheme.space2),
            _buildDeleteAccountButton(context),
            const SizedBox(height: AppTheme.space6),
            _buildLogoutButton(context),
            const SizedBox(height: AppTheme.space12),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: AppTheme.space2),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.dmSans(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.primary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildToggleRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.space2),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: AppTheme.shadowSm,
      ),
      child: SwitchListTile(
        secondary: Icon(icon, color: colorScheme.primary),
        title: Text(
          title,
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.dmSans(fontSize: 12, color: AppTheme.warmGray),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTheme.space4,
          vertical: AppTheme.space2,
        ),
      ),
    );
  }

  Widget _buildLanguageSelector(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.space2),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: AppTheme.shadowSm,
      ),
      child: ListTile(
        leading: Icon(Icons.language, color: colorScheme.primary),
        title: Text(
          l10n.settingsLanguage,
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          LanguageService.endonymForLanguage(_selectedLanguage),
          style: GoogleFonts.dmSans(fontSize: 12, color: AppTheme.warmGray),
        ),
        trailing: Icon(Icons.chevron_right, color: AppTheme.warmGray),
        onTap: () => _showLanguagePicker(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTheme.space4,
          vertical: AppTheme.space2,
        ),
      ),
    );
  }

  Widget _buildSettingsRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.space2),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: AppTheme.shadowSm,
      ),
      child: ListTile(
        leading: Icon(icon, color: colorScheme.primary),
        title: Text(
          title,
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.dmSans(fontSize: 12, color: AppTheme.warmGray),
        ),
        trailing: Icon(Icons.chevron_right, color: AppTheme.warmGray),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTheme.space4,
          vertical: AppTheme.space2,
        ),
      ),
    );
  }

  Widget _buildServerAddressRow(BuildContext context) {
    final override = ApiConfig.serverOverride;
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.space2),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: AppTheme.shadowSm,
      ),
      child: ListTile(
        leading: Icon(Icons.dns_outlined, color: colorScheme.primary),
        title: Text(
          l10n.settingsServerAddress,
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          override.isEmpty
              ? l10n.settingsServerDefault(ApiConfig.baseUrl)
              : override,
          style: GoogleFonts.dmSans(fontSize: 12, color: AppTheme.warmGray),
        ),
        trailing: Icon(Icons.chevron_right, color: AppTheme.warmGray),
        onTap: () => _showServerAddressDialog(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTheme.space4,
          vertical: AppTheme.space2,
        ),
      ),
    );
  }

  void _showServerAddressDialog() {
    final controller = TextEditingController(text: ApiConfig.serverOverride);
    final l10n = AppLocalizations.of(context);
    showDialog<void>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(
              l10n.settingsServerAddress,
              style: GoogleFonts.playfairDisplay(
                color: Theme.of(dialogContext).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.settingsServerDialogText,
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    color: AppTheme.warmGray,
                  ),
                ),
                const SizedBox(height: AppTheme.space3),
                TextField(
                  controller: controller,
                  keyboardType: TextInputType.url,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: 'http://192.168.1.50:3001',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  controller.dispose();
                  Navigator.pop(dialogContext);
                },
                child: Text(
                  l10n.commonCancel,
                  style: GoogleFonts.dmSans(color: AppTheme.warmGray),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final text = controller.text;
                  controller.dispose();
                  await ApiConfig.setOverride(text);
                  if (mounted) {
                    Navigator.pop(dialogContext);
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          l10n.settingsServerUpdated,
                          style: GoogleFonts.dmSans(),
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Text(l10n.commonSave, style: GoogleFonts.dmSans()),
              ),
            ],
          ),
    ).whenComplete(() => controller.dispose());
  }

  void _showThemePicker() {
    const options = [ThemeMode.system, ThemeMode.light, ThemeMode.dark];
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      builder:
          (sheetContext) => Container(
            padding: const EdgeInsets.all(AppTheme.space4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.settingsSelectTheme,
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(sheetContext).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: AppTheme.space4),
                ...options.map((mode) {
                  final selected = _themeMode == mode;
                  final scheme = Theme.of(sheetContext).colorScheme;
                  return ListTile(
                    title: Text(
                      _themeLabel(mode, l10n),
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight:
                            selected ? FontWeight.w600 : FontWeight.normal,
                        color: selected ? scheme.primary : scheme.onSurface,
                      ),
                    ),
                    trailing:
                        selected
                            ? Icon(Icons.check, color: scheme.primary)
                            : null,
                    onTap: () {
                      setState(() {
                        _themeMode = mode;
                      });
                      ThemeService.setMode(mode);
                      Navigator.pop(context);
                    },
                  );
                }),
              ],
            ),
          ),
    );
  }

  void _showLanguagePicker() {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      builder:
          (sheetContext) => Container(
            padding: const EdgeInsets.all(AppTheme.space4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.settingsSelectLanguage,
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(sheetContext).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: AppTheme.space4),
                ...LanguageService.supportedLanguages.map((lang) {
                  final selected = _selectedLanguage == lang;
                  final scheme = Theme.of(sheetContext).colorScheme;
                  return ListTile(
                    title: Text(
                      LanguageService.endonymForLanguage(lang),
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight:
                            selected ? FontWeight.w600 : FontWeight.normal,
                        color: selected ? scheme.primary : scheme.onSurface,
                      ),
                    ),
                    trailing:
                        selected
                            ? Icon(Icons.check, color: scheme.primary)
                            : null,
                    onTap: () {
                      setState(() {
                        _selectedLanguage = lang;
                      });
                      LanguageService.setLanguage(lang);
                      SettingsService.updateSettings(language: lang);
                      Navigator.pop(context);
                    },
                  );
                }),
              ],
            ),
          ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: AppTheme.shadowSm,
      ),
      child: ListTile(
        leading: const Icon(Icons.logout, color: Colors.red),
        title: Text(
          l10n.settingsLogout,
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.red,
          ),
        ),
        onTap: () => _confirmLogout(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTheme.space4,
          vertical: AppTheme.space2,
        ),
      ),
    );
  }

  Widget _buildDeleteAccountButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: AppTheme.shadowSm,
      ),
      child: ListTile(
        leading: const Icon(Icons.delete_forever, color: Colors.red),
        title: Text(
          l10n.settingsDeleteAccount,
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.red,
          ),
        ),
        subtitle: Text(
          l10n.settingsDeleteAccountSubtitle,
          style: GoogleFonts.dmSans(fontSize: 12, color: AppTheme.warmGray),
        ),
        onTap: () => _confirmDeleteAccount(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTheme.space4,
          vertical: AppTheme.space2,
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(
              l10n.settingsLogoutConfirmTitle,
              style: GoogleFonts.playfairDisplay(
                color: Theme.of(dialogContext).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              l10n.settingsLogoutConfirmText,
              style: GoogleFonts.dmSans(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  l10n.commonCancel,
                  style: GoogleFonts.dmSans(color: AppTheme.warmGray),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await AuthService.logout();
                  if (context.mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (route) => false,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: Text(l10n.settingsLogout, style: GoogleFonts.dmSans()),
              ),
            ],
          ),
    );
  }

  void _confirmDeleteAccount(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              l10n.settingsDeleteAccountConfirmTitle,
              style: GoogleFonts.playfairDisplay(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              l10n.settingsDeleteAccountConfirmText,
              style: GoogleFonts.dmSans(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  l10n.commonCancel,
                  style: GoogleFonts.dmSans(color: AppTheme.warmGray),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        l10n.settingsDeleteAccountSoon,
                        style: GoogleFonts.dmSans(),
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: Text(l10n.settingsDelete, style: GoogleFonts.dmSans()),
              ),
            ],
          ),
    );
  }
}
