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
}
