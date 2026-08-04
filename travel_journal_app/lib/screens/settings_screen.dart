import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinmap_travel_journal/screens/trips_screen.dart';
import 'package:pinmap_travel_journal/screens/wishlist_screen.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _offlineModeEnabled = false;
  bool _isProfilePrivate = false;
  String _selectedLanguage = 'English';
  final List<String> _languages = const [
    'English',
    'Spanish',
    'French',
    'Japanese',
    'German',
    'Chinese',
    'Italian',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      extendBody: true,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkBrown,
          ),
        ),
        backgroundColor: AppTheme.bg,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionHeader('Account'),
            const SizedBox(height: AppTheme.space2),
            _buildSettingsRow(
              icon: Icons.work_outline,
              title: 'My Trips',
              subtitle: 'View and manage your trips',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TripsScreen(),
                  ),
                );
              },
            ),
            _buildSettingsRow(
              icon: Icons.bookmark_border_outlined,
              title: 'My Wish List',
              subtitle: 'Places you want to visit',
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
            _buildSectionHeader('Preferences'),
            const SizedBox(height: AppTheme.space2),
            _buildToggleRow(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              subtitle: 'Receive travel reminders and updates',
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
            _buildToggleRow(
              icon: Icons.cloud_off_outlined,
              title: 'Available Offline',
              subtitle: _offlineModeEnabled
                  ? '3 trips, 12 photos saved'
                  : 'No content saved offline',
              value: _offlineModeEnabled,
              onChanged: (value) {
                setState(() {
                  _offlineModeEnabled = value;
                });
              },
            ),
            _buildToggleRow(
              icon: Icons.lock_outlined,
              title: 'Profile Status',
              subtitle: _isProfilePrivate
                  ? 'Private - Only followers can see your activity'
                  : 'Public - Anyone can see your activity',
              value: _isProfilePrivate,
              onChanged: (value) {
                setState(() {
                  _isProfilePrivate = value;
                });
              },
            ),
            const SizedBox(height: AppTheme.space6),
            _buildSectionHeader('General'),
            const SizedBox(height: AppTheme.space2),
            _buildLanguageSelector(),
            _buildSettingsRow(
              icon: Icons.palette_outlined,
              title: 'Theme',
              subtitle: 'Light mode',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Theme selection coming soon!',
                      style: GoogleFonts.dmSans(),
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
            _buildSettingsRow(
              icon: Icons.storage_outlined,
              title: 'Storage',
              subtitle: 'Manage downloaded content',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Storage manager coming soon!',
                      style: GoogleFonts.dmSans(),
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
            const SizedBox(height: AppTheme.space6),
            _buildSectionHeader('Danger Zone'),
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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: AppTheme.space2),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.dmSans(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppTheme.primary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildToggleRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.space2),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: AppTheme.shadowSm,
      ),
      child: SwitchListTile(
        secondary: Icon(icon, color: AppTheme.primary),
        title: Text(
          title,
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.darkBrown,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.dmSans(
            fontSize: 12,
            color: AppTheme.warmGray,
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppTheme.space4, vertical: AppTheme.space2),
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.space2),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: AppTheme.shadowSm,
      ),
      child: ListTile(
        leading: Icon(Icons.language, color: AppTheme.primary),
        title: Text(
          'Language',
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.darkBrown,
          ),
        ),
        subtitle: Text(
          _selectedLanguage,
          style: GoogleFonts.dmSans(
            fontSize: 12,
            color: AppTheme.warmGray,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: AppTheme.warmGray,
        ),
        onTap: () => _showLanguagePicker(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppTheme.space4, vertical: AppTheme.space2),
      ),
    );
  }

  Widget _buildSettingsRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.space2),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: AppTheme.shadowSm,
      ),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.primary),
        title: Text(
          title,
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.darkBrown,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.dmSans(
            fontSize: 12,
            color: AppTheme.warmGray,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: AppTheme.warmGray,
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppTheme.space4, vertical: AppTheme.space2),
      ),
    );
  }

  void _showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppTheme.space4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Language',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppTheme.space4),
            ..._languages.map((lang) {
              return ListTile(
                title: Text(
                  lang,
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: _selectedLanguage == lang
                        ? FontWeight.w600
                        : FontWeight.normal,
                    color: _selectedLanguage == lang
                        ? AppTheme.primary
                        : AppTheme.darkBrown,
                  ),
                ),
                trailing: _selectedLanguage == lang
                    ? Icon(Icons.check, color: AppTheme.primary)
                    : null,
                onTap: () {
                  setState(() {
                    _selectedLanguage = lang;
                  });
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
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: AppTheme.shadowSm,
      ),
      child: ListTile(
        leading: const Icon(Icons.logout, color: Colors.red),
        title: Text(
          'Logout',
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
            horizontal: AppTheme.space4, vertical: AppTheme.space2),
      ),
    );
  }

  Widget _buildDeleteAccountButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: AppTheme.shadowSm,
      ),
      child: ListTile(
        leading: const Icon(Icons.delete_forever, color: Colors.red),
        title: Text(
          'Delete Account',
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.red,
          ),
        ),
        subtitle: Text(
          'Permanently delete your account and all data',
          style: GoogleFonts.dmSans(
            fontSize: 12,
            color: AppTheme.warmGray,
          ),
        ),
        onTap: () => _confirmDeleteAccount(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppTheme.space4, vertical: AppTheme.space2),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Logout?',
          style: GoogleFonts.playfairDisplay(
            color: AppTheme.darkBrown,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: GoogleFonts.dmSans(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.dmSans(color: AppTheme.warmGray),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text(
              'Logout',
              style: GoogleFonts.dmSans(),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Account?',
          style: GoogleFonts.playfairDisplay(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'This action cannot be undone. All your data will be permanently deleted.',
          style: GoogleFonts.dmSans(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.dmSans(color: AppTheme.warmGray),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Delete account coming soon!',
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
            child: Text(
              'Delete',
              style: GoogleFonts.dmSans(),
            ),
          ),
        ],
      ),
    );
  }
}
