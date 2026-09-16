// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get navHome => 'Inicio';

  @override
  String get navTrips => 'Viajes';

  @override
  String get navJournal => 'Diario';

  @override
  String get navWishlist => 'Deseos';

  @override
  String get navProfile => 'Perfil';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsAccount => 'Cuenta';

  @override
  String get settingsMyTrips => 'Mis viajes';

  @override
  String get settingsMyTripsSubtitle => 'Ver y gestionar tus viajes';

  @override
  String get settingsMyWishlist => 'Mi lista de deseos';

  @override
  String get settingsMyWishlistSubtitle => 'Lugares que quieres visitar';

  @override
  String get settingsPreferences => 'Preferencias';

  @override
  String get settingsNotifications => 'Notificaciones';

  @override
  String get settingsNotificationsSubtitle =>
      'Recibe recordatorios y novedades de viajes';

  @override
  String get settingsOffline => 'Disponible sin conexión';

  @override
  String get settingsOfflineEnabled => 'Acceso sin conexión activado';

  @override
  String get settingsOfflineDisabled => 'Acceso sin conexión desactivado';

  @override
  String get settingsProfileStatus => 'Estado del perfil';

  @override
  String get settingsProfilePrivate =>
      'Privado: solo tus seguidores ven tu actividad';

  @override
  String get settingsProfilePublic =>
      'Público: cualquiera puede ver tu actividad';

  @override
  String get settingsGeneral => 'General';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsSelectLanguage => 'Seleccionar idioma';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeSystem => 'Sistema';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Oscuro';

  @override
  String get settingsSelectTheme => 'Seleccionar tema';

  @override
  String get settingsServerAddress => 'Dirección del servidor';

  @override
  String settingsServerDefault(String url) {
    return 'Predeterminado ($url)';
  }

  @override
  String get settingsServerDialogText =>
      'Dónde se ejecuta el servidor. Ejemplos:\n• Wi-Fi de casa:  http://192.168.1.50:3001\n• Desde cualquier lugar:    https://your-tunnel-url\n\nDéjalo vacío para usar el servidor predeterminado.';

  @override
  String get settingsServerUpdated => 'Dirección del servidor actualizada';

  @override
  String get settingsStorage => 'Almacenamiento';

  @override
  String get settingsStorageSubtitle => 'Gestionar el contenido descargado';

  @override
  String get settingsDangerZone => 'Zona de peligro';

  @override
  String get settingsDeleteAccount => 'Eliminar cuenta';

  @override
  String get settingsDeleteAccountSubtitle =>
      'Eliminar permanentemente tu cuenta y todos tus datos';

  @override
  String get settingsDeleteAccountConfirmTitle => '¿Eliminar cuenta?';

  @override
  String get settingsDeleteAccountConfirmText =>
      'Esta acción no se puede deshacer. Todos tus datos se eliminarán permanentemente.';

  @override
  String get settingsDeleteAccountSoon =>
      '¡La eliminación de cuenta estará disponible pronto!';

  @override
  String get settingsDelete => 'Eliminar';

  @override
  String get settingsLogout => 'Cerrar sesión';

  @override
  String get settingsLogoutConfirmTitle => '¿Cerrar sesión?';

  @override
  String get settingsLogoutConfirmText => '¿Seguro que quieres cerrar sesión?';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get commonRetry => 'Reintentar';

  @override
  String get commonLoading => 'Cargando...';

  @override
  String get commonError => 'Algo salió mal';

  @override
  String get commonOffline => 'Sin conexión a internet';

  @override
  String get commonOk => 'Aceptar';

  @override
  String get commonYes => 'Sí';

  @override
  String get commonNo => 'No';

  @override
  String get commonEdit => 'Editar';

  @override
  String get authWelcomeBack => 'Bienvenido de nuevo';

  @override
  String get authSignInSubtitle => 'Inicia sesión para continuar tu viaje';

  @override
  String get authEmail => 'Correo electrónico';

  @override
  String get authPassword => 'Contraseña';

  @override
  String get authForgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get authLogin => 'Iniciar sesión';

  @override
  String get authNoAccount => '¿No tienes una cuenta? ';

  @override
  String get authSignUp => 'Regístrate';

  @override
  String get authCreateAccount => 'Crear cuenta';

  @override
  String get authCreateSubtitle => 'Empieza tu diario de viaje';

  @override
  String get authFullName => 'Nombre completo';

  @override
  String get authHaveAccount => '¿Ya tienes una cuenta? ';

  @override
  String get authEnterValid => 'Introduce credenciales válidas';

  @override
  String get authFillRequired => 'Completa todos los campos obligatorios';

  @override
  String get authInvalid => 'Credenciales no válidas';

  @override
  String get authRegisterFailed => 'Registro fallido';

  @override
  String get authSessionFailed =>
      'No se pudo iniciar la sesión. Inténtalo de nuevo.';

  @override
  String authPartialFail(String failed) {
    return 'Algunos datos no se cargaron ($failed). Desliza para reintentar.';
  }

  @override
  String get splashTagline => 'Diario de viaje';

  @override
  String get splashGetStarted => 'Empezar';

  @override
  String get authGenderMale => 'Masculino';

  @override
  String get authGenderFemale => 'Femenino';

  @override
  String get authGenderNonBinary => 'No binario';

  @override
  String get authGenderPrefer => 'Prefiero no decirlo';

  @override
  String get homeSearchHint => 'Buscar país o ciudad...';

  @override
  String get homeCountriesTitle => 'Países';

  @override
  String homeCountriesCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n países',
      one: '1 país',
    );
    return '$_temp0';
  }

  @override
  String get homeLoadError => 'No se pudieron cargar los países';

  @override
  String get homeTapRetry => 'Toca para reintentar';

  @override
  String get progressTitle => 'Progreso del viaje';

  @override
  String progressCount(int v, int t) {
    return '$v / $t países';
  }

  @override
  String get countryRate => 'Valorar';

  @override
  String get countryVisitedPrompt => '¿Visitado?';

  @override
  String get countryWishlist => 'Deseos';

  @override
  String get countryWishlisted => 'En deseos';

  @override
  String countryMarkedVisited(String name) {
    return '$name marcado como visitado';
  }

  @override
  String countryUnmarkedVisited(String name) {
    return '$name ya no está marcado como visitado';
  }

  @override
  String countryAbout(String name) {
    return 'Sobre $name';
  }

  @override
  String get countryMajorCities => 'Ciudades principales';

  @override
  String get countryMapPreview => 'Vista del mapa';

  @override
  String rateDialogTitle(String name) {
    return 'Valora $name';
  }

  @override
  String get cityDiscover => 'Qué descubrir';

  @override
  String get catHistorical => 'Lugares históricos';

  @override
  String get catArtLovers => 'Para los amantes del arte';

  @override
  String get catAtmosphere => 'Ambiente y experiencias';

  @override
  String get catHiddenGems => 'Joyas ocultas';

  @override
  String get catCloseBy => 'Cerca';

  @override
  String get catMyPlaces => 'Mis lugares';

  @override
  String get categoryPlaces => 'Lugares';

  @override
  String get placeMarkVisited => 'Marcar como visitado';

  @override
  String get markShort => 'Marcar';

  @override
  String get detailsAbout => 'Sobre este lugar';

  @override
  String get detailsLocation => 'Ubicación';

  @override
  String get detailsWebsiteError => 'No se pudo abrir el sitio web';

  @override
  String get detailsVisitedAdded => '¡Marcado como visitado!';

  @override
  String get detailsVisitedRemoved => 'Estado de visitado eliminado';

  @override
  String get detailsMarkAsVisited => 'Marcar como visitado';

  @override
  String get visitedLabel => 'Visitado';

  @override
  String wishlistAdded(String name) {
    return '$name añadido a la lista de deseos';
  }

  @override
  String wishlistRemoved(String name) {
    return '$name eliminado de la lista de deseos';
  }

  @override
  String get tripsNewTrip => 'Nuevo viaje';

  @override
  String get tripsEmptyTitle => 'Aún no hay viajes';

  @override
  String get tripsEmptyHint => 'Toca \"Nuevo viaje\" para empezar a planificar';

  @override
  String get tripsDraftHint =>
      'Borrador de IA listo: toca para revisar y guardar';

  @override
  String tripDurationDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n días',
      one: '1 día',
    );
    return '$_temp0';
  }

  @override
  String get tripStyleSolo => 'Solo';

  @override
  String get tripStyleGroup => 'En grupo';

  @override
  String get tripTypeHistorical => 'Histórico';

  @override
  String get tripTypeArt => 'Arte';

  @override
  String get tripTypeMixed => 'Mixto';

  @override
  String get tripFormTitleNew => 'Nuevo viaje';

  @override
  String get tripFormTitleEdit => 'Editar viaje';

  @override
  String get tripSectionDestination => 'Destino';

  @override
  String get tripSectionDates => 'Fechas';

  @override
  String get tripSectionVacationType => 'Tipo de vacaciones';

  @override
  String get tripSectionTravelStyle => 'Estilo de viaje';

  @override
  String get tripSectionCompanions => 'Compañeros de viaje';

  @override
  String get tripChooseCountry => 'Elige un país';

  @override
  String get tripChooseCities => 'Elige ciudades (opcional)';

  @override
  String get tripArrivalCity => 'Ciudad de llegada';

  @override
  String get tripDepartureCity => 'Ciudad de partida';

  @override
  String get tripStartDate => 'Fecha de inicio';

  @override
  String get tripEndDate => 'Fecha de fin';

  @override
  String get tripSelect => 'Seleccionar';

  @override
  String tripDurationLabel(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Duración: $n días',
      one: 'Duración: 1 día',
    );
    return '$_temp0';
  }

  @override
  String get tripNoFriendsHint =>
      'Aún no hay amigos. Sigue a otros viajeros (y deja que te sigan) y aparecerán aquí como compañeros.';

  @override
  String get tripCountryFirst => 'Elige primero un país';

  @override
  String get tripSheetCities => 'Elige ciudades para visitar';

  @override
  String tripSelectedCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n seleccionados',
      one: '1 seleccionado',
    );
    return '$_temp0';
  }

  @override
  String tripCitiesIn(String name) {
    return 'Ciudades en $name';
  }

  @override
  String get tripNearbyCities => 'Cerca, en países vecinos';

  @override
  String get tripSearchCities => 'Buscar ciudades';

  @override
  String get tripSheetDone => 'Listo';

  @override
  String tripAddCities(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Añadir $n ciudades',
      one: 'Añadir 1 ciudad',
    );
    return '$_temp0';
  }

  @override
  String get tripGenerating => 'Generando...';

  @override
  String get tripSave => 'Guardar viaje';

  @override
  String get tripGenerate => 'Generar plan de viaje';

  @override
  String get tripDurationLocked =>
      'No puedes cambiar la duración aquí. Crea un nuevo viaje para cambiar los días.';

  @override
  String get tripGenFailTitle => 'No se pudo generar el viaje';

  @override
  String get tripGenFailFallback => 'Algo salió mal al generar tu viaje.';

  @override
  String get tripGenBasic => 'Crear itinerario básico sin IA';

  @override
  String get planNotFound => 'Viaje no encontrado';

  @override
  String get planItineraryTitle => 'Itinerario día a día';

  @override
  String get planMapView => 'Ver mapa';

  @override
  String get planExporting => 'Exportando...';

  @override
  String get planExportPdf => 'Exportar PDF';

  @override
  String get planRegenerate => 'Regenerar';

  @override
  String get planDiscard => 'Descartar';

  @override
  String get planSaving => 'Guardando...';

  @override
  String get planDraftNote => 'Borrador de IA: aún no guardado en tus viajes';

  @override
  String get planSaved => '¡Viaje guardado!';

  @override
  String get planSaveError => 'No se pudo guardar el viaje';

  @override
  String get planRegenerated => 'Nuevo itinerario generado';

  @override
  String get planRegenError => 'No se pudo regenerar el viaje';

  @override
  String get planLoadError => 'No se pudieron cargar los detalles';

  @override
  String get planPdfDone => 'PDF descargado';

  @override
  String get planPdfError => 'No se pudo exportar el PDF';

  @override
  String get planDiscardTitle => '¿Descartar borrador?';

  @override
  String get planDiscardText => 'Este borrador de IA se eliminará.';

  @override
  String get planDeleteTitle => 'Eliminar viaje';

  @override
  String get planDeleteText => '¿Seguro que quieres eliminar este viaje?';

  @override
  String planDayNumber(int n) {
    return 'DÍA $n';
  }

  @override
  String get planMorning => 'Mañana';

  @override
  String get planAfternoon => 'Tarde';

  @override
  String get planEvening => 'Noche';

  @override
  String get planActivityFallback => 'Actividad';

  @override
  String get mapTitle => 'Mapa del viaje';

  @override
  String mapDay(int n) {
    return 'Día $n';
  }

  @override
  String get mapAllDays => 'Todos';

  @override
  String get mapViewDetails => 'Ver detalles';

  @override
  String mapCategory(int id) {
    return 'Categoría $id';
  }

  @override
  String get mapPlaceError => 'No se pudieron cargar los detalles del lugar';

  @override
  String get mapEmptyTitle => 'Sin lugares en el mapa';

  @override
  String get mapEmptyText =>
      'Este itinerario no contiene lugares con coordenadas. Los itinerarios básicos y los días vacíos no se muestran en el mapa.';

  @override
  String mapPlacesShown(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n lugares mostrados',
      one: '1 lugar mostrado',
    );
    return '$_temp0';
  }

  @override
  String get mapNoCoordsSuffix => '– sin coordenadas';

  @override
  String get journalOverviewTitle => 'Resumen del diario';

  @override
  String get journalDownload => 'Descargar diario';

  @override
  String get journalPost => 'Publicar en el perfil';

  @override
  String get journalNoCountries => 'Aún no hay países cargados';

  @override
  String get journalExploreMap => 'Explorar el mapa';

  @override
  String journalCityCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ciudades',
      one: '1 ciudad',
    );
    return '$_temp0';
  }

  @override
  String get journalNoneForCountry => 'Aún no hay diario para este país.';

  @override
  String get journalChooseCountry => 'Elige un país';

  @override
  String journalCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n diarios',
      one: '1 diario',
    );
    return '$_temp0';
  }

  @override
  String journalPageCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n páginas',
      one: '1 página',
    );
    return '$_temp0';
  }

  @override
  String get journalUntitled => 'Diario sin título';

  @override
  String get journalNoneToPost => 'Aún no hay diarios para publicar.';

  @override
  String get journalPublic => 'Público';

  @override
  String get journalPrivate => 'Privado';

  @override
  String get journalRemoveShort => 'Quitar';

  @override
  String get journalRemoveTitle => '¿Quitar del perfil?';

  @override
  String get journalPostTitle => '¿Publicar en el perfil?';

  @override
  String get journalRemoveText =>
      'Esto hará tu diario privado y lo ocultará de tu perfil.';

  @override
  String get journalPostText =>
      'Esto hará tu diario visible en tu perfil. Los diarios públicos son visibles para cualquiera que pueda ver tu perfil.';

  @override
  String get journalRemoved => 'Quitado del perfil';

  @override
  String get journalPosted => 'Publicado en el perfil';

  @override
  String journalVisibilityError(String error) {
    return 'No se pudo actualizar la visibilidad: $error';
  }

  @override
  String get journalUnknown => 'Desconocido';

  @override
  String get journalNew => 'Nuevo diario';

  @override
  String get journalNewHint => 'Empieza a documentar tu viaje';

  @override
  String get journalEmpty => 'Aún no hay entradas en el diario';

  @override
  String get journalStartWriting => 'Empezar a escribir';

  @override
  String get journalRemoveProfile => 'Quitar del perfil';

  @override
  String get journalView => 'Ver';

  @override
  String editorSaveError(String error) {
    return 'No se pudo guardar: $error';
  }

  @override
  String get editorSavedOffline =>
      'Guardado en este dispositivo; se sincronizará cuando estés en línea.';

  @override
  String get editorDraftSaved => '¡Borrador guardado!';

  @override
  String get editorAddPicture => 'Añadir una foto';

  @override
  String get editorFromGallery => 'Desde la galería';

  @override
  String get editorTakePhoto => 'Hacer una foto';

  @override
  String get editorPicOffline =>
      'Foto guardada en este dispositivo; se sincronizará cuando estés en línea.';

  @override
  String get editorPicAdded => '¡Foto añadida!';

  @override
  String editorPicError(String error) {
    return 'No se pudo añadir la foto: $error';
  }

  @override
  String get editorTicketOffline =>
      'Billete guardado en este dispositivo. Se sincronizará cuando estés en línea.';

  @override
  String get editorTicketAdded => '¡Billete añadido a tu diario!';

  @override
  String get editorClosedError => 'El editor del diario se cerró.';

  @override
  String get editorPageGoneError => 'La página ya no está disponible.';

  @override
  String editorTicketError(String error) {
    return 'Falló el escaneo del billete: $error';
  }

  @override
  String get editorAddSticker => 'Añadir pegatina';

  @override
  String get editorStickerAirplane => 'Avión';

  @override
  String get editorStickerTicket => 'Billete';

  @override
  String get editorStickerCamera => 'Cámara';

  @override
  String get editorStickerArt => 'Arte';

  @override
  String get editorStickerCoffee => 'Café';

  @override
  String get editorStickerBuilding => 'Edificio';

  @override
  String get editorStickerTheater => 'Teatro';

  @override
  String get editorStickerWine => 'Vino';

  @override
  String get editorEditText => 'Editar texto';

  @override
  String get editorDuplicate => 'Duplicar';

  @override
  String get editorBringForward => 'Traer adelante';

  @override
  String get editorSendBackward => 'Enviar atrás';

  @override
  String get editorTextColor => 'Color del texto';

  @override
  String get editorFontFamily => 'Fuente';

  @override
  String get editorDupPage => 'Duplicar página';

  @override
  String get editorMoveLeft => 'Mover a la izquierda';

  @override
  String get editorMoveRight => 'Mover a la derecha';

  @override
  String get editorDeletePage => 'Eliminar página';

  @override
  String get editorPageBg => 'Fondo de página';

  @override
  String get editorBgCream => 'Crema';

  @override
  String get editorBgPeach => 'Melocotón';

  @override
  String get editorBgMint => 'Menta';

  @override
  String get editorBgSky => 'Cielo';

  @override
  String get editorBgLavender => 'Lavanda';

  @override
  String get editorBgLemon => 'Limón';

  @override
  String get editorMinPage => 'Un diario necesita al menos una página.';

  @override
  String get editorToolText => 'Texto';

  @override
  String get editorToolPicture => 'Foto';

  @override
  String get editorToolTicket => 'Billete';

  @override
  String get editorToolSticker => 'Pegatina';

  @override
  String get editorAddPage => 'Añadir página';

  @override
  String get editorFormatTooltip => 'Formato';

  @override
  String get editorRotateLeft => 'Girar a la izquierda';

  @override
  String get editorRotateRight => 'Girar a la derecha';

  @override
  String get editorSmaller => 'Más pequeño';

  @override
  String get editorBigger => 'Más grande';

  @override
  String get editorRetakePhoto => 'Repetir foto';

  @override
  String get editorCropTicket => 'Recortar billete';

  @override
  String get journalNotFound => 'No encontrado';

  @override
  String get journalNoPages => 'Sin páginas';

  @override
  String journalPageTitle(int n) {
    return 'Página $n';
  }

  @override
  String get journalPdfError => 'No se pudo descargar el PDF';
}
