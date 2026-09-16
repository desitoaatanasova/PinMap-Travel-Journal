import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bg.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bg'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('zh'),
  ];

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navTrips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get navTrips;

  /// No description provided for @navJournal.
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get navJournal;

  /// No description provided for @navWishlist.
  ///
  /// In en, this message translates to:
  /// **'Wish List'**
  String get navWishlist;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsAccount;

  /// No description provided for @settingsMyTrips.
  ///
  /// In en, this message translates to:
  /// **'My Trips'**
  String get settingsMyTrips;

  /// No description provided for @settingsMyTripsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View and manage your trips'**
  String get settingsMyTripsSubtitle;

  /// No description provided for @settingsMyWishlist.
  ///
  /// In en, this message translates to:
  /// **'My Wish List'**
  String get settingsMyWishlist;

  /// No description provided for @settingsMyWishlistSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Places you want to visit'**
  String get settingsMyWishlistSubtitle;

  /// No description provided for @settingsPreferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get settingsPreferences;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Receive travel reminders and updates'**
  String get settingsNotificationsSubtitle;

  /// No description provided for @settingsOffline.
  ///
  /// In en, this message translates to:
  /// **'Available Offline'**
  String get settingsOffline;

  /// No description provided for @settingsOfflineEnabled.
  ///
  /// In en, this message translates to:
  /// **'Offline access enabled'**
  String get settingsOfflineEnabled;

  /// No description provided for @settingsOfflineDisabled.
  ///
  /// In en, this message translates to:
  /// **'Offline access disabled'**
  String get settingsOfflineDisabled;

  /// No description provided for @settingsProfileStatus.
  ///
  /// In en, this message translates to:
  /// **'Profile Status'**
  String get settingsProfileStatus;

  /// No description provided for @settingsProfilePrivate.
  ///
  /// In en, this message translates to:
  /// **'Private - Only followers can see your activity'**
  String get settingsProfilePrivate;

  /// No description provided for @settingsProfilePublic.
  ///
  /// In en, this message translates to:
  /// **'Public - Anyone can see your activity'**
  String get settingsProfilePublic;

  /// No description provided for @settingsGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get settingsGeneral;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsSelectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get settingsSelectLanguage;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsSelectTheme.
  ///
  /// In en, this message translates to:
  /// **'Select Theme'**
  String get settingsSelectTheme;

  /// No description provided for @settingsServerAddress.
  ///
  /// In en, this message translates to:
  /// **'Server address'**
  String get settingsServerAddress;

  /// No description provided for @settingsServerDefault.
  ///
  /// In en, this message translates to:
  /// **'Default ({url})'**
  String settingsServerDefault(String url);

  /// No description provided for @settingsServerDialogText.
  ///
  /// In en, this message translates to:
  /// **'Where the backend runs. Examples:\n• Home Wi-Fi:  http://192.168.1.50:3001\n• Anywhere:    https://your-tunnel-url\n\nLeave empty to use the default server.'**
  String get settingsServerDialogText;

  /// No description provided for @settingsServerUpdated.
  ///
  /// In en, this message translates to:
  /// **'Server address updated'**
  String get settingsServerUpdated;

  /// No description provided for @settingsStorage.
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get settingsStorage;

  /// No description provided for @settingsStorageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage downloaded content'**
  String get settingsStorageSubtitle;

  /// No description provided for @settingsDangerZone.
  ///
  /// In en, this message translates to:
  /// **'Danger Zone'**
  String get settingsDangerZone;

  /// No description provided for @settingsDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get settingsDeleteAccount;

  /// No description provided for @settingsDeleteAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Permanently delete your account and all data'**
  String get settingsDeleteAccountSubtitle;

  /// No description provided for @settingsDeleteAccountConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account?'**
  String get settingsDeleteAccountConfirmTitle;

  /// No description provided for @settingsDeleteAccountConfirmText.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone. All your data will be permanently deleted.'**
  String get settingsDeleteAccountConfirmText;

  /// No description provided for @settingsDeleteAccountSoon.
  ///
  /// In en, this message translates to:
  /// **'Delete account coming soon!'**
  String get settingsDeleteAccountSoon;

  /// No description provided for @settingsDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get settingsDelete;

  /// No description provided for @settingsLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get settingsLogout;

  /// No description provided for @settingsLogoutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout?'**
  String get settingsLogoutConfirmTitle;

  /// No description provided for @settingsLogoutConfirmText.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get settingsLogoutConfirmText;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// No description provided for @commonLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get commonLoading;

  /// No description provided for @commonError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get commonError;

  /// No description provided for @commonOffline.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get commonOffline;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get commonYes;

  /// No description provided for @commonNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get commonNo;

  /// No description provided for @commonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commonEdit;

  /// No description provided for @authWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get authWelcomeBack;

  /// No description provided for @authSignInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue your journey'**
  String get authSignInSubtitle;

  /// No description provided for @authEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmail;

  /// No description provided for @authPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPassword;

  /// No description provided for @authForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get authForgotPassword;

  /// No description provided for @authLogin.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get authLogin;

  /// No description provided for @authNoAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get authNoAccount;

  /// No description provided for @authSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get authSignUp;

  /// No description provided for @authCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get authCreateAccount;

  /// No description provided for @authCreateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start your travel journal'**
  String get authCreateSubtitle;

  /// No description provided for @authFullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get authFullName;

  /// No description provided for @authHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get authHaveAccount;

  /// No description provided for @authEnterValid.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid credentials'**
  String get authEnterValid;

  /// No description provided for @authFillRequired.
  ///
  /// In en, this message translates to:
  /// **'Please fill all required fields'**
  String get authFillRequired;

  /// No description provided for @authInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials'**
  String get authInvalid;

  /// No description provided for @authRegisterFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed'**
  String get authRegisterFailed;

  /// No description provided for @authSessionFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not start session. Try again.'**
  String get authSessionFailed;

  /// No description provided for @authPartialFail.
  ///
  /// In en, this message translates to:
  /// **'Some data failed to load ({failed}). Pull to retry.'**
  String authPartialFail(String failed);

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'Travel journal'**
  String get splashTagline;

  /// No description provided for @splashGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get splashGetStarted;

  /// No description provided for @authGenderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get authGenderMale;

  /// No description provided for @authGenderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get authGenderFemale;

  /// No description provided for @authGenderNonBinary.
  ///
  /// In en, this message translates to:
  /// **'Non-binary'**
  String get authGenderNonBinary;

  /// No description provided for @authGenderPrefer.
  ///
  /// In en, this message translates to:
  /// **'Prefer not to say'**
  String get authGenderPrefer;

  /// No description provided for @homeSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search country or city...'**
  String get homeSearchHint;

  /// No description provided for @homeCountriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Countries'**
  String get homeCountriesTitle;

  /// No description provided for @homeCountriesCount.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 country} other{{n} countries}}'**
  String homeCountriesCount(int n);

  /// No description provided for @homeLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load countries'**
  String get homeLoadError;

  /// No description provided for @homeTapRetry.
  ///
  /// In en, this message translates to:
  /// **'Tap to retry'**
  String get homeTapRetry;

  /// No description provided for @progressTitle.
  ///
  /// In en, this message translates to:
  /// **'Travel Progress'**
  String get progressTitle;

  /// No description provided for @progressCount.
  ///
  /// In en, this message translates to:
  /// **'{v} / {t} countries'**
  String progressCount(int v, int t);

  /// No description provided for @countryRate.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get countryRate;

  /// No description provided for @countryVisitedPrompt.
  ///
  /// In en, this message translates to:
  /// **'Visited?'**
  String get countryVisitedPrompt;

  /// No description provided for @countryWishlist.
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get countryWishlist;

  /// No description provided for @countryWishlisted.
  ///
  /// In en, this message translates to:
  /// **'Wishlisted'**
  String get countryWishlisted;

  /// No description provided for @countryMarkedVisited.
  ///
  /// In en, this message translates to:
  /// **'{name} marked as visited'**
  String countryMarkedVisited(String name);

  /// No description provided for @countryUnmarkedVisited.
  ///
  /// In en, this message translates to:
  /// **'{name} no longer marked as visited'**
  String countryUnmarkedVisited(String name);

  /// No description provided for @countryAbout.
  ///
  /// In en, this message translates to:
  /// **'About {name}'**
  String countryAbout(String name);

  /// No description provided for @countryMajorCities.
  ///
  /// In en, this message translates to:
  /// **'Major Cities'**
  String get countryMajorCities;

  /// No description provided for @countryMapPreview.
  ///
  /// In en, this message translates to:
  /// **'Map Preview'**
  String get countryMapPreview;

  /// No description provided for @rateDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Rate {name}'**
  String rateDialogTitle(String name);

  /// No description provided for @cityDiscover.
  ///
  /// In en, this message translates to:
  /// **'What to discover'**
  String get cityDiscover;

  /// No description provided for @catHistorical.
  ///
  /// In en, this message translates to:
  /// **'Historical Sights'**
  String get catHistorical;

  /// No description provided for @catArtLovers.
  ///
  /// In en, this message translates to:
  /// **'For the Art Lovers'**
  String get catArtLovers;

  /// No description provided for @catAtmosphere.
  ///
  /// In en, this message translates to:
  /// **'Atmosphere & experience'**
  String get catAtmosphere;

  /// No description provided for @catHiddenGems.
  ///
  /// In en, this message translates to:
  /// **'Hidden Gems'**
  String get catHiddenGems;

  /// No description provided for @catCloseBy.
  ///
  /// In en, this message translates to:
  /// **'Close by'**
  String get catCloseBy;

  /// No description provided for @catMyPlaces.
  ///
  /// In en, this message translates to:
  /// **'My places'**
  String get catMyPlaces;

  /// No description provided for @categoryPlaces.
  ///
  /// In en, this message translates to:
  /// **'Places'**
  String get categoryPlaces;

  /// No description provided for @placeMarkVisited.
  ///
  /// In en, this message translates to:
  /// **'Mark visited'**
  String get placeMarkVisited;

  /// No description provided for @markShort.
  ///
  /// In en, this message translates to:
  /// **'Mark'**
  String get markShort;

  /// No description provided for @detailsAbout.
  ///
  /// In en, this message translates to:
  /// **'About this place'**
  String get detailsAbout;

  /// No description provided for @detailsLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get detailsLocation;

  /// No description provided for @detailsWebsiteError.
  ///
  /// In en, this message translates to:
  /// **'Could not open website'**
  String get detailsWebsiteError;

  /// No description provided for @detailsVisitedAdded.
  ///
  /// In en, this message translates to:
  /// **'Marked as visited!'**
  String get detailsVisitedAdded;

  /// No description provided for @detailsVisitedRemoved.
  ///
  /// In en, this message translates to:
  /// **'Removed visited status'**
  String get detailsVisitedRemoved;

  /// No description provided for @detailsMarkAsVisited.
  ///
  /// In en, this message translates to:
  /// **'Mark as Visited'**
  String get detailsMarkAsVisited;

  /// No description provided for @visitedLabel.
  ///
  /// In en, this message translates to:
  /// **'Visited'**
  String get visitedLabel;

  /// No description provided for @wishlistAdded.
  ///
  /// In en, this message translates to:
  /// **'{name} added to wishlist'**
  String wishlistAdded(String name);

  /// No description provided for @wishlistRemoved.
  ///
  /// In en, this message translates to:
  /// **'{name} removed from wishlist'**
  String wishlistRemoved(String name);

  /// No description provided for @tripsNewTrip.
  ///
  /// In en, this message translates to:
  /// **'New Trip'**
  String get tripsNewTrip;

  /// No description provided for @tripsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No trips yet'**
  String get tripsEmptyTitle;

  /// No description provided for @tripsEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Tap \"New Trip\" to start planning'**
  String get tripsEmptyHint;

  /// No description provided for @tripsDraftHint.
  ///
  /// In en, this message translates to:
  /// **'AI draft ready — tap to review & save'**
  String get tripsDraftHint;

  /// No description provided for @tripDurationDays.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 day} other{{n} days}}'**
  String tripDurationDays(int n);

  /// No description provided for @tripStyleSolo.
  ///
  /// In en, this message translates to:
  /// **'Solo'**
  String get tripStyleSolo;

  /// No description provided for @tripStyleGroup.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get tripStyleGroup;

  /// No description provided for @tripTypeHistorical.
  ///
  /// In en, this message translates to:
  /// **'Historical'**
  String get tripTypeHistorical;

  /// No description provided for @tripTypeArt.
  ///
  /// In en, this message translates to:
  /// **'Art'**
  String get tripTypeArt;

  /// No description provided for @tripTypeMixed.
  ///
  /// In en, this message translates to:
  /// **'Mixed'**
  String get tripTypeMixed;

  /// No description provided for @tripFormTitleNew.
  ///
  /// In en, this message translates to:
  /// **'New Trip'**
  String get tripFormTitleNew;

  /// No description provided for @tripFormTitleEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit Trip'**
  String get tripFormTitleEdit;

  /// No description provided for @tripSectionDestination.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get tripSectionDestination;

  /// No description provided for @tripSectionDates.
  ///
  /// In en, this message translates to:
  /// **'Dates'**
  String get tripSectionDates;

  /// No description provided for @tripSectionVacationType.
  ///
  /// In en, this message translates to:
  /// **'Type of Vacation'**
  String get tripSectionVacationType;

  /// No description provided for @tripSectionTravelStyle.
  ///
  /// In en, this message translates to:
  /// **'Travel Style'**
  String get tripSectionTravelStyle;

  /// No description provided for @tripSectionCompanions.
  ///
  /// In en, this message translates to:
  /// **'Travel Companions'**
  String get tripSectionCompanions;

  /// No description provided for @tripChooseCountry.
  ///
  /// In en, this message translates to:
  /// **'Choose a country'**
  String get tripChooseCountry;

  /// No description provided for @tripChooseCities.
  ///
  /// In en, this message translates to:
  /// **'Choose cities to visit (optional)'**
  String get tripChooseCities;

  /// No description provided for @tripArrivalCity.
  ///
  /// In en, this message translates to:
  /// **'Arrival city'**
  String get tripArrivalCity;

  /// No description provided for @tripDepartureCity.
  ///
  /// In en, this message translates to:
  /// **'Departure city'**
  String get tripDepartureCity;

  /// No description provided for @tripStartDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get tripStartDate;

  /// No description provided for @tripEndDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get tripEndDate;

  /// No description provided for @tripSelect.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get tripSelect;

  /// No description provided for @tripDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{Duration: 1 day} other{Duration: {n} days}}'**
  String tripDurationLabel(int n);

  /// No description provided for @tripNoFriendsHint.
  ///
  /// In en, this message translates to:
  /// **'No friends found yet. Follow other travellers (and let them follow you back) and they will appear here to add as trip companions.'**
  String get tripNoFriendsHint;

  /// No description provided for @tripCountryFirst.
  ///
  /// In en, this message translates to:
  /// **'Choose a country first'**
  String get tripCountryFirst;

  /// No description provided for @tripSheetCities.
  ///
  /// In en, this message translates to:
  /// **'Choose cities to visit'**
  String get tripSheetCities;

  /// No description provided for @tripSelectedCount.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 selected} other{{n} selected}}'**
  String tripSelectedCount(int n);

  /// No description provided for @tripCitiesIn.
  ///
  /// In en, this message translates to:
  /// **'Cities in {name}'**
  String tripCitiesIn(String name);

  /// No description provided for @tripNearbyCities.
  ///
  /// In en, this message translates to:
  /// **'Nearby in neighbouring countries'**
  String get tripNearbyCities;

  /// No description provided for @tripSearchCities.
  ///
  /// In en, this message translates to:
  /// **'Search cities'**
  String get tripSearchCities;

  /// No description provided for @tripSheetDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get tripSheetDone;

  /// No description provided for @tripAddCities.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{Add 1 city} other{Add {n} cities}}'**
  String tripAddCities(int n);

  /// No description provided for @tripGenerating.
  ///
  /// In en, this message translates to:
  /// **'Generating...'**
  String get tripGenerating;

  /// No description provided for @tripSave.
  ///
  /// In en, this message translates to:
  /// **'Save Trip'**
  String get tripSave;

  /// No description provided for @tripGenerate.
  ///
  /// In en, this message translates to:
  /// **'Generate Trip Plan'**
  String get tripGenerate;

  /// No description provided for @tripDurationLocked.
  ///
  /// In en, this message translates to:
  /// **'Cannot change trip duration here. Please create a new trip to change days.'**
  String get tripDurationLocked;

  /// No description provided for @tripGenFailTitle.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t Generate Trip'**
  String get tripGenFailTitle;

  /// No description provided for @tripGenFailFallback.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong generating your trip.'**
  String get tripGenFailFallback;

  /// No description provided for @tripGenBasic.
  ///
  /// In en, this message translates to:
  /// **'Create basic itinerary without AI'**
  String get tripGenBasic;

  /// No description provided for @planNotFound.
  ///
  /// In en, this message translates to:
  /// **'Trip not found'**
  String get planNotFound;

  /// No description provided for @planItineraryTitle.
  ///
  /// In en, this message translates to:
  /// **'Day-by-Day Itinerary'**
  String get planItineraryTitle;

  /// No description provided for @planMapView.
  ///
  /// In en, this message translates to:
  /// **'Map View'**
  String get planMapView;

  /// No description provided for @planExporting.
  ///
  /// In en, this message translates to:
  /// **'Exporting...'**
  String get planExporting;

  /// No description provided for @planExportPdf.
  ///
  /// In en, this message translates to:
  /// **'Export PDF'**
  String get planExportPdf;

  /// No description provided for @planRegenerate.
  ///
  /// In en, this message translates to:
  /// **'Regenerate'**
  String get planRegenerate;

  /// No description provided for @planDiscard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get planDiscard;

  /// No description provided for @planSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get planSaving;

  /// No description provided for @planDraftNote.
  ///
  /// In en, this message translates to:
  /// **'AI draft — not saved to your trips yet'**
  String get planDraftNote;

  /// No description provided for @planSaved.
  ///
  /// In en, this message translates to:
  /// **'Trip saved to your trips!'**
  String get planSaved;

  /// No description provided for @planSaveError.
  ///
  /// In en, this message translates to:
  /// **'Could not save the trip'**
  String get planSaveError;

  /// No description provided for @planRegenerated.
  ///
  /// In en, this message translates to:
  /// **'New itinerary generated'**
  String get planRegenerated;

  /// No description provided for @planRegenError.
  ///
  /// In en, this message translates to:
  /// **'Could not regenerate the trip'**
  String get planRegenError;

  /// No description provided for @planLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load trip details'**
  String get planLoadError;

  /// No description provided for @planPdfDone.
  ///
  /// In en, this message translates to:
  /// **'PDF downloaded'**
  String get planPdfDone;

  /// No description provided for @planPdfError.
  ///
  /// In en, this message translates to:
  /// **'Could not export PDF'**
  String get planPdfError;

  /// No description provided for @planDiscardTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard Draft?'**
  String get planDiscardTitle;

  /// No description provided for @planDiscardText.
  ///
  /// In en, this message translates to:
  /// **'This AI-generated draft will be removed.'**
  String get planDiscardText;

  /// No description provided for @planDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Trip'**
  String get planDeleteTitle;

  /// No description provided for @planDeleteText.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this trip?'**
  String get planDeleteText;

  /// No description provided for @planDayNumber.
  ///
  /// In en, this message translates to:
  /// **'DAY {n}'**
  String planDayNumber(int n);

  /// No description provided for @planMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get planMorning;

  /// No description provided for @planAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Afternoon'**
  String get planAfternoon;

  /// No description provided for @planEvening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get planEvening;

  /// No description provided for @planActivityFallback.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get planActivityFallback;

  /// No description provided for @mapTitle.
  ///
  /// In en, this message translates to:
  /// **'Trip Map'**
  String get mapTitle;

  /// No description provided for @mapDay.
  ///
  /// In en, this message translates to:
  /// **'Day {n}'**
  String mapDay(int n);

  /// No description provided for @mapAllDays.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get mapAllDays;

  /// No description provided for @mapViewDetails.
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get mapViewDetails;

  /// No description provided for @mapCategory.
  ///
  /// In en, this message translates to:
  /// **'Category {id}'**
  String mapCategory(int id);

  /// No description provided for @mapPlaceError.
  ///
  /// In en, this message translates to:
  /// **'Could not load place details'**
  String get mapPlaceError;

  /// No description provided for @mapEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No mapped locations'**
  String get mapEmptyTitle;

  /// No description provided for @mapEmptyText.
  ///
  /// In en, this message translates to:
  /// **'This itinerary does not contain places with coordinates. Basic itineraries and empty days are not shown on the map.'**
  String get mapEmptyText;

  /// No description provided for @mapPlacesShown.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 place shown} other{{n} places shown}}'**
  String mapPlacesShown(int n);

  /// No description provided for @mapNoCoordsSuffix.
  ///
  /// In en, this message translates to:
  /// **'— no coordinates'**
  String get mapNoCoordsSuffix;

  /// No description provided for @journalOverviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Journal Overview'**
  String get journalOverviewTitle;

  /// No description provided for @journalDownload.
  ///
  /// In en, this message translates to:
  /// **'Download Journal'**
  String get journalDownload;

  /// No description provided for @journalPost.
  ///
  /// In en, this message translates to:
  /// **'Post to Profile'**
  String get journalPost;

  /// No description provided for @journalNoCountries.
  ///
  /// In en, this message translates to:
  /// **'No countries loaded yet'**
  String get journalNoCountries;

  /// No description provided for @journalExploreMap.
  ///
  /// In en, this message translates to:
  /// **'Explore Map'**
  String get journalExploreMap;

  /// No description provided for @journalCityCount.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 city} other{{n} cities}}'**
  String journalCityCount(int n);

  /// No description provided for @journalNoneForCountry.
  ///
  /// In en, this message translates to:
  /// **'No journal yet for this country.'**
  String get journalNoneForCountry;

  /// No description provided for @journalChooseCountry.
  ///
  /// In en, this message translates to:
  /// **'Choose country'**
  String get journalChooseCountry;

  /// No description provided for @journalCount.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 journal} other{{n} journals}}'**
  String journalCount(int n);

  /// No description provided for @journalPageCount.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 page} other{{n} pages}}'**
  String journalPageCount(int n);

  /// No description provided for @journalUntitled.
  ///
  /// In en, this message translates to:
  /// **'Untitled journal'**
  String get journalUntitled;

  /// No description provided for @journalNoneToPost.
  ///
  /// In en, this message translates to:
  /// **'No journals yet to post.'**
  String get journalNoneToPost;

  /// No description provided for @journalPublic.
  ///
  /// In en, this message translates to:
  /// **'Public'**
  String get journalPublic;

  /// No description provided for @journalPrivate.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get journalPrivate;

  /// No description provided for @journalRemoveShort.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get journalRemoveShort;

  /// No description provided for @journalRemoveTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove from Profile?'**
  String get journalRemoveTitle;

  /// No description provided for @journalPostTitle.
  ///
  /// In en, this message translates to:
  /// **'Post to Profile?'**
  String get journalPostTitle;

  /// No description provided for @journalRemoveText.
  ///
  /// In en, this message translates to:
  /// **'This will make your journal private and hide it from your profile.'**
  String get journalRemoveText;

  /// No description provided for @journalPostText.
  ///
  /// In en, this message translates to:
  /// **'This will make your journal visible on your profile. Public journals are visible to anyone who can view your profile.'**
  String get journalPostText;

  /// No description provided for @journalRemoved.
  ///
  /// In en, this message translates to:
  /// **'Removed from profile'**
  String get journalRemoved;

  /// No description provided for @journalPosted.
  ///
  /// In en, this message translates to:
  /// **'Posted to profile'**
  String get journalPosted;

  /// No description provided for @journalVisibilityError.
  ///
  /// In en, this message translates to:
  /// **'Could not update visibility: {error}'**
  String journalVisibilityError(String error);

  /// No description provided for @journalUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get journalUnknown;

  /// No description provided for @journalNew.
  ///
  /// In en, this message translates to:
  /// **'New Journal'**
  String get journalNew;

  /// No description provided for @journalNewHint.
  ///
  /// In en, this message translates to:
  /// **'Start documenting your journey'**
  String get journalNewHint;

  /// No description provided for @journalEmpty.
  ///
  /// In en, this message translates to:
  /// **'No journal entries yet'**
  String get journalEmpty;

  /// No description provided for @journalStartWriting.
  ///
  /// In en, this message translates to:
  /// **'Start Writing'**
  String get journalStartWriting;

  /// No description provided for @journalRemoveProfile.
  ///
  /// In en, this message translates to:
  /// **'Remove from Profile'**
  String get journalRemoveProfile;

  /// No description provided for @journalView.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get journalView;

  /// No description provided for @editorSaveError.
  ///
  /// In en, this message translates to:
  /// **'Could not save: {error}'**
  String editorSaveError(String error);

  /// No description provided for @editorSavedOffline.
  ///
  /// In en, this message translates to:
  /// **'Saved on this device — will sync when online.'**
  String get editorSavedOffline;

  /// No description provided for @editorDraftSaved.
  ///
  /// In en, this message translates to:
  /// **'Draft saved!'**
  String get editorDraftSaved;

  /// No description provided for @editorAddPicture.
  ///
  /// In en, this message translates to:
  /// **'Add a picture'**
  String get editorAddPicture;

  /// No description provided for @editorFromGallery.
  ///
  /// In en, this message translates to:
  /// **'From gallery'**
  String get editorFromGallery;

  /// No description provided for @editorTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get editorTakePhoto;

  /// No description provided for @editorPicOffline.
  ///
  /// In en, this message translates to:
  /// **'Picture saved on this device — will sync when online.'**
  String get editorPicOffline;

  /// No description provided for @editorPicAdded.
  ///
  /// In en, this message translates to:
  /// **'Picture added!'**
  String get editorPicAdded;

  /// No description provided for @editorPicError.
  ///
  /// In en, this message translates to:
  /// **'Could not add picture: {error}'**
  String editorPicError(String error);

  /// No description provided for @editorTicketOffline.
  ///
  /// In en, this message translates to:
  /// **'Ticket saved on this device. Will sync when online.'**
  String get editorTicketOffline;

  /// No description provided for @editorTicketAdded.
  ///
  /// In en, this message translates to:
  /// **'Ticket added to your journal!'**
  String get editorTicketAdded;

  /// No description provided for @editorClosedError.
  ///
  /// In en, this message translates to:
  /// **'Journal editor was closed.'**
  String get editorClosedError;

  /// No description provided for @editorPageGoneError.
  ///
  /// In en, this message translates to:
  /// **'Journal page is no longer available.'**
  String get editorPageGoneError;

  /// No description provided for @editorTicketError.
  ///
  /// In en, this message translates to:
  /// **'Ticket scan failed: {error}'**
  String editorTicketError(String error);

  /// No description provided for @editorAddSticker.
  ///
  /// In en, this message translates to:
  /// **'Add Sticker'**
  String get editorAddSticker;

  /// No description provided for @editorStickerAirplane.
  ///
  /// In en, this message translates to:
  /// **'Airplane'**
  String get editorStickerAirplane;

  /// No description provided for @editorStickerTicket.
  ///
  /// In en, this message translates to:
  /// **'Ticket'**
  String get editorStickerTicket;

  /// No description provided for @editorStickerCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get editorStickerCamera;

  /// No description provided for @editorStickerArt.
  ///
  /// In en, this message translates to:
  /// **'Art'**
  String get editorStickerArt;

  /// No description provided for @editorStickerCoffee.
  ///
  /// In en, this message translates to:
  /// **'Coffee'**
  String get editorStickerCoffee;

  /// No description provided for @editorStickerBuilding.
  ///
  /// In en, this message translates to:
  /// **'Building'**
  String get editorStickerBuilding;

  /// No description provided for @editorStickerTheater.
  ///
  /// In en, this message translates to:
  /// **'Theater'**
  String get editorStickerTheater;

  /// No description provided for @editorStickerWine.
  ///
  /// In en, this message translates to:
  /// **'Wine'**
  String get editorStickerWine;

  /// No description provided for @editorEditText.
  ///
  /// In en, this message translates to:
  /// **'Edit text'**
  String get editorEditText;

  /// No description provided for @editorDuplicate.
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get editorDuplicate;

  /// No description provided for @editorBringForward.
  ///
  /// In en, this message translates to:
  /// **'Bring forward'**
  String get editorBringForward;

  /// No description provided for @editorSendBackward.
  ///
  /// In en, this message translates to:
  /// **'Send backward'**
  String get editorSendBackward;

  /// No description provided for @editorTextColor.
  ///
  /// In en, this message translates to:
  /// **'Text Color'**
  String get editorTextColor;

  /// No description provided for @editorFontFamily.
  ///
  /// In en, this message translates to:
  /// **'Font Family'**
  String get editorFontFamily;

  /// No description provided for @editorDupPage.
  ///
  /// In en, this message translates to:
  /// **'Duplicate page'**
  String get editorDupPage;

  /// No description provided for @editorMoveLeft.
  ///
  /// In en, this message translates to:
  /// **'Move left'**
  String get editorMoveLeft;

  /// No description provided for @editorMoveRight.
  ///
  /// In en, this message translates to:
  /// **'Move right'**
  String get editorMoveRight;

  /// No description provided for @editorDeletePage.
  ///
  /// In en, this message translates to:
  /// **'Delete page'**
  String get editorDeletePage;

  /// No description provided for @editorPageBg.
  ///
  /// In en, this message translates to:
  /// **'Page background'**
  String get editorPageBg;

  /// No description provided for @editorBgCream.
  ///
  /// In en, this message translates to:
  /// **'Cream'**
  String get editorBgCream;

  /// No description provided for @editorBgPeach.
  ///
  /// In en, this message translates to:
  /// **'Peach'**
  String get editorBgPeach;

  /// No description provided for @editorBgMint.
  ///
  /// In en, this message translates to:
  /// **'Mint'**
  String get editorBgMint;

  /// No description provided for @editorBgSky.
  ///
  /// In en, this message translates to:
  /// **'Sky'**
  String get editorBgSky;

  /// No description provided for @editorBgLavender.
  ///
  /// In en, this message translates to:
  /// **'Lavender'**
  String get editorBgLavender;

  /// No description provided for @editorBgLemon.
  ///
  /// In en, this message translates to:
  /// **'Lemon'**
  String get editorBgLemon;

  /// No description provided for @editorMinPage.
  ///
  /// In en, this message translates to:
  /// **'A journal needs at least one page.'**
  String get editorMinPage;

  /// No description provided for @editorToolText.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get editorToolText;

  /// No description provided for @editorToolPicture.
  ///
  /// In en, this message translates to:
  /// **'Picture'**
  String get editorToolPicture;

  /// No description provided for @editorToolTicket.
  ///
  /// In en, this message translates to:
  /// **'Ticket'**
  String get editorToolTicket;

  /// No description provided for @editorToolSticker.
  ///
  /// In en, this message translates to:
  /// **'Sticker'**
  String get editorToolSticker;

  /// No description provided for @editorAddPage.
  ///
  /// In en, this message translates to:
  /// **'Add page'**
  String get editorAddPage;

  /// No description provided for @editorFormatTooltip.
  ///
  /// In en, this message translates to:
  /// **'Format'**
  String get editorFormatTooltip;

  /// No description provided for @editorRotateLeft.
  ///
  /// In en, this message translates to:
  /// **'Rotate left'**
  String get editorRotateLeft;

  /// No description provided for @editorRotateRight.
  ///
  /// In en, this message translates to:
  /// **'Rotate right'**
  String get editorRotateRight;

  /// No description provided for @editorSmaller.
  ///
  /// In en, this message translates to:
  /// **'Smaller'**
  String get editorSmaller;

  /// No description provided for @editorBigger.
  ///
  /// In en, this message translates to:
  /// **'Bigger'**
  String get editorBigger;

  /// No description provided for @editorRetakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Retake photo'**
  String get editorRetakePhoto;

  /// No description provided for @editorCropTicket.
  ///
  /// In en, this message translates to:
  /// **'Crop ticket'**
  String get editorCropTicket;

  /// No description provided for @journalNotFound.
  ///
  /// In en, this message translates to:
  /// **'Not found'**
  String get journalNotFound;

  /// No description provided for @journalNoPages.
  ///
  /// In en, this message translates to:
  /// **'No pages'**
  String get journalNoPages;

  /// No description provided for @journalPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Page {n}'**
  String journalPageTitle(int n);

  /// No description provided for @journalPdfError.
  ///
  /// In en, this message translates to:
  /// **'Could not download PDF'**
  String get journalPdfError;

  /// No description provided for @wishEmpty.
  ///
  /// In en, this message translates to:
  /// **'No saved destinations'**
  String get wishEmpty;

  /// No description provided for @wishEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Tap the heart icon on places or countries to save them'**
  String get wishEmptyHint;

  /// No description provided for @wishCountryBadge.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get wishCountryBadge;

  /// No description provided for @wishRemoveTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove from Wishlist'**
  String get wishRemoveTitle;

  /// No description provided for @wishRemoveText.
  ///
  /// In en, this message translates to:
  /// **'Remove {name} from your wishlist?'**
  String wishRemoveText(String name);

  /// No description provided for @profileTagline.
  ///
  /// In en, this message translates to:
  /// **'Travel enthusiast'**
  String get profileTagline;

  /// No description provided for @profileStatPlaces.
  ///
  /// In en, this message translates to:
  /// **'Places'**
  String get profileStatPlaces;

  /// No description provided for @profileStatTrips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get profileStatTrips;

  /// No description provided for @profileStatFollowers.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get profileStatFollowers;

  /// No description provided for @profileStatFollowing.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get profileStatFollowing;

  /// No description provided for @profileFindTravellers.
  ///
  /// In en, this message translates to:
  /// **'Find travellers to follow'**
  String get profileFindTravellers;

  /// No description provided for @profilePhotos.
  ///
  /// In en, this message translates to:
  /// **'Travel Photos'**
  String get profilePhotos;

  /// No description provided for @profileJournals.
  ///
  /// In en, this message translates to:
  /// **'Journals'**
  String get profileJournals;

  /// No description provided for @profileAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get profileAdd;

  /// No description provided for @profileEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profileEdit;

  /// No description provided for @profileFirstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get profileFirstName;

  /// No description provided for @profileLastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get profileLastName;

  /// No description provided for @profileBio.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get profileBio;

  /// No description provided for @profilePhotoDone.
  ///
  /// In en, this message translates to:
  /// **'Photo uploaded'**
  String get profilePhotoDone;

  /// No description provided for @profilePhotoError.
  ///
  /// In en, this message translates to:
  /// **'Could not upload photo'**
  String get profilePhotoError;

  /// No description provided for @profilePhotoDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Could not delete photo'**
  String get profilePhotoDeleteError;

  /// No description provided for @profileSaved.
  ///
  /// In en, this message translates to:
  /// **'Profile updated'**
  String get profileSaved;

  /// No description provided for @profileDeletePhotoTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Photo'**
  String get profileDeletePhotoTitle;

  /// No description provided for @profileDeletePhotoText.
  ///
  /// In en, this message translates to:
  /// **'Remove this photo from your profile?'**
  String get profileDeletePhotoText;

  /// No description provided for @searchTitle.
  ///
  /// In en, this message translates to:
  /// **'Find Travellers'**
  String get searchTitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by username or name'**
  String get searchHint;

  /// No description provided for @searchError.
  ///
  /// In en, this message translates to:
  /// **'Search failed'**
  String get searchError;

  /// No description provided for @searchPrompt.
  ///
  /// In en, this message translates to:
  /// **'Start typing to find other travellers'**
  String get searchPrompt;

  /// No description provided for @searchEmpty.
  ///
  /// In en, this message translates to:
  /// **'No travellers found'**
  String get searchEmpty;

  /// No description provided for @userFollow.
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get userFollow;

  /// No description provided for @userUnfollow.
  ///
  /// In en, this message translates to:
  /// **'Unfollow'**
  String get userUnfollow;

  /// No description provided for @userPrivateText.
  ///
  /// In en, this message translates to:
  /// **'This profile is private. Follow {username} to see their travel photos.'**
  String userPrivateText(String username);

  /// No description provided for @userFollowError.
  ///
  /// In en, this message translates to:
  /// **'Could not update follow status'**
  String get userFollowError;

  /// No description provided for @journalDeleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete Journal'**
  String get journalDeleteAction;

  /// No description provided for @journalDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Journal?'**
  String get journalDeleteTitle;

  /// No description provided for @journalDeleteText.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete \"{name}\". This cannot be undone.'**
  String journalDeleteText(String name);

  /// No description provided for @journalDeleted.
  ///
  /// In en, this message translates to:
  /// **'Journal deleted'**
  String get journalDeleted;

  /// No description provided for @journalDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Could not delete journal'**
  String get journalDeleteError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'bg',
    'de',
    'en',
    'es',
    'fr',
    'it',
    'ja',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bg':
      return AppLocalizationsBg();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
