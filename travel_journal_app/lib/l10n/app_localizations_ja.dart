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

  @override
  String get tripsNewTrip => '新しい旅行';

  @override
  String get tripsEmptyTitle => 'まだ旅行がありません';

  @override
  String get tripsEmptyHint => '「新しい旅行」をタップして計画を始めましょう';

  @override
  String get tripsDraftHint => 'AI下書きの準備完了 — タップして確認・保存';

  @override
  String tripDurationDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n日間');
    return '$_temp0';
  }

  @override
  String get tripStyleSolo => '一人旅';

  @override
  String get tripStyleGroup => 'グループ';

  @override
  String get tripTypeHistorical => '歴史';

  @override
  String get tripTypeArt => 'アート';

  @override
  String get tripTypeMixed => 'ミックス';

  @override
  String get tripFormTitleNew => '新しい旅行';

  @override
  String get tripFormTitleEdit => '旅行を編集';

  @override
  String get tripSectionDestination => '目的地';

  @override
  String get tripSectionDates => '日程';

  @override
  String get tripSectionVacationType => '旅行のタイプ';

  @override
  String get tripSectionTravelStyle => '旅行スタイル';

  @override
  String get tripSectionCompanions => '同行者';

  @override
  String get tripChooseCountry => '国を選択';

  @override
  String get tripChooseCities => '訪れる都市を選択（任意）';

  @override
  String get tripArrivalCity => '到着都市';

  @override
  String get tripDepartureCity => '出発都市';

  @override
  String get tripStartDate => '開始日';

  @override
  String get tripEndDate => '終了日';

  @override
  String get tripSelect => '選択';

  @override
  String tripDurationLabel(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '期間：$n日間',
    );
    return '$_temp0';
  }

  @override
  String get tripNoFriendsHint =>
      'まだ友達が見つかりません。他の旅行者をフォローして（フォロー返ししてもらうと）、同行者としてここに表示されます。';

  @override
  String get tripCountryFirst => '先に国を選択してください';

  @override
  String get tripSheetCities => '訪れる都市を選択';

  @override
  String tripSelectedCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n件選択中',
    );
    return '$_temp0';
  }

  @override
  String tripCitiesIn(String name) {
    return '$nameの都市';
  }

  @override
  String get tripNearbyCities => '近隣諸国の都市';

  @override
  String get tripSearchCities => '都市を検索';

  @override
  String get tripSheetDone => '完了';

  @override
  String tripAddCities(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n都市を追加',
    );
    return '$_temp0';
  }

  @override
  String get tripGenerating => '生成中...';

  @override
  String get tripSave => '旅行を保存';

  @override
  String get tripGenerate => '旅行プランを生成';

  @override
  String get tripDurationLocked => 'ここでは期間を変更できません。日数を変更するには新しい旅行を作成してください。';

  @override
  String get tripGenFailTitle => '旅行を生成できませんでした';

  @override
  String get tripGenFailFallback => '旅行の生成中に問題が発生しました。';

  @override
  String get tripGenBasic => 'AIなしで基本行程を作成';

  @override
  String get planNotFound => '旅行が見つかりません';

  @override
  String get planItineraryTitle => '日別行程';

  @override
  String get planMapView => '地図表示';

  @override
  String get planExporting => 'エクスポート中...';

  @override
  String get planExportPdf => 'PDFをエクスポート';

  @override
  String get planRegenerate => '再生成';

  @override
  String get planDiscard => '破棄';

  @override
  String get planSaving => '保存中...';

  @override
  String get planDraftNote => 'AI下書き — まだ旅行に保存されていません';

  @override
  String get planSaved => '旅行を保存しました！';

  @override
  String get planSaveError => '旅行を保存できませんでした';

  @override
  String get planRegenerated => '新しい行程を生成しました';

  @override
  String get planRegenError => '旅行を再生成できませんでした';

  @override
  String get planLoadError => '旅行の詳細を読み込めませんでした';

  @override
  String get planPdfDone => 'PDFをダウンロードしました';

  @override
  String get planPdfError => 'PDFをエクスポートできませんでした';

  @override
  String get planDiscardTitle => '下書きを破棄しますか？';

  @override
  String get planDiscardText => 'このAI下書きは削除されます。';

  @override
  String get planDeleteTitle => '旅行を削除';

  @override
  String get planDeleteText => 'この旅行を削除してもよろしいですか？';

  @override
  String planDayNumber(int n) {
    return '$n日目';
  }

  @override
  String get planMorning => '午前';

  @override
  String get planAfternoon => '午後';

  @override
  String get planEvening => '夜';

  @override
  String get planActivityFallback => 'アクティビティ';

  @override
  String get mapTitle => '旅行マップ';

  @override
  String mapDay(int n) {
    return '$n日目';
  }

  @override
  String get mapAllDays => 'すべて';

  @override
  String get mapViewDetails => '詳細を見る';

  @override
  String mapCategory(int id) {
    return 'カテゴリー$id';
  }

  @override
  String get mapPlaceError => '場所の詳細を読み込めませんでした';

  @override
  String get mapEmptyTitle => '地図上の場所がありません';

  @override
  String get mapEmptyText => 'この行程には座標のある場所が含まれていません。基本行程や空の日は地図に表示されません。';

  @override
  String mapPlacesShown(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n件表示中',
    );
    return '$_temp0';
  }

  @override
  String get mapNoCoordsSuffix => '— 座標なし';

  @override
  String get journalOverviewTitle => '日記一覧';

  @override
  String get journalDownload => '日記をダウンロード';

  @override
  String get journalPost => 'プロフィールに投稿';

  @override
  String get journalNoCountries => '国がまだ読み込まれていません';

  @override
  String get journalExploreMap => '地図を探索';

  @override
  String journalCityCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n都市');
    return '$_temp0';
  }

  @override
  String get journalNoneForCountry => 'この国の日記はまだありません。';

  @override
  String get journalChooseCountry => '国を選択';

  @override
  String journalCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n件の日記',
    );
    return '$_temp0';
  }

  @override
  String journalPageCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nページ',
    );
    return '$_temp0';
  }

  @override
  String get journalUntitled => '無題の日記';

  @override
  String get journalNoneToPost => '投稿できる日記はまだありません。';

  @override
  String get journalPublic => '公開';

  @override
  String get journalPrivate => '非公開';

  @override
  String get journalRemoveShort => '削除';

  @override
  String get journalRemoveTitle => 'プロフィールから削除しますか？';

  @override
  String get journalPostTitle => 'プロフィールに投稿しますか？';

  @override
  String get journalRemoveText => '日記は非公開になり、プロフィールから非表示になります。';

  @override
  String get journalPostText => '日記はプロフィールに表示されます。公開日記はプロフィールを閲覧できる全員に表示されます。';

  @override
  String get journalRemoved => 'プロフィールから削除しました';

  @override
  String get journalPosted => 'プロフィールに投稿しました';

  @override
  String journalVisibilityError(String error) {
    return '公開設定を更新できませんでした：$error';
  }

  @override
  String get journalUnknown => '不明';

  @override
  String get journalNew => '新しい日記';

  @override
  String get journalNewHint => '旅の記録を始めましょう';

  @override
  String get journalEmpty => 'まだ日記の記録がありません';

  @override
  String get journalStartWriting => '書き始める';

  @override
  String get journalRemoveProfile => 'プロフィールから削除';

  @override
  String get journalView => '表示';

  @override
  String editorSaveError(String error) {
    return '保存できませんでした：$error';
  }

  @override
  String get editorSavedOffline => 'このデバイスに保存しました — オンライン時に同期されます。';

  @override
  String get editorDraftSaved => '下書きを保存しました！';

  @override
  String get editorAddPicture => '写真を追加';

  @override
  String get editorFromGallery => 'ギャラリーから';

  @override
  String get editorTakePhoto => '写真を撮る';

  @override
  String get editorPicOffline => '写真をこのデバイスに保存しました — オンライン時に同期されます。';

  @override
  String get editorPicAdded => '写真を追加しました！';

  @override
  String editorPicError(String error) {
    return '写真を追加できませんでした：$error';
  }

  @override
  String get editorTicketOffline => 'チケットをこのデバイスに保存しました。オンライン時に同期されます。';

  @override
  String get editorTicketAdded => 'チケットを日記に追加しました！';

  @override
  String get editorClosedError => '日記エディターが閉じられました。';

  @override
  String get editorPageGoneError => 'ページは利用できなくなりました。';

  @override
  String editorTicketError(String error) {
    return 'チケットのスキャンに失敗しました：$error';
  }

  @override
  String get editorAddSticker => 'ステッカーを追加';

  @override
  String get editorStickerAirplane => '飛行機';

  @override
  String get editorStickerTicket => 'チケット';

  @override
  String get editorStickerCamera => 'カメラ';

  @override
  String get editorStickerArt => 'アート';

  @override
  String get editorStickerCoffee => 'コーヒー';

  @override
  String get editorStickerBuilding => '建物';

  @override
  String get editorStickerTheater => '劇場';

  @override
  String get editorStickerWine => 'ワイン';

  @override
  String get editorEditText => 'テキストを編集';

  @override
  String get editorDuplicate => '複製';

  @override
  String get editorBringForward => '前面へ';

  @override
  String get editorSendBackward => '背面へ';

  @override
  String get editorTextColor => '文字色';

  @override
  String get editorFontFamily => 'フォント';

  @override
  String get editorDupPage => 'ページを複製';

  @override
  String get editorMoveLeft => '左へ移動';

  @override
  String get editorMoveRight => '右へ移動';

  @override
  String get editorDeletePage => 'ページを削除';

  @override
  String get editorPageBg => 'ページ背景';

  @override
  String get editorBgCream => 'クリーム';

  @override
  String get editorBgPeach => 'ピーチ';

  @override
  String get editorBgMint => 'ミント';

  @override
  String get editorBgSky => 'スカイ';

  @override
  String get editorBgLavender => 'ラベンダー';

  @override
  String get editorBgLemon => 'レモン';

  @override
  String get editorMinPage => '日記には少なくとも1ページ必要です。';

  @override
  String get editorToolText => 'テキスト';

  @override
  String get editorToolPicture => '写真';

  @override
  String get editorToolTicket => 'チケット';

  @override
  String get editorToolSticker => 'ステッカー';

  @override
  String get editorAddPage => 'ページを追加';

  @override
  String get editorFormatTooltip => '書式';

  @override
  String get editorRotateLeft => '左に回転';

  @override
  String get editorRotateRight => '右に回転';

  @override
  String get editorSmaller => '小さく';

  @override
  String get editorBigger => '大きく';

  @override
  String get editorRetakePhoto => '写真を撮り直す';

  @override
  String get editorCropTicket => 'チケットを切り抜く';

  @override
  String get journalNotFound => '見つかりません';

  @override
  String get journalNoPages => 'ページがありません';

  @override
  String journalPageTitle(int n) {
    return 'ページ $n';
  }

  @override
  String get journalPdfError => 'PDFをダウンロードできませんでした';

  @override
  String get wishEmpty => '保存した目的地がありません';

  @override
  String get wishEmptyHint => '場所や国のハートをタップして保存しましょう';

  @override
  String get wishCountryBadge => '国';

  @override
  String get wishRemoveTitle => 'ウィッシュリストから削除';

  @override
  String wishRemoveText(String name) {
    return '$nameをウィッシュリストから削除しますか？';
  }

  @override
  String get profileTagline => '旅行愛好家';

  @override
  String get profileStatPlaces => '場所';

  @override
  String get profileStatTrips => '旅行';

  @override
  String get profileStatFollowers => 'フォロワー';

  @override
  String get profileStatFollowing => 'フォロー中';

  @override
  String get profileFindTravellers => 'フォローする旅行者を探す';

  @override
  String get profilePhotos => '旅行の写真';

  @override
  String get profileJournals => '日記';

  @override
  String get profileAdd => '追加';

  @override
  String get profileEdit => 'プロフィールを編集';

  @override
  String get profileFirstName => '名';

  @override
  String get profileLastName => '姓';

  @override
  String get profileBio => '自己紹介';

  @override
  String get profilePhotoDone => '写真をアップロードしました';

  @override
  String get profilePhotoError => '写真をアップロードできませんでした';

  @override
  String get profilePhotoDeleteError => '写真を削除できませんでした';

  @override
  String get profileSaved => 'プロフィールを更新しました';

  @override
  String get profileDeletePhotoTitle => '写真を削除';

  @override
  String get profileDeletePhotoText => 'この写真をプロフィールから削除しますか？';

  @override
  String get searchTitle => '旅行者を探す';

  @override
  String get searchHint => 'ユーザー名や名前で検索';

  @override
  String get searchError => '検索に失敗しました';

  @override
  String get searchPrompt => '入力して他の旅行者を探しましょう';

  @override
  String get searchEmpty => '旅行者が見つかりませんでした';

  @override
  String get userFollow => 'フォローする';

  @override
  String get userUnfollow => 'フォロー解除';

  @override
  String userPrivateText(String username) {
    return 'このプロフィールは非公開です。$usernameをフォローして旅行の写真を見ましょう。';
  }

  @override
  String get userFollowError => 'フォロー状態を更新できませんでした';
}
