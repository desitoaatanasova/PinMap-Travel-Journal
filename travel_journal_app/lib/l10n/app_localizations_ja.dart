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
}
