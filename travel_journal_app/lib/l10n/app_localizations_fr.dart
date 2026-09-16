// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get navHome => 'Accueil';

  @override
  String get navTrips => 'Voyages';

  @override
  String get navJournal => 'Journal';

  @override
  String get navWishlist => 'Envies';

  @override
  String get navProfile => 'Profil';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsAccount => 'Compte';

  @override
  String get settingsMyTrips => 'Mes voyages';

  @override
  String get settingsMyTripsSubtitle => 'Voir et gérer vos voyages';

  @override
  String get settingsMyWishlist => 'Ma liste d\'envies';

  @override
  String get settingsMyWishlistSubtitle => 'Lieux que vous voulez visiter';

  @override
  String get settingsPreferences => 'Préférences';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsNotificationsSubtitle =>
      'Recevez rappels et nouveautés voyage';

  @override
  String get settingsOffline => 'Disponible hors ligne';

  @override
  String get settingsOfflineEnabled => 'Accès hors ligne activé';

  @override
  String get settingsOfflineDisabled => 'Accès hors ligne désactivé';

  @override
  String get settingsProfileStatus => 'Statut du profil';

  @override
  String get settingsProfilePrivate =>
      'Privé – seuls vos abonnés voient votre activité';

  @override
  String get settingsProfilePublic =>
      'Public – tout le monde voit votre activité';

  @override
  String get settingsGeneral => 'Général';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsSelectLanguage => 'Choisir la langue';

  @override
  String get settingsTheme => 'Thème';

  @override
  String get settingsThemeSystem => 'Système';

  @override
  String get settingsThemeLight => 'Clair';

  @override
  String get settingsThemeDark => 'Sombre';

  @override
  String get settingsSelectTheme => 'Choisir le thème';

  @override
  String get settingsServerAddress => 'Adresse du serveur';

  @override
  String settingsServerDefault(String url) {
    return 'Par défaut ($url)';
  }

  @override
  String get settingsServerDialogText =>
      'Où le serveur s\'exécute. Exemples :\n• Wi-Fi maison :  http://192.168.1.50:3001\n• Depuis n\'importe où :    https://your-tunnel-url\n\nLaissez vide pour utiliser le serveur par défaut.';

  @override
  String get settingsServerUpdated => 'Adresse du serveur mise à jour';

  @override
  String get settingsStorage => 'Stockage';

  @override
  String get settingsStorageSubtitle => 'Gérer le contenu téléchargé';

  @override
  String get settingsDangerZone => 'Zone dangereuse';

  @override
  String get settingsDeleteAccount => 'Supprimer le compte';

  @override
  String get settingsDeleteAccountSubtitle =>
      'Supprimer définitivement votre compte et toutes vos données';

  @override
  String get settingsDeleteAccountConfirmTitle => 'Supprimer le compte ?';

  @override
  String get settingsDeleteAccountConfirmText =>
      'Cette action est irréversible. Toutes vos données seront définitivement supprimées.';

  @override
  String get settingsDeleteAccountSoon =>
      'La suppression du compte sera bientôt disponible !';

  @override
  String get settingsDelete => 'Supprimer';

  @override
  String get settingsLogout => 'Déconnexion';

  @override
  String get settingsLogoutConfirmTitle => 'Se déconnecter ?';

  @override
  String get settingsLogoutConfirmText =>
      'Voulez-vous vraiment vous déconnecter ?';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get commonClose => 'Fermer';

  @override
  String get commonRetry => 'Réessayer';

  @override
  String get commonLoading => 'Chargement...';

  @override
  String get commonError => 'Une erreur s\'est produite';

  @override
  String get commonOffline => 'Pas de connexion Internet';

  @override
  String get commonOk => 'OK';

  @override
  String get commonYes => 'Oui';

  @override
  String get commonNo => 'Non';

  @override
  String get commonEdit => 'Modifier';

  @override
  String get authWelcomeBack => 'Bon retour';

  @override
  String get authSignInSubtitle =>
      'Connectez-vous pour poursuivre votre voyage';

  @override
  String get authEmail => 'E-mail';

  @override
  String get authPassword => 'Mot de passe';

  @override
  String get authForgotPassword => 'Mot de passe oublié ?';

  @override
  String get authLogin => 'Se connecter';

  @override
  String get authNoAccount => 'Pas encore de compte ? ';

  @override
  String get authSignUp => 'S\'inscrire';

  @override
  String get authCreateAccount => 'Créer un compte';

  @override
  String get authCreateSubtitle => 'Commencez votre journal de voyage';

  @override
  String get authFullName => 'Nom complet';

  @override
  String get authHaveAccount => 'Vous avez déjà un compte ? ';

  @override
  String get authEnterValid => 'Veuillez saisir des identifiants valides';

  @override
  String get authFillRequired =>
      'Veuillez remplir tous les champs obligatoires';

  @override
  String get authInvalid => 'Identifiants invalides';

  @override
  String get authRegisterFailed => 'Inscription échouée';

  @override
  String get authSessionFailed =>
      'Impossible de démarrer la session. Réessayez.';

  @override
  String authPartialFail(String failed) {
    return 'Certaines données n\'ont pas pu être chargées ($failed). Tirez pour réessayer.';
  }

  @override
  String get splashTagline => 'Journal de voyage';

  @override
  String get splashGetStarted => 'Commencer';

  @override
  String get authGenderMale => 'Homme';

  @override
  String get authGenderFemale => 'Femme';

  @override
  String get authGenderNonBinary => 'Non binaire';

  @override
  String get authGenderPrefer => 'Je préfère ne pas le dire';
}
