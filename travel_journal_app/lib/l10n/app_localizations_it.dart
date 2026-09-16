// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get navHome => 'Home';

  @override
  String get navTrips => 'Viaggi';

  @override
  String get navJournal => 'Diario';

  @override
  String get navWishlist => 'Desideri';

  @override
  String get navProfile => 'Profilo';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get settingsAccount => 'Account';

  @override
  String get settingsMyTrips => 'I miei viaggi';

  @override
  String get settingsMyTripsSubtitle => 'Visualizza e gestisci i tuoi viaggi';

  @override
  String get settingsMyWishlist => 'La mia lista dei desideri';

  @override
  String get settingsMyWishlistSubtitle => 'Luoghi che vuoi visitare';

  @override
  String get settingsPreferences => 'Preferenze';

  @override
  String get settingsNotifications => 'Notifiche';

  @override
  String get settingsNotificationsSubtitle =>
      'Ricevi promemoria e novità di viaggio';

  @override
  String get settingsOffline => 'Disponibile offline';

  @override
  String get settingsOfflineEnabled => 'Accesso offline attivato';

  @override
  String get settingsOfflineDisabled => 'Accesso offline disattivato';

  @override
  String get settingsProfileStatus => 'Stato del profilo';

  @override
  String get settingsProfilePrivate =>
      'Privato – solo i follower vedono la tua attività';

  @override
  String get settingsProfilePublic =>
      'Pubblico – chiunque può vedere la tua attività';

  @override
  String get settingsGeneral => 'Generali';

  @override
  String get settingsLanguage => 'Lingua';

  @override
  String get settingsSelectLanguage => 'Seleziona la lingua';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeSystem => 'Sistema';

  @override
  String get settingsThemeLight => 'Chiaro';

  @override
  String get settingsThemeDark => 'Scuro';

  @override
  String get settingsSelectTheme => 'Seleziona il tema';

  @override
  String get settingsServerAddress => 'Indirizzo del server';

  @override
  String settingsServerDefault(String url) {
    return 'Predefinito ($url)';
  }

  @override
  String get settingsServerDialogText =>
      'Dove è in esecuzione il backend. Esempi:\n• Wi-Fi di casa:  http://192.168.1.50:3001\n• Da qualsiasi luogo:    https://your-tunnel-url\n\nLascia vuoto per usare il server predefinito.';

  @override
  String get settingsServerUpdated => 'Indirizzo del server aggiornato';

  @override
  String get settingsStorage => 'Archiviazione';

  @override
  String get settingsStorageSubtitle => 'Gestisci i contenuti scaricati';

  @override
  String get settingsDangerZone => 'Zona pericolosa';

  @override
  String get settingsDeleteAccount => 'Elimina account';

  @override
  String get settingsDeleteAccountSubtitle =>
      'Elimina definitivamente il tuo account e tutti i dati';

  @override
  String get settingsDeleteAccountConfirmTitle => 'Eliminare l\'account?';

  @override
  String get settingsDeleteAccountConfirmText =>
      'Questa azione non può essere annullata. Tutti i tuoi dati saranno eliminati definitivamente.';

  @override
  String get settingsDeleteAccountSoon =>
      'L\'eliminazione dell\'account sarà presto disponibile!';

  @override
  String get settingsDelete => 'Elimina';

  @override
  String get settingsLogout => 'Esci';

  @override
  String get settingsLogoutConfirmTitle => 'Uscire?';

  @override
  String get settingsLogoutConfirmText => 'Sei sicuro di voler uscire?';

  @override
  String get commonCancel => 'Annulla';

  @override
  String get commonSave => 'Salva';

  @override
  String get commonClose => 'Chiudi';

  @override
  String get commonRetry => 'Riprova';

  @override
  String get commonLoading => 'Caricamento...';

  @override
  String get commonError => 'Si è verificato un errore';

  @override
  String get commonOffline => 'Nessuna connessione Internet';

  @override
  String get commonOk => 'OK';

  @override
  String get commonYes => 'Sì';

  @override
  String get commonNo => 'No';

  @override
  String get commonEdit => 'Modifica';

  @override
  String get authWelcomeBack => 'Bentornato';

  @override
  String get authSignInSubtitle => 'Accedi per continuare il tuo viaggio';

  @override
  String get authEmail => 'Email';

  @override
  String get authPassword => 'Password';

  @override
  String get authForgotPassword => 'Password dimenticata?';

  @override
  String get authLogin => 'Accedi';

  @override
  String get authNoAccount => 'Non hai un account? ';

  @override
  String get authSignUp => 'Registrati';

  @override
  String get authCreateAccount => 'Crea account';

  @override
  String get authCreateSubtitle => 'Inizia il tuo diario di viaggio';

  @override
  String get authFullName => 'Nome completo';

  @override
  String get authHaveAccount => 'Hai già un account? ';

  @override
  String get authEnterValid => 'Inserisci credenziali valide';

  @override
  String get authFillRequired => 'Compila tutti i campi obbligatori';

  @override
  String get authInvalid => 'Credenziali non valide';

  @override
  String get authRegisterFailed => 'Registrazione non riuscita';

  @override
  String get authSessionFailed => 'Impossibile avviare la sessione. Riprova.';

  @override
  String authPartialFail(String failed) {
    return 'Alcuni dati non sono stati caricati ($failed). Trascina per riprovare.';
  }

  @override
  String get splashTagline => 'Diario di viaggio';

  @override
  String get splashGetStarted => 'Inizia';

  @override
  String get authGenderMale => 'Uomo';

  @override
  String get authGenderFemale => 'Donna';

  @override
  String get authGenderNonBinary => 'Non binario';

  @override
  String get authGenderPrefer => 'Preferisco non dirlo';

  @override
  String get homeSearchHint => 'Cerca paese o città...';

  @override
  String get homeCountriesTitle => 'Paesi';

  @override
  String homeCountriesCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n paesi',
      one: '1 paese',
    );
    return '$_temp0';
  }

  @override
  String get homeLoadError => 'Impossibile caricare i paesi';

  @override
  String get homeTapRetry => 'Tocca per riprovare';

  @override
  String get progressTitle => 'Progresso di viaggio';

  @override
  String progressCount(int v, int t) {
    return '$v / $t paesi';
  }

  @override
  String get countryRate => 'Valuta';

  @override
  String get countryVisitedPrompt => 'Visitato?';

  @override
  String get countryWishlist => 'Desideri';

  @override
  String get countryWishlisted => 'Nei desideri';

  @override
  String countryMarkedVisited(String name) {
    return '$name segnato come visitato';
  }

  @override
  String countryUnmarkedVisited(String name) {
    return '$name non più segnato come visitato';
  }

  @override
  String countryAbout(String name) {
    return 'Su $name';
  }

  @override
  String get countryMajorCities => 'Città principali';

  @override
  String get countryMapPreview => 'Anteprima mappa';

  @override
  String rateDialogTitle(String name) {
    return 'Valuta $name';
  }

  @override
  String get cityDiscover => 'Cosa scoprire';

  @override
  String get catHistorical => 'Siti storici';

  @override
  String get catArtLovers => 'Per gli amanti dell\'arte';

  @override
  String get catAtmosphere => 'Atmosfera ed esperienze';

  @override
  String get catHiddenGems => 'Gemme nascoste';

  @override
  String get catCloseBy => 'Vicino';

  @override
  String get catMyPlaces => 'I miei luoghi';

  @override
  String get categoryPlaces => 'Luoghi';

  @override
  String get placeMarkVisited => 'Segna come visitato';

  @override
  String get markShort => 'Segna';

  @override
  String get detailsAbout => 'Su questo luogo';

  @override
  String get detailsLocation => 'Posizione';

  @override
  String get detailsWebsiteError => 'Impossibile aprire il sito web';

  @override
  String get detailsVisitedAdded => 'Segnato come visitato!';

  @override
  String get detailsVisitedRemoved => 'Stato di visitato rimosso';

  @override
  String get detailsMarkAsVisited => 'Segna come visitato';

  @override
  String get visitedLabel => 'Visitato';

  @override
  String wishlistAdded(String name) {
    return '$name aggiunto alla lista dei desideri';
  }

  @override
  String wishlistRemoved(String name) {
    return '$name rimosso dalla lista dei desideri';
  }

  @override
  String get tripsNewTrip => 'Nuovo viaggio';

  @override
  String get tripsEmptyTitle => 'Ancora nessun viaggio';

  @override
  String get tripsEmptyHint =>
      'Tocca \"Nuovo viaggio\" per iniziare a pianificare';

  @override
  String get tripsDraftHint => 'Bozza IA pronta: tocca per rivedere e salvare';

  @override
  String tripDurationDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n giorni',
      one: '1 giorno',
    );
    return '$_temp0';
  }

  @override
  String get tripStyleSolo => 'Da solo';

  @override
  String get tripStyleGroup => 'In gruppo';

  @override
  String get tripTypeHistorical => 'Storico';

  @override
  String get tripTypeArt => 'Arte';

  @override
  String get tripTypeMixed => 'Misto';

  @override
  String get tripFormTitleNew => 'Nuovo viaggio';

  @override
  String get tripFormTitleEdit => 'Modifica viaggio';

  @override
  String get tripSectionDestination => 'Destinazione';

  @override
  String get tripSectionDates => 'Date';

  @override
  String get tripSectionVacationType => 'Tipo di vacanza';

  @override
  String get tripSectionTravelStyle => 'Stile di viaggio';

  @override
  String get tripSectionCompanions => 'Compagni di viaggio';

  @override
  String get tripChooseCountry => 'Scegli un paese';

  @override
  String get tripChooseCities => 'Scegli le città (facoltativo)';

  @override
  String get tripArrivalCity => 'Città di arrivo';

  @override
  String get tripDepartureCity => 'Città di partenza';

  @override
  String get tripStartDate => 'Data di inizio';

  @override
  String get tripEndDate => 'Data di fine';

  @override
  String get tripSelect => 'Seleziona';

  @override
  String tripDurationLabel(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Durata: $n giorni',
      one: 'Durata: 1 giorno',
    );
    return '$_temp0';
  }

  @override
  String get tripNoFriendsHint =>
      'Nessun amico ancora. Segui altri viaggiatori (e lascia che ti seguano): appariranno qui come compagni.';

  @override
  String get tripCountryFirst => 'Scegli prima un paese';

  @override
  String get tripSheetCities => 'Scegli le città da visitare';

  @override
  String tripSelectedCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n selezionate',
      one: '1 selezionata',
    );
    return '$_temp0';
  }

  @override
  String tripCitiesIn(String name) {
    return 'Città in $name';
  }

  @override
  String get tripNearbyCities => 'Vicino, nei paesi confinanti';

  @override
  String get tripSearchCities => 'Cerca città';

  @override
  String get tripSheetDone => 'Fatto';

  @override
  String tripAddCities(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Aggiungi $n città',
      one: 'Aggiungi 1 città',
    );
    return '$_temp0';
  }

  @override
  String get tripGenerating => 'Generazione...';

  @override
  String get tripSave => 'Salva viaggio';

  @override
  String get tripGenerate => 'Genera piano di viaggio';

  @override
  String get tripDurationLocked =>
      'Non puoi modificare la durata qui. Crea un nuovo viaggio per cambiare i giorni.';

  @override
  String get tripGenFailTitle => 'Impossibile generare il viaggio';

  @override
  String get tripGenFailFallback =>
      'Qualcosa è andato storto durante la generazione.';

  @override
  String get tripGenBasic => 'Crea itinerario base senza IA';

  @override
  String get planNotFound => 'Viaggio non trovato';

  @override
  String get planItineraryTitle => 'Itinerario giorno per giorno';

  @override
  String get planMapView => 'Vedi mappa';

  @override
  String get planExporting => 'Esportazione...';

  @override
  String get planExportPdf => 'Esporta PDF';

  @override
  String get planRegenerate => 'Rigenera';

  @override
  String get planDiscard => 'Scarta';

  @override
  String get planSaving => 'Salvataggio...';

  @override
  String get planDraftNote => 'Bozza IA – non ancora salvata nei tuoi viaggi';

  @override
  String get planSaved => 'Viaggio salvato!';

  @override
  String get planSaveError => 'Impossibile salvare il viaggio';

  @override
  String get planRegenerated => 'Nuovo itinerario generato';

  @override
  String get planRegenError => 'Impossibile rigenerare il viaggio';

  @override
  String get planLoadError => 'Impossibile caricare i dettagli';

  @override
  String get planPdfDone => 'PDF scaricato';

  @override
  String get planPdfError => 'Impossibile esportare il PDF';

  @override
  String get planDiscardTitle => 'Scartare la bozza?';

  @override
  String get planDiscardText => 'Questa bozza IA verrà rimossa.';

  @override
  String get planDeleteTitle => 'Elimina viaggio';

  @override
  String get planDeleteText => 'Vuoi davvero eliminare questo viaggio?';

  @override
  String planDayNumber(int n) {
    return 'GIORNO $n';
  }

  @override
  String get planMorning => 'Mattina';

  @override
  String get planAfternoon => 'Pomeriggio';

  @override
  String get planEvening => 'Sera';

  @override
  String get planActivityFallback => 'Attività';

  @override
  String get mapTitle => 'Mappa del viaggio';

  @override
  String mapDay(int n) {
    return 'Giorno $n';
  }

  @override
  String get mapAllDays => 'Tutti';

  @override
  String get mapViewDetails => 'Vedi dettagli';

  @override
  String mapCategory(int id) {
    return 'Categoria $id';
  }

  @override
  String get mapPlaceError => 'Impossibile caricare i dettagli del luogo';

  @override
  String get mapEmptyTitle => 'Nessun luogo sulla mappa';

  @override
  String get mapEmptyText =>
      'Questo itinerario non contiene luoghi con coordinate. Gli itinerari base e i giorni vuoti non vengono mostrati sulla mappa.';

  @override
  String mapPlacesShown(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n luoghi mostrati',
      one: '1 luogo mostrato',
    );
    return '$_temp0';
  }

  @override
  String get mapNoCoordsSuffix => '– senza coordinate';
}
