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

  @override
  String get homeSearchHint => 'Search country or city...';

  @override
  String get homeCountriesTitle => 'Countries';

  @override
  String homeCountriesCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n countries',
      one: '1 country',
    );
    return '$_temp0';
  }

  @override
  String get homeLoadError => 'Could not load countries';

  @override
  String get homeTapRetry => 'Tap to retry';

  @override
  String get progressTitle => 'Travel Progress';

  @override
  String progressCount(int v, int t) {
    return '$v / $t countries';
  }

  @override
  String get countryRate => 'Rate';

  @override
  String get countryVisitedPrompt => 'Visited?';

  @override
  String get countryWishlist => 'Wishlist';

  @override
  String get countryWishlisted => 'Wishlisted';

  @override
  String countryMarkedVisited(String name) {
    return '$name marked as visited';
  }

  @override
  String countryUnmarkedVisited(String name) {
    return '$name no longer marked as visited';
  }

  @override
  String countryAbout(String name) {
    return 'About $name';
  }

  @override
  String get countryMajorCities => 'Major Cities';

  @override
  String get countryMapPreview => 'Map Preview';

  @override
  String rateDialogTitle(String name) {
    return 'Rate $name';
  }

  @override
  String get cityDiscover => 'What to discover';

  @override
  String get catHistorical => 'Historical Sights';

  @override
  String get catArtLovers => 'For the Art Lovers';

  @override
  String get catAtmosphere => 'Atmosphere & experience';

  @override
  String get catHiddenGems => 'Hidden Gems';

  @override
  String get catCloseBy => 'Close by';

  @override
  String get catMyPlaces => 'My places';

  @override
  String get categoryPlaces => 'Places';

  @override
  String get placeMarkVisited => 'Mark visited';

  @override
  String get markShort => 'Mark';

  @override
  String get detailsAbout => 'About this place';

  @override
  String get detailsLocation => 'Location';

  @override
  String get detailsWebsiteError => 'Could not open website';

  @override
  String get detailsVisitedAdded => 'Marked as visited!';

  @override
  String get detailsVisitedRemoved => 'Removed visited status';

  @override
  String get detailsMarkAsVisited => 'Mark as Visited';

  @override
  String get visitedLabel => 'Visited';

  @override
  String wishlistAdded(String name) {
    return '$name added to wishlist';
  }

  @override
  String wishlistRemoved(String name) {
    return '$name removed from wishlist';
  }
}
