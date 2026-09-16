// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navHome => 'Home';

  @override
  String get navTrips => 'Trips';

  @override
  String get navJournal => 'Journal';

  @override
  String get navWishlist => 'Wish List';

  @override
  String get navProfile => 'Profile';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsAccount => 'Account';

  @override
  String get settingsMyTrips => 'My Trips';

  @override
  String get settingsMyTripsSubtitle => 'View and manage your trips';

  @override
  String get settingsMyWishlist => 'My Wish List';

  @override
  String get settingsMyWishlistSubtitle => 'Places you want to visit';

  @override
  String get settingsPreferences => 'Preferences';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsNotificationsSubtitle =>
      'Receive travel reminders and updates';

  @override
  String get settingsOffline => 'Available Offline';

  @override
  String get settingsOfflineEnabled => 'Offline access enabled';

  @override
  String get settingsOfflineDisabled => 'Offline access disabled';

  @override
  String get settingsProfileStatus => 'Profile Status';

  @override
  String get settingsProfilePrivate =>
      'Private - Only followers can see your activity';

  @override
  String get settingsProfilePublic => 'Public - Anyone can see your activity';

  @override
  String get settingsGeneral => 'General';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsSelectLanguage => 'Select Language';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsSelectTheme => 'Select Theme';

  @override
  String get settingsServerAddress => 'Server address';

  @override
  String settingsServerDefault(String url) {
    return 'Default ($url)';
  }

  @override
  String get settingsServerDialogText =>
      'Where the backend runs. Examples:\n• Home Wi-Fi:  http://192.168.1.50:3001\n• Anywhere:    https://your-tunnel-url\n\nLeave empty to use the default server.';

  @override
  String get settingsServerUpdated => 'Server address updated';

  @override
  String get settingsStorage => 'Storage';

  @override
  String get settingsStorageSubtitle => 'Manage downloaded content';

  @override
  String get settingsDangerZone => 'Danger Zone';

  @override
  String get settingsDeleteAccount => 'Delete Account';

  @override
  String get settingsDeleteAccountSubtitle =>
      'Permanently delete your account and all data';

  @override
  String get settingsDeleteAccountConfirmTitle => 'Delete Account?';

  @override
  String get settingsDeleteAccountConfirmText =>
      'This action cannot be undone. All your data will be permanently deleted.';

  @override
  String get settingsDeleteAccountSoon => 'Delete account coming soon!';

  @override
  String get settingsDelete => 'Delete';

  @override
  String get settingsLogout => 'Logout';

  @override
  String get settingsLogoutConfirmTitle => 'Logout?';

  @override
  String get settingsLogoutConfirmText => 'Are you sure you want to logout?';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSave => 'Save';

  @override
  String get commonClose => 'Close';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonLoading => 'Loading...';

  @override
  String get commonError => 'Something went wrong';

  @override
  String get commonOffline => 'No internet connection';

  @override
  String get commonOk => 'OK';

  @override
  String get commonYes => 'Yes';

  @override
  String get commonNo => 'No';

  @override
  String get commonEdit => 'Edit';

  @override
  String get authWelcomeBack => 'Welcome Back';

  @override
  String get authSignInSubtitle => 'Sign in to continue your journey';

  @override
  String get authEmail => 'Email';

  @override
  String get authPassword => 'Password';

  @override
  String get authForgotPassword => 'Forgot Password?';

  @override
  String get authLogin => 'Log In';

  @override
  String get authNoAccount => 'Don\'t have an account? ';

  @override
  String get authSignUp => 'Sign Up';

  @override
  String get authCreateAccount => 'Create Account';

  @override
  String get authCreateSubtitle => 'Start your travel journal';

  @override
  String get authFullName => 'Full Name';

  @override
  String get authHaveAccount => 'Already have an account? ';

  @override
  String get authEnterValid => 'Please enter valid credentials';

  @override
  String get authFillRequired => 'Please fill all required fields';

  @override
  String get authInvalid => 'Invalid credentials';

  @override
  String get authRegisterFailed => 'Registration failed';

  @override
  String get authSessionFailed => 'Could not start session. Try again.';

  @override
  String authPartialFail(String failed) {
    return 'Some data failed to load ($failed). Pull to retry.';
  }

  @override
  String get splashTagline => 'Travel journal';

  @override
  String get splashGetStarted => 'Get Started';

  @override
  String get authGenderMale => 'Male';

  @override
  String get authGenderFemale => 'Female';

  @override
  String get authGenderNonBinary => 'Non-binary';

  @override
  String get authGenderPrefer => 'Prefer not to say';
}
