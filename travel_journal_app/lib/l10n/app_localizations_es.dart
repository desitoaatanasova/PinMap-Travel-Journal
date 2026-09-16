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
}
