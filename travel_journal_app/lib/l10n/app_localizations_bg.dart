// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bulgarian (`bg`).
class AppLocalizationsBg extends AppLocalizations {
  AppLocalizationsBg([String locale = 'bg']) : super(locale);

  @override
  String get navHome => 'Начало';

  @override
  String get navTrips => 'Пътувания';

  @override
  String get navJournal => 'Дневник';

  @override
  String get navWishlist => 'Желания';

  @override
  String get navProfile => 'Профил';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsAccount => 'Акаунт';

  @override
  String get settingsMyTrips => 'Моите пътувания';

  @override
  String get settingsMyTripsSubtitle =>
      'Преглеждайте и управлявайте пътуванията си';

  @override
  String get settingsMyWishlist => 'Моят списък с желания';

  @override
  String get settingsMyWishlistSubtitle => 'Места, които искате да посетите';

  @override
  String get settingsPreferences => 'Предпочитания';

  @override
  String get settingsNotifications => 'Известия';

  @override
  String get settingsNotificationsSubtitle =>
      'Получавайте напомняния и новини за пътувания';

  @override
  String get settingsOffline => 'Офлайн достъп';

  @override
  String get settingsOfflineEnabled => 'Офлайн достъпът е включен';

  @override
  String get settingsOfflineDisabled => 'Офлайн достъпът е изключен';

  @override
  String get settingsProfileStatus => 'Статус на профила';

  @override
  String get settingsProfilePrivate =>
      'Частен – само последователите виждат активността ви';

  @override
  String get settingsProfilePublic => 'Публичен – всеки вижда активността ви';

  @override
  String get settingsGeneral => 'Общи';

  @override
  String get settingsLanguage => 'Език';

  @override
  String get settingsSelectLanguage => 'Изберете език';

  @override
  String get settingsTheme => 'Тема';

  @override
  String get settingsThemeSystem => 'Системна';

  @override
  String get settingsThemeLight => 'Светла';

  @override
  String get settingsThemeDark => 'Тъмна';

  @override
  String get settingsSelectTheme => 'Изберете тема';

  @override
  String get settingsServerAddress => 'Адрес на сървъра';

  @override
  String settingsServerDefault(String url) {
    return 'По подразбиране ($url)';
  }

  @override
  String get settingsServerDialogText =>
      'Къде работи сървърът. Примери:\n• Домашен Wi-Fi:  http://192.168.1.50:3001\n• Отвсякъде:    https://your-tunnel-url\n\nОставете празно, за да използвате сървъра по подразбиране.';

  @override
  String get settingsServerUpdated => 'Адресът на сървъра е обновен';

  @override
  String get settingsStorage => 'Хранилище';

  @override
  String get settingsStorageSubtitle => 'Управление на изтегленото съдържание';

  @override
  String get settingsDangerZone => 'Опасна зона';

  @override
  String get settingsDeleteAccount => 'Изтриване на акаунта';

  @override
  String get settingsDeleteAccountSubtitle =>
      'Трайно изтриване на акаунта и всички данни';

  @override
  String get settingsDeleteAccountConfirmTitle => 'Изтриване на акаунта?';

  @override
  String get settingsDeleteAccountConfirmText =>
      'Това действие не може да бъде отменено. Всичките ви данни ще бъдат изтрити завинаги.';

  @override
  String get settingsDeleteAccountSoon =>
      'Скоро ще е налична опция за изтриване на акаунта!';

  @override
  String get settingsDelete => 'Изтрий';

  @override
  String get settingsLogout => 'Изход';

  @override
  String get settingsLogoutConfirmTitle => 'Изход?';

  @override
  String get settingsLogoutConfirmText =>
      'Сигурни ли сте, че искате да излезете?';

  @override
  String get commonCancel => 'Отказ';

  @override
  String get commonSave => 'Запази';

  @override
  String get commonClose => 'Затвори';

  @override
  String get commonRetry => 'Опитай отново';

  @override
  String get commonLoading => 'Зареждане...';

  @override
  String get commonError => 'Нещо се обърка';

  @override
  String get commonOffline => 'Няма интернет връзка';

  @override
  String get commonOk => 'OK';

  @override
  String get commonYes => 'Да';

  @override
  String get commonNo => 'Не';

  @override
  String get commonEdit => 'Редактирай';

  @override
  String get authWelcomeBack => 'Добре дошли отново';

  @override
  String get authSignInSubtitle => 'Влезте, за да продължите пътуването си';

  @override
  String get authEmail => 'Имейл';

  @override
  String get authPassword => 'Парола';

  @override
  String get authForgotPassword => 'Забравена парола?';

  @override
  String get authLogin => 'Вход';

  @override
  String get authNoAccount => 'Нямате акаунт? ';

  @override
  String get authSignUp => 'Регистрация';

  @override
  String get authCreateAccount => 'Създаване на акаунт';

  @override
  String get authCreateSubtitle => 'Започнете своя дневник за пътувания';

  @override
  String get authFullName => 'Пълно име';

  @override
  String get authHaveAccount => 'Вече имате акаунт? ';

  @override
  String get authEnterValid => 'Моля, въведете валидни данни';

  @override
  String get authFillRequired => 'Моля, попълнете всички задължителни полета';

  @override
  String get authInvalid => 'Невалидни данни';

  @override
  String get authRegisterFailed => 'Регистрацията не бе успешна';

  @override
  String get authSessionFailed => 'Сесията не можа да стартира. Опитайте отново.';

  @override
  String authPartialFail(String failed) {
    return 'Някои данни не се заредиха ($failed). Дръпнете, за да опитате отново.';
  }

  @override
  String get splashTagline => 'Дневник за пътувания';

  @override
  String get splashGetStarted => 'Започнете';

  @override
  String get authGenderMale => 'Мъж';

  @override
  String get authGenderFemale => 'Жена';

  @override
  String get authGenderNonBinary => 'Небинарен';

  @override
  String get authGenderPrefer => 'Предпочитам да не казвам';
}
