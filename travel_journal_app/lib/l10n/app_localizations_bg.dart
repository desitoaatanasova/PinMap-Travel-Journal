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
  String get authSessionFailed =>
      'Сесията не можа да стартира. Опитайте отново.';

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

  @override
  String get homeSearchHint => 'Търси държава или град...';

  @override
  String get homeCountriesTitle => 'Държави';

  @override
  String homeCountriesCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n държави',
      one: '1 държава',
    );
    return '$_temp0';
  }

  @override
  String get homeLoadError => 'Държавите не можаха да се заредят';

  @override
  String get homeTapRetry => 'Докоснете, за да опитате отново';

  @override
  String get progressTitle => 'Прогрес на пътуванията';

  @override
  String progressCount(int v, int t) {
    return '$v / $t държави';
  }

  @override
  String get countryRate => 'Оцени';

  @override
  String get countryVisitedPrompt => 'Посетено?';

  @override
  String get countryWishlist => 'Желания';

  @override
  String get countryWishlisted => 'В желанията';

  @override
  String countryMarkedVisited(String name) {
    return 'Посетихте $name';
  }

  @override
  String countryUnmarkedVisited(String name) {
    return 'Премахнахте $name от посетените';
  }

  @override
  String countryAbout(String name) {
    return 'За $name';
  }

  @override
  String get countryMajorCities => 'Големи градове';

  @override
  String get countryMapPreview => 'Преглед на картата';

  @override
  String rateDialogTitle(String name) {
    return 'Оценете $name';
  }

  @override
  String get cityDiscover => 'Какво да откриете';

  @override
  String get catHistorical => 'Исторически забележителности';

  @override
  String get catArtLovers => 'За любителите на изкуството';

  @override
  String get catAtmosphere => 'Атмосфера и изживявания';

  @override
  String get catHiddenGems => 'Скрити съкровища';

  @override
  String get catCloseBy => 'Наблизо';

  @override
  String get catMyPlaces => 'Моите места';

  @override
  String get categoryPlaces => 'Места';

  @override
  String get placeMarkVisited => 'Отбележи като посетено';

  @override
  String get markShort => 'Отбележи';

  @override
  String get detailsAbout => 'За това място';

  @override
  String get detailsLocation => 'Местоположение';

  @override
  String get detailsWebsiteError => 'Уебсайтът не можа да се отвори';

  @override
  String get detailsVisitedAdded => 'Отбелязано като посетено!';

  @override
  String get detailsVisitedRemoved => 'Статусът „посетено“ е премахнат';

  @override
  String get detailsMarkAsVisited => 'Отбележи като посетено';

  @override
  String get visitedLabel => 'Посетено';

  @override
  String wishlistAdded(String name) {
    return 'Добавихте $name в желанията';
  }

  @override
  String wishlistRemoved(String name) {
    return 'Премахнахте $name от желанията';
  }

  @override
  String get tripsNewTrip => 'Ново пътуване';

  @override
  String get tripsEmptyTitle => 'Все още няма пътувания';

  @override
  String get tripsEmptyHint =>
      'Докоснете \"Ново пътуване\", за да започнете планиране';

  @override
  String get tripsDraftHint =>
      'AI черновата е готова — докоснете, за да прегледате и запазите';

  @override
  String tripDurationDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n дни',
      one: '1 ден',
    );
    return '$_temp0';
  }

  @override
  String get tripStyleSolo => 'Сам';

  @override
  String get tripStyleGroup => 'Група';

  @override
  String get tripTypeHistorical => 'Историческо';

  @override
  String get tripTypeArt => 'Изкуство';

  @override
  String get tripTypeMixed => 'Смесено';

  @override
  String get tripFormTitleNew => 'Ново пътуване';

  @override
  String get tripFormTitleEdit => 'Редактиране на пътуване';

  @override
  String get tripSectionDestination => 'Дестинация';

  @override
  String get tripSectionDates => 'Дати';

  @override
  String get tripSectionVacationType => 'Вид почивка';

  @override
  String get tripSectionTravelStyle => 'Стил на пътуване';

  @override
  String get tripSectionCompanions => 'Спътници';

  @override
  String get tripChooseCountry => 'Изберете държава';

  @override
  String get tripChooseCities => 'Изберете градове за посещение (по избор)';

  @override
  String get tripArrivalCity => 'Град на пристигане';

  @override
  String get tripDepartureCity => 'Град на заминаване';

  @override
  String get tripStartDate => 'Начална дата';

  @override
  String get tripEndDate => 'Крайна дата';

  @override
  String get tripSelect => 'Изберете';

  @override
  String tripDurationLabel(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Продължителност: $n дни',
      one: 'Продължителност: 1 ден',
    );
    return '$_temp0';
  }

  @override
  String get tripNoFriendsHint =>
      'Все още няма намерени приятели. Последвайте други пътешественици (и ги оставете да ви последват) и те ще се появят тук като спътници.';

  @override
  String get tripCountryFirst => 'Първо изберете държава';

  @override
  String get tripSheetCities => 'Изберете градове за посещение';

  @override
  String tripSelectedCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n избрани',
      one: '1 избран',
    );
    return '$_temp0';
  }

  @override
  String tripCitiesIn(String name) {
    return 'Градове в $name';
  }

  @override
  String get tripNearbyCities => 'Наблизо в съседни държави';

  @override
  String get tripSearchCities => 'Търси градове';

  @override
  String get tripSheetDone => 'Готово';

  @override
  String tripAddCities(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Добави $n града',
      one: 'Добави 1 град',
    );
    return '$_temp0';
  }

  @override
  String get tripGenerating => 'Генериране...';

  @override
  String get tripSave => 'Запази пътуването';

  @override
  String get tripGenerate => 'Генерирай план на пътуването';

  @override
  String get tripDurationLocked =>
      'Продължителността не може да се променя тук. Създайте ново пътуване, за да промените дните.';

  @override
  String get tripGenFailTitle => 'Пътуването не можа да се генерира';

  @override
  String get tripGenFailFallback =>
      'Нещо се обърка при генерирането на пътуването.';

  @override
  String get tripGenBasic => 'Създай основен маршрут без AI';

  @override
  String get planNotFound => 'Пътуването не е намерено';

  @override
  String get planItineraryTitle => 'Програма по дни';

  @override
  String get planMapView => 'Изглед карта';

  @override
  String get planExporting => 'Експортиране...';

  @override
  String get planExportPdf => 'Експорт PDF';

  @override
  String get planRegenerate => 'Регенерирай';

  @override
  String get planDiscard => 'Отхвърли';

  @override
  String get planSaving => 'Запазване...';

  @override
  String get planDraftNote =>
      'AI чернова — все още не е запазена в пътуванията ви';

  @override
  String get planSaved => 'Пътуването е запазено!';

  @override
  String get planSaveError => 'Пътуването не можа да се запази';

  @override
  String get planRegenerated => 'Генерирана е нова програма';

  @override
  String get planRegenError => 'Пътуването не можа да се регенерира';

  @override
  String get planLoadError => 'Детайлите за пътуването не можаха да се заредят';

  @override
  String get planPdfDone => 'PDF е изтеглен';

  @override
  String get planPdfError => 'PDF не можа да се експортира';

  @override
  String get planDiscardTitle => 'Да се отхвърли ли черновата?';

  @override
  String get planDiscardText => 'Тази AI чернова ще бъде премахната.';

  @override
  String get planDeleteTitle => 'Изтриване на пътуване';

  @override
  String get planDeleteText =>
      'Сигурни ли сте, че искате да изтриете това пътуване?';

  @override
  String planDayNumber(int n) {
    return 'ДЕН $n';
  }

  @override
  String get planMorning => 'Сутрин';

  @override
  String get planAfternoon => 'Следобед';

  @override
  String get planEvening => 'Вечер';

  @override
  String get planActivityFallback => 'Активност';

  @override
  String get mapTitle => 'Карта на пътуването';

  @override
  String mapDay(int n) {
    return 'Ден $n';
  }

  @override
  String get mapAllDays => 'Всички';

  @override
  String get mapViewDetails => 'Виж детайли';

  @override
  String mapCategory(int id) {
    return 'Категория $id';
  }

  @override
  String get mapPlaceError => 'Детайлите за мястото не можаха да се заредят';

  @override
  String get mapEmptyTitle => 'Няма отбелязани места';

  @override
  String get mapEmptyText =>
      'Този маршрут не съдържа места с координати. Основните маршрути и празните дни не се показват на картата.';

  @override
  String mapPlacesShown(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n места са показани',
      one: '1 място е показано',
    );
    return '$_temp0';
  }

  @override
  String get mapNoCoordsSuffix => '— без координати';
}
