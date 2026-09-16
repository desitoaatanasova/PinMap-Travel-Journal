// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get navHome => 'Start';

  @override
  String get navTrips => 'Reisen';

  @override
  String get navJournal => 'Tagebuch';

  @override
  String get navWishlist => 'Wunschliste';

  @override
  String get navProfile => 'Profil';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsAccount => 'Konto';

  @override
  String get settingsMyTrips => 'Meine Reisen';

  @override
  String get settingsMyTripsSubtitle => 'Reisen ansehen und verwalten';

  @override
  String get settingsMyWishlist => 'Meine Wunschliste';

  @override
  String get settingsMyWishlistSubtitle => 'Orte, die du besuchen möchtest';

  @override
  String get settingsPreferences => 'Präferenzen';

  @override
  String get settingsNotifications => 'Benachrichtigungen';

  @override
  String get settingsNotificationsSubtitle =>
      'Reiseerinnerungen und Neuigkeiten erhalten';

  @override
  String get settingsOffline => 'Offline verfügbar';

  @override
  String get settingsOfflineEnabled => 'Offline-Zugriff aktiviert';

  @override
  String get settingsOfflineDisabled => 'Offline-Zugriff deaktiviert';

  @override
  String get settingsProfileStatus => 'Profilstatus';

  @override
  String get settingsProfilePrivate =>
      'Privat – nur Follower sehen deine Aktivität';

  @override
  String get settingsProfilePublic =>
      'Öffentlich – jeder kann deine Aktivität sehen';

  @override
  String get settingsGeneral => 'Allgemein';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsSelectLanguage => 'Sprache wählen';

  @override
  String get settingsTheme => 'Design';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThemeLight => 'Hell';

  @override
  String get settingsThemeDark => 'Dunkel';

  @override
  String get settingsSelectTheme => 'Design wählen';

  @override
  String get settingsServerAddress => 'Serveradresse';

  @override
  String settingsServerDefault(String url) {
    return 'Standard ($url)';
  }

  @override
  String get settingsServerDialogText =>
      'Wo der Server läuft. Beispiele:\n• Heim-WLAN:  http://192.168.1.50:3001\n• Von überall:    https://your-tunnel-url\n\nLeer lassen, um den Standardserver zu verwenden.';

  @override
  String get settingsServerUpdated => 'Serveradresse aktualisiert';

  @override
  String get settingsStorage => 'Speicher';

  @override
  String get settingsStorageSubtitle => 'Heruntergeladene Inhalte verwalten';

  @override
  String get settingsDangerZone => 'Gefahrenzone';

  @override
  String get settingsDeleteAccount => 'Konto löschen';

  @override
  String get settingsDeleteAccountSubtitle =>
      'Konto und alle Daten endgültig löschen';

  @override
  String get settingsDeleteAccountConfirmTitle => 'Konto löschen?';

  @override
  String get settingsDeleteAccountConfirmText =>
      'Diese Aktion kann nicht rückgängig gemacht werden. Alle deine Daten werden endgültig gelöscht.';

  @override
  String get settingsDeleteAccountSoon => 'Kontolöschung bald verfügbar!';

  @override
  String get settingsDelete => 'Löschen';

  @override
  String get settingsLogout => 'Abmelden';

  @override
  String get settingsLogoutConfirmTitle => 'Abmelden?';

  @override
  String get settingsLogoutConfirmText => 'Möchtest du dich wirklich abmelden?';

  @override
  String get commonCancel => 'Abbrechen';

  @override
  String get commonSave => 'Speichern';

  @override
  String get commonClose => 'Schließen';

  @override
  String get commonRetry => 'Wiederholen';

  @override
  String get commonLoading => 'Wird geladen...';

  @override
  String get commonError => 'Etwas ist schiefgelaufen';

  @override
  String get commonOffline => 'Keine Internetverbindung';

  @override
  String get commonOk => 'OK';

  @override
  String get commonYes => 'Ja';

  @override
  String get commonNo => 'Nein';

  @override
  String get commonEdit => 'Bearbeiten';

  @override
  String get authWelcomeBack => 'Willkommen zurück';

  @override
  String get authSignInSubtitle => 'Melde dich an, um deine Reise fortzusetzen';

  @override
  String get authEmail => 'E-Mail';

  @override
  String get authPassword => 'Passwort';

  @override
  String get authForgotPassword => 'Passwort vergessen?';

  @override
  String get authLogin => 'Anmelden';

  @override
  String get authNoAccount => 'Noch kein Konto? ';

  @override
  String get authSignUp => 'Registrieren';

  @override
  String get authCreateAccount => 'Konto erstellen';

  @override
  String get authCreateSubtitle => 'Starte dein Reisetagebuch';

  @override
  String get authFullName => 'Vollständiger Name';

  @override
  String get authHaveAccount => 'Hast du bereits ein Konto? ';

  @override
  String get authEnterValid => 'Bitte gib gültige Anmeldedaten ein';

  @override
  String get authFillRequired => 'Bitte fülle alle Pflichtfelder aus';

  @override
  String get authInvalid => 'Ungültige Anmeldedaten';

  @override
  String get authRegisterFailed => 'Registrierung fehlgeschlagen';

  @override
  String get authSessionFailed =>
      'Sitzung konnte nicht gestartet werden. Versuche es erneut.';

  @override
  String authPartialFail(String failed) {
    return 'Einige Daten konnten nicht geladen werden ($failed). Zum Wiederholen ziehen.';
  }

  @override
  String get splashTagline => 'Reisetagebuch';

  @override
  String get splashGetStarted => 'Los geht\'s';

  @override
  String get authGenderMale => 'Männlich';

  @override
  String get authGenderFemale => 'Weiblich';

  @override
  String get authGenderNonBinary => 'Nicht-binär';

  @override
  String get authGenderPrefer => 'Keine Angabe';

  @override
  String get homeSearchHint => 'Land oder Stadt suchen ...';

  @override
  String get homeCountriesTitle => 'Länder';

  @override
  String homeCountriesCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Länder',
      one: '1 Land',
    );
    return '$_temp0';
  }

  @override
  String get homeLoadError => 'Länder konnten nicht geladen werden';

  @override
  String get homeTapRetry => 'Zum Wiederholen tippen';

  @override
  String get progressTitle => 'Reisefortschritt';

  @override
  String progressCount(int v, int t) {
    return '$v / $t Länder';
  }

  @override
  String get countryRate => 'Bewerten';

  @override
  String get countryVisitedPrompt => 'Besucht?';

  @override
  String get countryWishlist => 'Wunschliste';

  @override
  String get countryWishlisted => 'Auf Wunschliste';

  @override
  String countryMarkedVisited(String name) {
    return '$name als besucht markiert';
  }

  @override
  String countryUnmarkedVisited(String name) {
    return '$name nicht mehr als besucht markiert';
  }

  @override
  String countryAbout(String name) {
    return 'Über $name';
  }

  @override
  String get countryMajorCities => 'Großstädte';

  @override
  String get countryMapPreview => 'Kartenvorschau';

  @override
  String rateDialogTitle(String name) {
    return '$name bewerten';
  }

  @override
  String get cityDiscover => 'Was es zu entdecken gibt';

  @override
  String get catHistorical => 'Historische Sehenswürdigkeiten';

  @override
  String get catArtLovers => 'Für Kunstliebhaber';

  @override
  String get catAtmosphere => 'Atmosphäre & Erlebnisse';

  @override
  String get catHiddenGems => 'Geheimtipps';

  @override
  String get catCloseBy => 'In der Nähe';

  @override
  String get catMyPlaces => 'Meine Orte';

  @override
  String get categoryPlaces => 'Orte';

  @override
  String get placeMarkVisited => 'Als besucht markieren';

  @override
  String get markShort => 'Markieren';

  @override
  String get detailsAbout => 'Über diesen Ort';

  @override
  String get detailsLocation => 'Standort';

  @override
  String get detailsWebsiteError => 'Website konnte nicht geöffnet werden';

  @override
  String get detailsVisitedAdded => 'Als besucht markiert!';

  @override
  String get detailsVisitedRemoved => 'Besucht-Status entfernt';

  @override
  String get detailsMarkAsVisited => 'Als besucht markieren';

  @override
  String get visitedLabel => 'Besucht';

  @override
  String wishlistAdded(String name) {
    return '$name zur Wunschliste hinzugefügt';
  }

  @override
  String wishlistRemoved(String name) {
    return '$name von der Wunschliste entfernt';
  }

  @override
  String get tripsNewTrip => 'Neue Reise';

  @override
  String get tripsEmptyTitle => 'Noch keine Reisen';

  @override
  String get tripsEmptyHint =>
      'Tippe auf \"Neue Reise\", um mit der Planung zu beginnen';

  @override
  String get tripsDraftHint =>
      'KI-Entwurf bereit – zum Prüfen & Speichern tippen';

  @override
  String tripDurationDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Tage',
      one: '1 Tag',
    );
    return '$_temp0';
  }

  @override
  String get tripStyleSolo => 'Allein';

  @override
  String get tripStyleGroup => 'Gruppe';

  @override
  String get tripTypeHistorical => 'Historisch';

  @override
  String get tripTypeArt => 'Kunst';

  @override
  String get tripTypeMixed => 'Gemischt';

  @override
  String get tripFormTitleNew => 'Neue Reise';

  @override
  String get tripFormTitleEdit => 'Reise bearbeiten';

  @override
  String get tripSectionDestination => 'Reiseziel';

  @override
  String get tripSectionDates => 'Daten';

  @override
  String get tripSectionVacationType => 'Art des Urlaubs';

  @override
  String get tripSectionTravelStyle => 'Reisestil';

  @override
  String get tripSectionCompanions => 'Reisebegleitung';

  @override
  String get tripChooseCountry => 'Land wählen';

  @override
  String get tripChooseCities => 'Städte wählen (optional)';

  @override
  String get tripArrivalCity => 'Ankunftsstadt';

  @override
  String get tripDepartureCity => 'Abflugstadt';

  @override
  String get tripStartDate => 'Startdatum';

  @override
  String get tripEndDate => 'Enddatum';

  @override
  String get tripSelect => 'Auswählen';

  @override
  String tripDurationLabel(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Dauer: $n Tage',
      one: 'Dauer: 1 Tag',
    );
    return '$_temp0';
  }

  @override
  String get tripNoFriendsHint =>
      'Noch keine Freunde gefunden. Folge anderen Reisenden (und lass sie dir zurückfolgen), dann erscheinen sie hier als Reisebegleitung.';

  @override
  String get tripCountryFirst => 'Wähle zuerst ein Land';

  @override
  String get tripSheetCities => 'Städte zur Besichtigung wählen';

  @override
  String tripSelectedCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ausgewählt',
      one: '1 ausgewählt',
    );
    return '$_temp0';
  }

  @override
  String tripCitiesIn(String name) {
    return 'Städte in $name';
  }

  @override
  String get tripNearbyCities => 'In der Nähe in Nachbarländern';

  @override
  String get tripSearchCities => 'Städte suchen';

  @override
  String get tripSheetDone => 'Fertig';

  @override
  String tripAddCities(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Städte hinzufügen',
      one: '1 Stadt hinzufügen',
    );
    return '$_temp0';
  }

  @override
  String get tripGenerating => 'Wird generiert ...';

  @override
  String get tripSave => 'Reise speichern';

  @override
  String get tripGenerate => 'Reiseplan generieren';

  @override
  String get tripDurationLocked =>
      'Die Reisedauer kann hier nicht geändert werden. Erstelle eine neue Reise, um die Tage zu ändern.';

  @override
  String get tripGenFailTitle => 'Reise konnte nicht generiert werden';

  @override
  String get tripGenFailFallback =>
      'Beim Generieren deiner Reise ist etwas schiefgelaufen.';

  @override
  String get tripGenBasic => 'Einfache Route ohne KI erstellen';

  @override
  String get planNotFound => 'Reise nicht gefunden';

  @override
  String get planItineraryTitle => 'Tagesprogramm';

  @override
  String get planMapView => 'Kartenansicht';

  @override
  String get planExporting => 'Wird exportiert ...';

  @override
  String get planExportPdf => 'PDF exportieren';

  @override
  String get planRegenerate => 'Neu generieren';

  @override
  String get planDiscard => 'Verwerfen';

  @override
  String get planSaving => 'Wird gespeichert ...';

  @override
  String get planDraftNote =>
      'KI-Entwurf – noch nicht in deinen Reisen gespeichert';

  @override
  String get planSaved => 'Reise wurde gespeichert!';

  @override
  String get planSaveError => 'Reise konnte nicht gespeichert werden';

  @override
  String get planRegenerated => 'Neue Route generiert';

  @override
  String get planRegenError => 'Reise konnte nicht neu generiert werden';

  @override
  String get planLoadError => 'Reisedetails konnten nicht geladen werden';

  @override
  String get planPdfDone => 'PDF heruntergeladen';

  @override
  String get planPdfError => 'PDF konnte nicht exportiert werden';

  @override
  String get planDiscardTitle => 'Entwurf verwerfen?';

  @override
  String get planDiscardText => 'Dieser KI-Entwurf wird entfernt.';

  @override
  String get planDeleteTitle => 'Reise löschen';

  @override
  String get planDeleteText => 'Möchtest du diese Reise wirklich löschen?';

  @override
  String planDayNumber(int n) {
    return 'TAG $n';
  }

  @override
  String get planMorning => 'Morgens';

  @override
  String get planAfternoon => 'Nachmittags';

  @override
  String get planEvening => 'Abends';

  @override
  String get planActivityFallback => 'Aktivität';

  @override
  String get mapTitle => 'Reisekarte';

  @override
  String mapDay(int n) {
    return 'Tag $n';
  }

  @override
  String get mapAllDays => 'Alle';

  @override
  String get mapViewDetails => 'Details ansehen';

  @override
  String mapCategory(int id) {
    return 'Kategorie $id';
  }

  @override
  String get mapPlaceError => 'Ortsdetails konnten nicht geladen werden';

  @override
  String get mapEmptyTitle => 'Keine Orte auf der Karte';

  @override
  String get mapEmptyText =>
      'Diese Route enthält keine Orte mit Koordinaten. Einfache Routen und leere Tage werden nicht auf der Karte angezeigt.';

  @override
  String mapPlacesShown(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Orte werden gezeigt',
      one: '1 Ort wird gezeigt',
    );
    return '$_temp0';
  }

  @override
  String get mapNoCoordsSuffix => '– ohne Koordinaten';

  @override
  String get journalOverviewTitle => 'Tagebuch-Übersicht';

  @override
  String get journalDownload => 'Tagebuch herunterladen';

  @override
  String get journalPost => 'Im Profil posten';

  @override
  String get journalNoCountries => 'Noch keine Länder geladen';

  @override
  String get journalExploreMap => 'Karte erkunden';

  @override
  String journalCityCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Städte',
      one: '1 Stadt',
    );
    return '$_temp0';
  }

  @override
  String get journalNoneForCountry => 'Noch kein Tagebuch für dieses Land.';

  @override
  String get journalChooseCountry => 'Land wählen';

  @override
  String journalCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Tagebücher',
      one: '1 Tagebuch',
    );
    return '$_temp0';
  }

  @override
  String journalPageCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Seiten',
      one: '1 Seite',
    );
    return '$_temp0';
  }

  @override
  String get journalUntitled => 'Tagebuch ohne Titel';

  @override
  String get journalNoneToPost => 'Noch keine Tagebücher zum Posten.';

  @override
  String get journalPublic => 'Öffentlich';

  @override
  String get journalPrivate => 'Privat';

  @override
  String get journalRemoveShort => 'Entfernen';

  @override
  String get journalRemoveTitle => 'Aus dem Profil entfernen?';

  @override
  String get journalPostTitle => 'Im Profil posten?';

  @override
  String get journalRemoveText =>
      'Dadurch wird dein Tagebuch privat und aus deinem Profil ausgeblendet.';

  @override
  String get journalPostText =>
      'Dadurch wird dein Tagebuch in deinem Profil sichtbar. Öffentliche Tagebücher sind für alle sichtbar, die dein Profil sehen können.';

  @override
  String get journalRemoved => 'Aus dem Profil entfernt';

  @override
  String get journalPosted => 'Im Profil gepostet';

  @override
  String journalVisibilityError(String error) {
    return 'Sichtbarkeit konnte nicht aktualisiert werden: $error';
  }

  @override
  String get journalUnknown => 'Unbekannt';

  @override
  String get journalNew => 'Neues Tagebuch';

  @override
  String get journalNewHint => 'Beginne, deine Reise zu dokumentieren';

  @override
  String get journalEmpty => 'Noch keine Tagebucheinträge';

  @override
  String get journalStartWriting => 'Mit dem Schreiben beginnen';

  @override
  String get journalRemoveProfile => 'Aus dem Profil entfernen';

  @override
  String get journalView => 'Ansehen';

  @override
  String editorSaveError(String error) {
    return 'Konnte nicht gespeichert werden: $error';
  }

  @override
  String get editorSavedOffline =>
      'Auf diesem Gerät gespeichert – wird synchronisiert, sobald du online bist.';

  @override
  String get editorDraftSaved => 'Entwurf gespeichert!';

  @override
  String get editorAddPicture => 'Bild hinzufügen';

  @override
  String get editorFromGallery => 'Aus der Galerie';

  @override
  String get editorTakePhoto => 'Foto aufnehmen';

  @override
  String get editorPicOffline =>
      'Bild auf diesem Gerät gespeichert – wird synchronisiert, sobald du online bist.';

  @override
  String get editorPicAdded => 'Bild hinzugefügt!';

  @override
  String editorPicError(String error) {
    return 'Bild konnte nicht hinzugefügt werden: $error';
  }

  @override
  String get editorTicketOffline =>
      'Ticket auf diesem Gerät gespeichert. Wird synchronisiert, sobald du online bist.';

  @override
  String get editorTicketAdded => 'Ticket zu deinem Tagebuch hinzugefügt!';

  @override
  String get editorClosedError => 'Tagebuch-Editor wurde geschlossen.';

  @override
  String get editorPageGoneError => 'Tagebuchseite ist nicht mehr verfügbar.';

  @override
  String editorTicketError(String error) {
    return 'Ticket-Scan fehlgeschlagen: $error';
  }

  @override
  String get editorAddSticker => 'Sticker hinzufügen';

  @override
  String get editorStickerAirplane => 'Flugzeug';

  @override
  String get editorStickerTicket => 'Ticket';

  @override
  String get editorStickerCamera => 'Kamera';

  @override
  String get editorStickerArt => 'Kunst';

  @override
  String get editorStickerCoffee => 'Kaffee';

  @override
  String get editorStickerBuilding => 'Gebäude';

  @override
  String get editorStickerTheater => 'Theater';

  @override
  String get editorStickerWine => 'Wein';

  @override
  String get editorEditText => 'Text bearbeiten';

  @override
  String get editorDuplicate => 'Duplizieren';

  @override
  String get editorBringForward => 'Nach vorne';

  @override
  String get editorSendBackward => 'Nach hinten';

  @override
  String get editorTextColor => 'Textfarbe';

  @override
  String get editorFontFamily => 'Schriftart';

  @override
  String get editorDupPage => 'Seite duplizieren';

  @override
  String get editorMoveLeft => 'Nach links';

  @override
  String get editorMoveRight => 'Nach rechts';

  @override
  String get editorDeletePage => 'Seite löschen';

  @override
  String get editorPageBg => 'Seitenhintergrund';

  @override
  String get editorBgCream => 'Creme';

  @override
  String get editorBgPeach => 'Pfirsich';

  @override
  String get editorBgMint => 'Minze';

  @override
  String get editorBgSky => 'Himmel';

  @override
  String get editorBgLavender => 'Lavendel';

  @override
  String get editorBgLemon => 'Zitrone';

  @override
  String get editorMinPage => 'Ein Tagebuch braucht mindestens eine Seite.';

  @override
  String get editorToolText => 'Text';

  @override
  String get editorToolPicture => 'Bild';

  @override
  String get editorToolTicket => 'Ticket';

  @override
  String get editorToolSticker => 'Sticker';

  @override
  String get editorAddPage => 'Seite hinzufügen';

  @override
  String get editorFormatTooltip => 'Format';

  @override
  String get editorRotateLeft => 'Nach links drehen';

  @override
  String get editorRotateRight => 'Nach rechts drehen';

  @override
  String get editorSmaller => 'Kleiner';

  @override
  String get editorBigger => 'Größer';

  @override
  String get editorRetakePhoto => 'Foto wiederholen';

  @override
  String get editorCropTicket => 'Ticket zuschneiden';

  @override
  String get journalNotFound => 'Nicht gefunden';

  @override
  String get journalNoPages => 'Keine Seiten';

  @override
  String journalPageTitle(int n) {
    return 'Seite $n';
  }

  @override
  String get journalPdfError => 'PDF konnte nicht heruntergeladen werden';

  @override
  String get wishEmpty => 'Keine gespeicherten Ziele';

  @override
  String get wishEmptyHint =>
      'Tippe auf das Herz bei Orten oder Ländern, um sie zu speichern';

  @override
  String get wishCountryBadge => 'Land';

  @override
  String get wishRemoveTitle => 'Von der Wunschliste entfernen';

  @override
  String wishRemoveText(String name) {
    return '$name von deiner Wunschliste entfernen?';
  }

  @override
  String get profileTagline => 'Reisebegeisterter';

  @override
  String get profileStatPlaces => 'Orte';

  @override
  String get profileStatTrips => 'Reisen';

  @override
  String get profileStatFollowers => 'Follower';

  @override
  String get profileStatFollowing => 'Folge ich';

  @override
  String get profileFindTravellers => 'Finde Reisende zum Folgen';

  @override
  String get profilePhotos => 'Reisefotos';

  @override
  String get profileJournals => 'Tagebücher';

  @override
  String get profileAdd => 'Hinzufügen';

  @override
  String get profileEdit => 'Profil bearbeiten';

  @override
  String get profileFirstName => 'Vorname';

  @override
  String get profileLastName => 'Nachname';

  @override
  String get profileBio => 'Bio';

  @override
  String get profilePhotoDone => 'Foto hochgeladen';

  @override
  String get profilePhotoError => 'Foto konnte nicht hochgeladen werden';

  @override
  String get profilePhotoDeleteError => 'Foto konnte nicht gelöscht werden';

  @override
  String get profileSaved => 'Profil aktualisiert';

  @override
  String get profileDeletePhotoTitle => 'Foto löschen';

  @override
  String get profileDeletePhotoText =>
      'Dieses Foto aus deinem Profil entfernen?';

  @override
  String get searchTitle => 'Reisende finden';

  @override
  String get searchHint => 'Nach Benutzername oder Name suchen';

  @override
  String get searchError => 'Suche fehlgeschlagen';

  @override
  String get searchPrompt => 'Tippe, um andere Reisende zu finden';

  @override
  String get searchEmpty => 'Keine Reisenden gefunden';

  @override
  String get userFollow => 'Folgen';

  @override
  String get userUnfollow => 'Entfolgen';

  @override
  String userPrivateText(String username) {
    return 'Dieses Profil ist privat. Folge $username, um die Reisefotos zu sehen.';
  }

  @override
  String get userFollowError =>
      'Follow-Status konnte nicht aktualisiert werden';

  @override
  String get journalDeleteAction => 'Tagebuch löschen';

  @override
  String get journalDeleteTitle => 'Tagebuch löschen?';

  @override
  String journalDeleteText(String name) {
    return 'Dadurch wird „$name“ endgültig gelöscht. Dies kann nicht rückgängig gemacht werden.';
  }

  @override
  String get journalDeleted => 'Tagebuch gelöscht';

  @override
  String get journalDeleteError => 'Tagebuch konnte nicht gelöscht werden';
}
