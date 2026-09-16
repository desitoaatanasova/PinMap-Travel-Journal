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

  @override
  String get homeSearchHint => 'Rechercher un pays ou une ville...';

  @override
  String get homeCountriesTitle => 'Pays';

  @override
  String homeCountriesCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n pays',
      one: '1 pays',
    );
    return '$_temp0';
  }

  @override
  String get homeLoadError => 'Impossible de charger les pays';

  @override
  String get homeTapRetry => 'Touchez pour réessayer';

  @override
  String get progressTitle => 'Progression du voyage';

  @override
  String progressCount(int v, int t) {
    return '$v / $t pays';
  }

  @override
  String get countryRate => 'Noter';

  @override
  String get countryVisitedPrompt => 'Visité ?';

  @override
  String get countryWishlist => 'Envies';

  @override
  String get countryWishlisted => 'Dans les envies';

  @override
  String countryMarkedVisited(String name) {
    return '$name marqué comme visité';
  }

  @override
  String countryUnmarkedVisited(String name) {
    return '$name n\'est plus marqué comme visité';
  }

  @override
  String countryAbout(String name) {
    return 'À propos de $name';
  }

  @override
  String get countryMajorCities => 'Villes principales';

  @override
  String get countryMapPreview => 'Aperçu de la carte';

  @override
  String rateDialogTitle(String name) {
    return 'Notez $name';
  }

  @override
  String get cityDiscover => 'À découvrir';

  @override
  String get catHistorical => 'Sites historiques';

  @override
  String get catArtLovers => 'Pour les amateurs d\'art';

  @override
  String get catAtmosphere => 'Ambiance et expériences';

  @override
  String get catHiddenGems => 'Pépites cachées';

  @override
  String get catCloseBy => 'À proximité';

  @override
  String get catMyPlaces => 'Mes lieux';

  @override
  String get categoryPlaces => 'Lieux';

  @override
  String get placeMarkVisited => 'Marquer comme visité';

  @override
  String get markShort => 'Marquer';

  @override
  String get detailsAbout => 'À propos de ce lieu';

  @override
  String get detailsLocation => 'Emplacement';

  @override
  String get detailsWebsiteError => 'Impossible d\'ouvrir le site web';

  @override
  String get detailsVisitedAdded => 'Marqué comme visité !';

  @override
  String get detailsVisitedRemoved => 'Statut visité retiré';

  @override
  String get detailsMarkAsVisited => 'Marquer comme visité';

  @override
  String get visitedLabel => 'Visité';

  @override
  String wishlistAdded(String name) {
    return '$name ajouté à la liste d\'envies';
  }

  @override
  String wishlistRemoved(String name) {
    return '$name retiré de la liste d\'envies';
  }

  @override
  String get tripsNewTrip => 'Nouveau voyage';

  @override
  String get tripsEmptyTitle => 'Aucun voyage pour l\'instant';

  @override
  String get tripsEmptyHint => 'Touchez « Nouveau voyage » pour commencer';

  @override
  String get tripsDraftHint =>
      'Brouillon IA prêt : touchez pour relire et enregistrer';

  @override
  String tripDurationDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n jours',
      one: '1 jour',
    );
    return '$_temp0';
  }

  @override
  String get tripStyleSolo => 'Solo';

  @override
  String get tripStyleGroup => 'En groupe';

  @override
  String get tripTypeHistorical => 'Historique';

  @override
  String get tripTypeArt => 'Art';

  @override
  String get tripTypeMixed => 'Mixte';

  @override
  String get tripFormTitleNew => 'Nouveau voyage';

  @override
  String get tripFormTitleEdit => 'Modifier le voyage';

  @override
  String get tripSectionDestination => 'Destination';

  @override
  String get tripSectionDates => 'Dates';

  @override
  String get tripSectionVacationType => 'Type de vacances';

  @override
  String get tripSectionTravelStyle => 'Style de voyage';

  @override
  String get tripSectionCompanions => 'Compagnons de voyage';

  @override
  String get tripChooseCountry => 'Choisissez un pays';

  @override
  String get tripChooseCities => 'Choisissez des villes (facultatif)';

  @override
  String get tripArrivalCity => 'Ville d\'arrivée';

  @override
  String get tripDepartureCity => 'Ville de départ';

  @override
  String get tripStartDate => 'Date de début';

  @override
  String get tripEndDate => 'Date de fin';

  @override
  String get tripSelect => 'Sélectionner';

  @override
  String tripDurationLabel(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Durée : $n jours',
      one: 'Durée : 1 jour',
    );
    return '$_temp0';
  }

  @override
  String get tripNoFriendsHint =>
      'Aucun ami pour l\'instant. Suivez d\'autres voyageurs (et laissez-les vous suivre) : ils apparaîtront ici comme compagnons.';

  @override
  String get tripCountryFirst => 'Choisissez d\'abord un pays';

  @override
  String get tripSheetCities => 'Choisissez des villes à visiter';

  @override
  String tripSelectedCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sélectionnées',
      one: '1 sélectionnée',
    );
    return '$_temp0';
  }

  @override
  String tripCitiesIn(String name) {
    return 'Villes dans $name';
  }

  @override
  String get tripNearbyCities => 'À proximité dans les pays voisins';

  @override
  String get tripSearchCities => 'Rechercher des villes';

  @override
  String get tripSheetDone => 'Terminé';

  @override
  String tripAddCities(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Ajouter $n villes',
      one: 'Ajouter 1 ville',
    );
    return '$_temp0';
  }

  @override
  String get tripGenerating => 'Génération...';

  @override
  String get tripSave => 'Enregistrer le voyage';

  @override
  String get tripGenerate => 'Générer le plan de voyage';

  @override
  String get tripDurationLocked =>
      'Impossible de modifier la durée ici. Créez un nouveau voyage pour changer les jours.';

  @override
  String get tripGenFailTitle => 'Impossible de générer le voyage';

  @override
  String get tripGenFailFallback =>
      'Une erreur s\'est produite lors de la génération.';

  @override
  String get tripGenBasic => 'Créer un itinéraire simple sans IA';

  @override
  String get planNotFound => 'Voyage introuvable';

  @override
  String get planItineraryTitle => 'Itinéraire jour par jour';

  @override
  String get planMapView => 'Voir la carte';

  @override
  String get planExporting => 'Exportation...';

  @override
  String get planExportPdf => 'Exporter le PDF';

  @override
  String get planRegenerate => 'Régénérer';

  @override
  String get planDiscard => 'Abandonner';

  @override
  String get planSaving => 'Enregistrement...';

  @override
  String get planDraftNote =>
      'Brouillon IA – pas encore enregistré dans vos voyages';

  @override
  String get planSaved => 'Voyage enregistré !';

  @override
  String get planSaveError => 'Impossible d\'enregistrer le voyage';

  @override
  String get planRegenerated => 'Nouvel itinéraire généré';

  @override
  String get planRegenError => 'Impossible de régénérer le voyage';

  @override
  String get planLoadError => 'Impossible de charger les détails';

  @override
  String get planPdfDone => 'PDF téléchargé';

  @override
  String get planPdfError => 'Impossible d\'exporter le PDF';

  @override
  String get planDiscardTitle => 'Abandonner le brouillon ?';

  @override
  String get planDiscardText => 'Ce brouillon IA sera supprimé.';

  @override
  String get planDeleteTitle => 'Supprimer le voyage';

  @override
  String get planDeleteText => 'Voulez-vous vraiment supprimer ce voyage ?';

  @override
  String planDayNumber(int n) {
    return 'JOUR $n';
  }

  @override
  String get planMorning => 'Matin';

  @override
  String get planAfternoon => 'Après-midi';

  @override
  String get planEvening => 'Soir';

  @override
  String get planActivityFallback => 'Activité';

  @override
  String get mapTitle => 'Carte du voyage';

  @override
  String mapDay(int n) {
    return 'Jour $n';
  }

  @override
  String get mapAllDays => 'Tous';

  @override
  String get mapViewDetails => 'Voir les détails';

  @override
  String mapCategory(int id) {
    return 'Catégorie $id';
  }

  @override
  String get mapPlaceError => 'Impossible de charger les détails du lieu';

  @override
  String get mapEmptyTitle => 'Aucun lieu sur la carte';

  @override
  String get mapEmptyText =>
      'Cet itinéraire ne contient aucun lieu avec coordonnées. Les itinéraires simples et les jours vides ne s\'affichent pas sur la carte.';

  @override
  String mapPlacesShown(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n lieux affichés',
      one: '1 lieu affiché',
    );
    return '$_temp0';
  }

  @override
  String get mapNoCoordsSuffix => '– sans coordonnées';

  @override
  String get journalOverviewTitle => 'Aperçu du journal';

  @override
  String get journalDownload => 'Télécharger le journal';

  @override
  String get journalPost => 'Publier sur le profil';

  @override
  String get journalNoCountries => 'Aucun pays chargé pour l\'instant';

  @override
  String get journalExploreMap => 'Explorer la carte';

  @override
  String journalCityCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n villes',
      one: '1 ville',
    );
    return '$_temp0';
  }

  @override
  String get journalNoneForCountry => 'Pas encore de journal pour ce pays.';

  @override
  String get journalChooseCountry => 'Choisissez un pays';

  @override
  String journalCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n journaux',
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
  String get journalUntitled => 'Journal sans titre';

  @override
  String get journalNoneToPost => 'Aucun journal à publier pour l\'instant.';

  @override
  String get journalPublic => 'Public';

  @override
  String get journalPrivate => 'Privé';

  @override
  String get journalRemoveShort => 'Retirer';

  @override
  String get journalRemoveTitle => 'Retirer du profil ?';

  @override
  String get journalPostTitle => 'Publier sur le profil ?';

  @override
  String get journalRemoveText =>
      'Votre journal deviendra privé et sera masqué de votre profil.';

  @override
  String get journalPostText =>
      'Votre journal sera visible sur votre profil. Les journaux publics sont visibles par tous ceux qui peuvent voir votre profil.';

  @override
  String get journalRemoved => 'Retiré du profil';

  @override
  String get journalPosted => 'Publié sur le profil';

  @override
  String journalVisibilityError(String error) {
    return 'Impossible de mettre à jour la visibilité : $error';
  }

  @override
  String get journalUnknown => 'Inconnu';

  @override
  String get journalNew => 'Nouveau journal';

  @override
  String get journalNewHint => 'Commencez à documenter votre voyage';

  @override
  String get journalEmpty => 'Aucune entrée pour l\'instant';

  @override
  String get journalStartWriting => 'Commencer à écrire';

  @override
  String get journalRemoveProfile => 'Retirer du profil';

  @override
  String get journalView => 'Voir';

  @override
  String editorSaveError(String error) {
    return 'Enregistrement impossible : $error';
  }

  @override
  String get editorSavedOffline =>
      'Enregistré sur cet appareil — sera synchronisé en ligne.';

  @override
  String get editorDraftSaved => 'Brouillon enregistré !';

  @override
  String get editorAddPicture => 'Ajouter une photo';

  @override
  String get editorFromGallery => 'Depuis la galerie';

  @override
  String get editorTakePhoto => 'Prendre une photo';

  @override
  String get editorPicOffline =>
      'Photo enregistrée sur cet appareil — sera synchronisée en ligne.';

  @override
  String get editorPicAdded => 'Photo ajoutée !';

  @override
  String editorPicError(String error) {
    return 'Impossible d\'ajouter la photo : $error';
  }

  @override
  String get editorTicketOffline =>
      'Billet enregistré sur cet appareil. Sera synchronisé en ligne.';

  @override
  String get editorTicketAdded => 'Billet ajouté à votre journal !';

  @override
  String get editorClosedError => 'L\'éditeur de journal a été fermé.';

  @override
  String get editorPageGoneError => 'La page n\'est plus disponible.';

  @override
  String editorTicketError(String error) {
    return 'Échec du scan du billet : $error';
  }

  @override
  String get editorAddSticker => 'Ajouter un autocollant';

  @override
  String get editorStickerAirplane => 'Avion';

  @override
  String get editorStickerTicket => 'Billet';

  @override
  String get editorStickerCamera => 'Appareil photo';

  @override
  String get editorStickerArt => 'Art';

  @override
  String get editorStickerCoffee => 'Café';

  @override
  String get editorStickerBuilding => 'Bâtiment';

  @override
  String get editorStickerTheater => 'Théâtre';

  @override
  String get editorStickerWine => 'Vin';

  @override
  String get editorEditText => 'Modifier le texte';

  @override
  String get editorDuplicate => 'Dupliquer';

  @override
  String get editorBringForward => 'Avancer';

  @override
  String get editorSendBackward => 'Reculer';

  @override
  String get editorTextColor => 'Couleur du texte';

  @override
  String get editorFontFamily => 'Police';

  @override
  String get editorDupPage => 'Dupliquer la page';

  @override
  String get editorMoveLeft => 'Déplacer à gauche';

  @override
  String get editorMoveRight => 'Déplacer à droite';

  @override
  String get editorDeletePage => 'Supprimer la page';

  @override
  String get editorPageBg => 'Arrière-plan de page';

  @override
  String get editorBgCream => 'Crème';

  @override
  String get editorBgPeach => 'Pêche';

  @override
  String get editorBgMint => 'Menthe';

  @override
  String get editorBgSky => 'Ciel';

  @override
  String get editorBgLavender => 'Lavande';

  @override
  String get editorBgLemon => 'Citron';

  @override
  String get editorMinPage => 'Un journal doit contenir au moins une page.';

  @override
  String get editorToolText => 'Texte';

  @override
  String get editorToolPicture => 'Photo';

  @override
  String get editorToolTicket => 'Billet';

  @override
  String get editorToolSticker => 'Autocollant';

  @override
  String get editorAddPage => 'Ajouter une page';

  @override
  String get editorFormatTooltip => 'Format';

  @override
  String get editorRotateLeft => 'Pivoter à gauche';

  @override
  String get editorRotateRight => 'Pivoter à droite';

  @override
  String get editorSmaller => 'Plus petit';

  @override
  String get editorBigger => 'Plus grand';

  @override
  String get editorRetakePhoto => 'Reprendre la photo';

  @override
  String get editorCropTicket => 'Recadrer le billet';

  @override
  String get journalNotFound => 'Introuvable';

  @override
  String get journalNoPages => 'Aucune page';

  @override
  String journalPageTitle(int n) {
    return 'Page $n';
  }

  @override
  String get journalPdfError => 'Impossible de télécharger le PDF';

  @override
  String get wishEmpty => 'Aucune destination enregistrée';

  @override
  String get wishEmptyHint =>
      'Touchez le cœur sur les lieux ou les pays pour les enregistrer';

  @override
  String get wishCountryBadge => 'Pays';

  @override
  String get wishRemoveTitle => 'Retirer de la liste d\'envies';

  @override
  String wishRemoveText(String name) {
    return 'Retirer $name de votre liste d\'envies ?';
  }

  @override
  String get profileTagline => 'Passionné de voyage';

  @override
  String get profileStatPlaces => 'Lieux';

  @override
  String get profileStatTrips => 'Voyages';

  @override
  String get profileStatFollowers => 'Abonnés';

  @override
  String get profileStatFollowing => 'Abonnements';

  @override
  String get profileFindTravellers => 'Trouvez des voyageurs à suivre';

  @override
  String get profilePhotos => 'Photos de voyage';

  @override
  String get profileJournals => 'Journaux';

  @override
  String get profileAdd => 'Ajouter';

  @override
  String get profileEdit => 'Modifier le profil';

  @override
  String get profileFirstName => 'Prénom';

  @override
  String get profileLastName => 'Nom';

  @override
  String get profileBio => 'Bio';

  @override
  String get profilePhotoDone => 'Photo téléversée';

  @override
  String get profilePhotoError => 'Impossible de téléverser la photo';

  @override
  String get profilePhotoDeleteError => 'Impossible de supprimer la photo';

  @override
  String get profileSaved => 'Profil mis à jour';

  @override
  String get profileDeletePhotoTitle => 'Supprimer la photo';

  @override
  String get profileDeletePhotoText => 'Retirer cette photo de votre profil ?';

  @override
  String get searchTitle => 'Trouver des voyageurs';

  @override
  String get searchHint => 'Rechercher par pseudo ou nom';

  @override
  String get searchError => 'Échec de la recherche';

  @override
  String get searchPrompt => 'Tapez pour trouver d\'autres voyageurs';

  @override
  String get searchEmpty => 'Aucun voyageur trouvé';

  @override
  String get userFollow => 'Suivre';

  @override
  String get userUnfollow => 'Ne plus suivre';

  @override
  String userPrivateText(String username) {
    return 'Ce profil est privé. Suivez $username pour voir ses photos de voyage.';
  }

  @override
  String get userFollowError => 'Impossible de mettre à jour le suivi';

  @override
  String get journalDeleteAction => 'Supprimer le journal';

  @override
  String get journalDeleteTitle => 'Supprimer le journal ?';

  @override
  String journalDeleteText(String name) {
    return 'Cela supprimera définitivement « $name ». Cette action est irréversible.';
  }

  @override
  String get journalDeleted => 'Journal supprimé';

  @override
  String get journalDeleteError => 'Impossible de supprimer le journal';
}
