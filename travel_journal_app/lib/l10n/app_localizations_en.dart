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

  @override
  String get tripsNewTrip => 'New Trip';

  @override
  String get tripsEmptyTitle => 'No trips yet';

  @override
  String get tripsEmptyHint => 'Tap \"New Trip\" to start planning';

  @override
  String get tripsDraftHint => 'AI draft ready — tap to review & save';

  @override
  String tripDurationDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n days',
      one: '1 day',
    );
    return '$_temp0';
  }

  @override
  String get tripStyleSolo => 'Solo';

  @override
  String get tripStyleGroup => 'Group';

  @override
  String get tripTypeHistorical => 'Historical';

  @override
  String get tripTypeArt => 'Art';

  @override
  String get tripTypeMixed => 'Mixed';

  @override
  String get tripFormTitleNew => 'New Trip';

  @override
  String get tripFormTitleEdit => 'Edit Trip';

  @override
  String get tripSectionDestination => 'Destination';

  @override
  String get tripSectionDates => 'Dates';

  @override
  String get tripSectionVacationType => 'Type of Vacation';

  @override
  String get tripSectionTravelStyle => 'Travel Style';

  @override
  String get tripSectionCompanions => 'Travel Companions';

  @override
  String get tripChooseCountry => 'Choose a country';

  @override
  String get tripChooseCities => 'Choose cities to visit (optional)';

  @override
  String get tripArrivalCity => 'Arrival city';

  @override
  String get tripDepartureCity => 'Departure city';

  @override
  String get tripStartDate => 'Start Date';

  @override
  String get tripEndDate => 'End Date';

  @override
  String get tripSelect => 'Select';

  @override
  String tripDurationLabel(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Duration: $n days',
      one: 'Duration: 1 day',
    );
    return '$_temp0';
  }

  @override
  String get tripNoFriendsHint =>
      'No friends found yet. Follow other travellers (and let them follow you back) and they will appear here to add as trip companions.';

  @override
  String get tripCountryFirst => 'Choose a country first';

  @override
  String get tripSheetCities => 'Choose cities to visit';

  @override
  String tripSelectedCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n selected',
      one: '1 selected',
    );
    return '$_temp0';
  }

  @override
  String tripCitiesIn(String name) {
    return 'Cities in $name';
  }

  @override
  String get tripNearbyCities => 'Nearby in neighbouring countries';

  @override
  String get tripSearchCities => 'Search cities';

  @override
  String get tripSheetDone => 'Done';

  @override
  String tripAddCities(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Add $n cities',
      one: 'Add 1 city',
    );
    return '$_temp0';
  }

  @override
  String get tripGenerating => 'Generating...';

  @override
  String get tripSave => 'Save Trip';

  @override
  String get tripGenerate => 'Generate Trip Plan';

  @override
  String get tripDurationLocked =>
      'Cannot change trip duration here. Please create a new trip to change days.';

  @override
  String get tripGenFailTitle => 'Couldn\'t Generate Trip';

  @override
  String get tripGenFailFallback =>
      'Something went wrong generating your trip.';

  @override
  String get tripGenBasic => 'Create basic itinerary without AI';

  @override
  String get planNotFound => 'Trip not found';

  @override
  String get planItineraryTitle => 'Day-by-Day Itinerary';

  @override
  String get planMapView => 'Map View';

  @override
  String get planExporting => 'Exporting...';

  @override
  String get planExportPdf => 'Export PDF';

  @override
  String get planRegenerate => 'Regenerate';

  @override
  String get planDiscard => 'Discard';

  @override
  String get planSaving => 'Saving...';

  @override
  String get planDraftNote => 'AI draft — not saved to your trips yet';

  @override
  String get planSaved => 'Trip saved to your trips!';

  @override
  String get planSaveError => 'Could not save the trip';

  @override
  String get planRegenerated => 'New itinerary generated';

  @override
  String get planRegenError => 'Could not regenerate the trip';

  @override
  String get planLoadError => 'Could not load trip details';

  @override
  String get planPdfDone => 'PDF downloaded';

  @override
  String get planPdfError => 'Could not export PDF';

  @override
  String get planDiscardTitle => 'Discard Draft?';

  @override
  String get planDiscardText => 'This AI-generated draft will be removed.';

  @override
  String get planDeleteTitle => 'Delete Trip';

  @override
  String get planDeleteText => 'Are you sure you want to delete this trip?';

  @override
  String planDayNumber(int n) {
    return 'DAY $n';
  }

  @override
  String get planMorning => 'Morning';

  @override
  String get planAfternoon => 'Afternoon';

  @override
  String get planEvening => 'Evening';

  @override
  String get planActivityFallback => 'Activity';

  @override
  String get mapTitle => 'Trip Map';

  @override
  String mapDay(int n) {
    return 'Day $n';
  }

  @override
  String get mapAllDays => 'All';

  @override
  String get mapViewDetails => 'View details';

  @override
  String mapCategory(int id) {
    return 'Category $id';
  }

  @override
  String get mapPlaceError => 'Could not load place details';

  @override
  String get mapEmptyTitle => 'No mapped locations';

  @override
  String get mapEmptyText =>
      'This itinerary does not contain places with coordinates. Basic itineraries and empty days are not shown on the map.';

  @override
  String mapPlacesShown(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n places shown',
      one: '1 place shown',
    );
    return '$_temp0';
  }

  @override
  String get mapNoCoordsSuffix => '— no coordinates';

  @override
  String get journalOverviewTitle => 'Journal Overview';

  @override
  String get journalDownload => 'Download Journal';

  @override
  String get journalPost => 'Post to Profile';

  @override
  String get journalNoCountries => 'No countries loaded yet';

  @override
  String get journalExploreMap => 'Explore Map';

  @override
  String journalCityCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n cities',
      one: '1 city',
    );
    return '$_temp0';
  }

  @override
  String get journalNoneForCountry => 'No journal yet for this country.';

  @override
  String get journalChooseCountry => 'Choose country';

  @override
  String journalCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n journals',
      one: '1 journal',
    );
    return '$_temp0';
  }

  @override
  String journalPageCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n pages',
      one: '1 page',
    );
    return '$_temp0';
  }

  @override
  String get journalUntitled => 'Untitled journal';

  @override
  String get journalNoneToPost => 'No journals yet to post.';

  @override
  String get journalPublic => 'Public';

  @override
  String get journalPrivate => 'Private';

  @override
  String get journalRemoveShort => 'Remove';

  @override
  String get journalRemoveTitle => 'Remove from Profile?';

  @override
  String get journalPostTitle => 'Post to Profile?';

  @override
  String get journalRemoveText =>
      'This will make your journal private and hide it from your profile.';

  @override
  String get journalPostText =>
      'This will make your journal visible on your profile. Public journals are visible to anyone who can view your profile.';

  @override
  String get journalRemoved => 'Removed from profile';

  @override
  String get journalPosted => 'Posted to profile';

  @override
  String journalVisibilityError(String error) {
    return 'Could not update visibility: $error';
  }

  @override
  String get journalUnknown => 'Unknown';

  @override
  String get journalNew => 'New Journal';

  @override
  String get journalNewHint => 'Start documenting your journey';

  @override
  String get journalEmpty => 'No journal entries yet';

  @override
  String get journalStartWriting => 'Start Writing';

  @override
  String get journalRemoveProfile => 'Remove from Profile';

  @override
  String get journalView => 'View';

  @override
  String editorSaveError(String error) {
    return 'Could not save: $error';
  }

  @override
  String get editorSavedOffline =>
      'Saved on this device — will sync when online.';

  @override
  String get editorDraftSaved => 'Draft saved!';

  @override
  String get editorAddPicture => 'Add a picture';

  @override
  String get editorFromGallery => 'From gallery';

  @override
  String get editorTakePhoto => 'Take a photo';

  @override
  String get editorPicOffline =>
      'Picture saved on this device — will sync when online.';

  @override
  String get editorPicAdded => 'Picture added!';

  @override
  String editorPicError(String error) {
    return 'Could not add picture: $error';
  }

  @override
  String get editorTicketOffline =>
      'Ticket saved on this device. Will sync when online.';

  @override
  String get editorTicketAdded => 'Ticket added to your journal!';

  @override
  String get editorClosedError => 'Journal editor was closed.';

  @override
  String get editorPageGoneError => 'Journal page is no longer available.';

  @override
  String editorTicketError(String error) {
    return 'Ticket scan failed: $error';
  }

  @override
  String get editorAddSticker => 'Add Sticker';

  @override
  String get editorStickerAirplane => 'Airplane';

  @override
  String get editorStickerTicket => 'Ticket';

  @override
  String get editorStickerCamera => 'Camera';

  @override
  String get editorStickerArt => 'Art';

  @override
  String get editorStickerCoffee => 'Coffee';

  @override
  String get editorStickerBuilding => 'Building';

  @override
  String get editorStickerTheater => 'Theater';

  @override
  String get editorStickerWine => 'Wine';

  @override
  String get editorEditText => 'Edit text';

  @override
  String get editorDuplicate => 'Duplicate';

  @override
  String get editorBringForward => 'Bring forward';

  @override
  String get editorSendBackward => 'Send backward';

  @override
  String get editorTextColor => 'Text Color';

  @override
  String get editorFontFamily => 'Font Family';

  @override
  String get editorDupPage => 'Duplicate page';

  @override
  String get editorMoveLeft => 'Move left';

  @override
  String get editorMoveRight => 'Move right';

  @override
  String get editorDeletePage => 'Delete page';

  @override
  String get editorPageBg => 'Page background';

  @override
  String get editorBgCream => 'Cream';

  @override
  String get editorBgPeach => 'Peach';

  @override
  String get editorBgMint => 'Mint';

  @override
  String get editorBgSky => 'Sky';

  @override
  String get editorBgLavender => 'Lavender';

  @override
  String get editorBgLemon => 'Lemon';

  @override
  String get editorMinPage => 'A journal needs at least one page.';

  @override
  String get editorToolText => 'Text';

  @override
  String get editorToolPicture => 'Picture';

  @override
  String get editorToolTicket => 'Ticket';

  @override
  String get editorToolSticker => 'Sticker';

  @override
  String get editorAddPage => 'Add page';

  @override
  String get editorFormatTooltip => 'Format';

  @override
  String get editorRotateLeft => 'Rotate left';

  @override
  String get editorRotateRight => 'Rotate right';

  @override
  String get editorSmaller => 'Smaller';

  @override
  String get editorBigger => 'Bigger';

  @override
  String get editorRetakePhoto => 'Retake photo';

  @override
  String get editorCropTicket => 'Crop ticket';

  @override
  String get journalNotFound => 'Not found';

  @override
  String get journalNoPages => 'No pages';

  @override
  String journalPageTitle(int n) {
    return 'Page $n';
  }

  @override
  String get journalPdfError => 'Could not download PDF';

  @override
  String get wishEmpty => 'No saved destinations';

  @override
  String get wishEmptyHint =>
      'Tap the heart icon on places or countries to save them';

  @override
  String get wishCountryBadge => 'Country';

  @override
  String get wishRemoveTitle => 'Remove from Wishlist';

  @override
  String wishRemoveText(String name) {
    return 'Remove $name from your wishlist?';
  }

  @override
  String get profileTagline => 'Travel enthusiast';

  @override
  String get profileStatPlaces => 'Places';

  @override
  String get profileStatTrips => 'Trips';

  @override
  String get profileStatFollowers => 'Followers';

  @override
  String get profileStatFollowing => 'Following';

  @override
  String get profileFindTravellers => 'Find travellers to follow';

  @override
  String get profilePhotos => 'Travel Photos';

  @override
  String get profileJournals => 'Journals';

  @override
  String get profileAdd => 'Add';

  @override
  String get profileEdit => 'Edit Profile';

  @override
  String get profileFirstName => 'First name';

  @override
  String get profileLastName => 'Last name';

  @override
  String get profileBio => 'Bio';

  @override
  String get profilePhotoDone => 'Photo uploaded';

  @override
  String get profilePhotoError => 'Could not upload photo';

  @override
  String get profilePhotoDeleteError => 'Could not delete photo';

  @override
  String get profileSaved => 'Profile updated';

  @override
  String get profileDeletePhotoTitle => 'Delete Photo';

  @override
  String get profileDeletePhotoText => 'Remove this photo from your profile?';

  @override
  String get searchTitle => 'Find Travellers';

  @override
  String get searchHint => 'Search by username or name';

  @override
  String get searchError => 'Search failed';

  @override
  String get searchPrompt => 'Start typing to find other travellers';

  @override
  String get searchEmpty => 'No travellers found';

  @override
  String get userFollow => 'Follow';

  @override
  String get userUnfollow => 'Unfollow';

  @override
  String userPrivateText(String username) {
    return 'This profile is private. Follow $username to see their travel photos.';
  }

  @override
  String get userFollowError => 'Could not update follow status';
}
