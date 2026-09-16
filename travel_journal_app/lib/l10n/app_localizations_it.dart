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
}
