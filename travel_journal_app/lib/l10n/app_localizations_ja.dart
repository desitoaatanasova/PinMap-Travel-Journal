// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get navHome => 'ホーム';

  @override
  String get navTrips => '旅行';

  @override
  String get navJournal => '日記';

  @override
  String get navWishlist => '行きたいリスト';

  @override
  String get navProfile => 'プロフィール';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsAccount => 'アカウント';

  @override
  String get settingsMyTrips => 'マイ旅行';

  @override
  String get settingsMyTripsSubtitle => '旅行の表示と管理';

  @override
  String get settingsMyWishlist => '行きたいリスト';

  @override
  String get settingsMyWishlistSubtitle => '訪れたい場所';

  @override
  String get settingsPreferences => '環境設定';

  @override
  String get settingsNotifications => '通知';

  @override
  String get settingsNotificationsSubtitle => '旅行のリマインダーや最新情報を受け取る';

  @override
  String get settingsOffline => 'オフライン利用';

  @override
  String get settingsOfflineEnabled => 'オフラインアクセスが有効';

  @override
  String get settingsOfflineDisabled => 'オフラインアクセスが無効';

  @override
  String get settingsProfileStatus => 'プロフィールの公開設定';

  @override
  String get settingsProfilePrivate => '非公開 – フォロワーのみアクティビティを閲覧可能';

  @override
  String get settingsProfilePublic => '公開 – 誰でもアクティビティを閲覧可能';

  @override
  String get settingsGeneral => '一般';

  @override
  String get settingsLanguage => '言語';

  @override
  String get settingsSelectLanguage => '言語を選択';

  @override
  String get settingsTheme => 'テーマ';

  @override
  String get settingsThemeSystem => 'システム';

  @override
  String get settingsThemeLight => 'ライト';

  @override
  String get settingsThemeDark => 'ダーク';

  @override
  String get settingsSelectTheme => 'テーマを選択';

  @override
  String get settingsServerAddress => 'サーバーアドレス';

  @override
  String settingsServerDefault(String url) {
    return 'デフォルト ($url)';
  }

  @override
  String get settingsServerDialogText =>
      'バックエンドの実行場所。例：\n• 自宅Wi-Fi:  http://192.168.1.50:3001\n• 外出先から:    https://your-tunnel-url\n\nデフォルトのサーバーを使う場合は空欄のままにしてください。';

  @override
  String get settingsServerUpdated => 'サーバーアドレスを更新しました';

  @override
  String get settingsStorage => 'ストレージ';

  @override
  String get settingsStorageSubtitle => 'ダウンロード済みコンテンツの管理';

  @override
  String get settingsDangerZone => '危険ゾーン';

  @override
  String get settingsDeleteAccount => 'アカウントを削除';

  @override
  String get settingsDeleteAccountSubtitle => 'アカウントとすべてのデータを完全に削除します';

  @override
  String get settingsDeleteAccountConfirmTitle => 'アカウントを削除しますか？';

  @override
  String get settingsDeleteAccountConfirmText =>
      'この操作は取り消せません。すべてのデータが完全に削除されます。';

  @override
  String get settingsDeleteAccountSoon => 'アカウント削除機能は近日公開予定です！';

  @override
  String get settingsDelete => '削除';

  @override
  String get settingsLogout => 'ログアウト';

  @override
  String get settingsLogoutConfirmTitle => 'ログアウトしますか？';

  @override
  String get settingsLogoutConfirmText => '本当にログアウトしますか？';

  @override
  String get commonCancel => 'キャンセル';

  @override
  String get commonSave => '保存';

  @override
  String get commonClose => '閉じる';

  @override
  String get commonRetry => '再試行';

  @override
  String get commonLoading => '読み込み中...';

  @override
  String get commonError => '問題が発生しました';

  @override
  String get commonOffline => 'インターネット接続がありません';

  @override
  String get commonOk => 'OK';

  @override
  String get commonYes => 'はい';

  @override
  String get commonNo => 'いいえ';

  @override
  String get commonEdit => '編集';

  @override
  String get authWelcomeBack => 'おかえりなさい';

  @override
  String get authSignInSubtitle => '旅を続けるにはサインインしてください';

  @override
  String get authEmail => 'メールアドレス';

  @override
  String get authPassword => 'パスワード';

  @override
  String get authForgotPassword => 'パスワードをお忘れですか？';

  @override
  String get authLogin => 'ログイン';

  @override
  String get authNoAccount => 'アカウントをお持ちでないですか？ ';

  @override
  String get authSignUp => '登録する';

  @override
  String get authCreateAccount => 'アカウント作成';

  @override
  String get authCreateSubtitle => '旅行日記を始めよう';

  @override
  String get authFullName => '氏名';

  @override
  String get authHaveAccount => 'すでにアカウントをお持ちですか？ ';

  @override
  String get authEnterValid => '有効な認証情報を入力してください';

  @override
  String get authFillRequired => 'すべての必須項目を入力してください';

  @override
  String get authInvalid => '認証情報が無効です';

  @override
  String get authRegisterFailed => '登録に失敗しました';

  @override
  String get authSessionFailed => 'セッションを開始できませんでした。もう一度お試しください。';

  @override
  String authPartialFail(String failed) {
    return '一部のデータの読み込みに失敗しました（$failed）。引っ張って再試行してください。';
  }

  @override
  String get splashTagline => '旅行日記';

  @override
  String get splashGetStarted => 'はじめる';

  @override
  String get authGenderMale => '男性';

  @override
  String get authGenderFemale => '女性';

  @override
  String get authGenderNonBinary => 'ノンバイナリー';

  @override
  String get authGenderPrefer => '回答しない';

  @override
  String get homeSearchHint => '国や都市を検索...';

  @override
  String get homeCountriesTitle => '国';

  @override
  String homeCountriesCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$nか国');
    return '$_temp0';
  }

  @override
  String get homeLoadError => '国を読み込めませんでした';

  @override
  String get homeTapRetry => 'タップして再試行';

  @override
  String get progressTitle => '旅行の進捗';

  @override
  String progressCount(int v, int t) {
    return '$v / $tか国';
  }

  @override
  String get countryRate => '評価する';

  @override
  String get countryVisitedPrompt => '訪問済み？';

  @override
  String get countryWishlist => '行きたいリスト';

  @override
  String get countryWishlisted => 'リスト済み';

  @override
  String countryMarkedVisited(String name) {
    return '$nameを訪問済みにしました';
  }

  @override
  String countryUnmarkedVisited(String name) {
    return '$nameの訪問済みを解除しました';
  }

  @override
  String countryAbout(String name) {
    return '$nameについて';
  }

  @override
  String get countryMajorCities => '主要都市';

  @override
  String get countryMapPreview => '地図プレビュー';

  @override
  String rateDialogTitle(String name) {
    return '$nameを評価する';
  }

  @override
  String get cityDiscover => '見つけるもの';

  @override
  String get catHistorical => '歴史的名所';

  @override
  String get catArtLovers => 'アート好きのために';

  @override
  String get catAtmosphere => '雰囲気と体験';

  @override
  String get catHiddenGems => '隠れた名所';

  @override
  String get catCloseBy => '近隣';

  @override
  String get catMyPlaces => 'マイプレイス';

  @override
  String get categoryPlaces => '場所';

  @override
  String get placeMarkVisited => '訪問済みにする';

  @override
  String get markShort => '記録';

  @override
  String get detailsAbout => 'この場所について';

  @override
  String get detailsLocation => '所在地';

  @override
  String get detailsWebsiteError => 'ウェブサイトを開けませんでした';

  @override
  String get detailsVisitedAdded => '訪問済みにしました！';

  @override
  String get detailsVisitedRemoved => '訪問済みを解除しました';

  @override
  String get detailsMarkAsVisited => '訪問済みにする';

  @override
  String get visitedLabel => '訪問済み';

  @override
  String wishlistAdded(String name) {
    return '$nameをウィッシュリストに追加しました';
  }

  @override
  String wishlistRemoved(String name) {
    return '$nameをウィッシュリストから削除しました';
  }
}
