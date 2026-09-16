// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get navHome => '首页';

  @override
  String get navTrips => '行程';

  @override
  String get navJournal => '日记';

  @override
  String get navWishlist => '心愿单';

  @override
  String get navProfile => '我的';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsAccount => '账号';

  @override
  String get settingsMyTrips => '我的行程';

  @override
  String get settingsMyTripsSubtitle => '查看和管理你的行程';

  @override
  String get settingsMyWishlist => '我的心愿单';

  @override
  String get settingsMyWishlistSubtitle => '你想去的地方';

  @override
  String get settingsPreferences => '偏好设置';

  @override
  String get settingsNotifications => '通知';

  @override
  String get settingsNotificationsSubtitle => '接收旅行提醒和动态';

  @override
  String get settingsOffline => '离线可用';

  @override
  String get settingsOfflineEnabled => '已启用离线访问';

  @override
  String get settingsOfflineDisabled => '已关闭离线访问';

  @override
  String get settingsProfileStatus => '主页状态';

  @override
  String get settingsProfilePrivate => '私密 – 仅关注者可见你的动态';

  @override
  String get settingsProfilePublic => '公开 – 所有人可见你的动态';

  @override
  String get settingsGeneral => '通用';

  @override
  String get settingsLanguage => '语言';

  @override
  String get settingsSelectLanguage => '选择语言';

  @override
  String get settingsTheme => '主题';

  @override
  String get settingsThemeSystem => '跟随系统';

  @override
  String get settingsThemeLight => '浅色';

  @override
  String get settingsThemeDark => '深色';

  @override
  String get settingsSelectTheme => '选择主题';

  @override
  String get settingsServerAddress => '服务器地址';

  @override
  String settingsServerDefault(String url) {
    return '默认 ($url)';
  }

  @override
  String get settingsServerDialogText =>
      '后端服务的运行地址。示例：\n• 家庭 Wi-Fi:  http://192.168.1.50:3001\n• 出门在外:    https://your-tunnel-url\n\n留空则使用默认服务器。';

  @override
  String get settingsServerUpdated => '服务器地址已更新';

  @override
  String get settingsStorage => '存储空间';

  @override
  String get settingsStorageSubtitle => '管理已下载的内容';

  @override
  String get settingsDangerZone => '危险区';

  @override
  String get settingsDeleteAccount => '删除账号';

  @override
  String get settingsDeleteAccountSubtitle => '永久删除你的账号及所有数据';

  @override
  String get settingsDeleteAccountConfirmTitle => '删除账号？';

  @override
  String get settingsDeleteAccountConfirmText => '此操作无法撤销，你的所有数据将被永久删除。';

  @override
  String get settingsDeleteAccountSoon => '账号删除功能即将上线！';

  @override
  String get settingsDelete => '删除';

  @override
  String get settingsLogout => '退出登录';

  @override
  String get settingsLogoutConfirmTitle => '退出登录？';

  @override
  String get settingsLogoutConfirmText => '确定要退出登录吗？';

  @override
  String get commonCancel => '取消';

  @override
  String get commonSave => '保存';

  @override
  String get commonClose => '关闭';

  @override
  String get commonRetry => '重试';

  @override
  String get commonLoading => '加载中...';

  @override
  String get commonError => '出错了';

  @override
  String get commonOffline => '无网络连接';

  @override
  String get commonOk => '确定';

  @override
  String get commonYes => '是';

  @override
  String get commonNo => '否';

  @override
  String get commonEdit => '编辑';

  @override
  String get authWelcomeBack => '欢迎回来';

  @override
  String get authSignInSubtitle => '登录以继续您的旅程';

  @override
  String get authEmail => '电子邮箱';

  @override
  String get authPassword => '密码';

  @override
  String get authForgotPassword => '忘记密码？';

  @override
  String get authLogin => '登录';

  @override
  String get authNoAccount => '还没有帐户？ ';

  @override
  String get authSignUp => '注册';

  @override
  String get authCreateAccount => '创建帐户';

  @override
  String get authCreateSubtitle => '开始您的旅行日记';

  @override
  String get authFullName => '全名';

  @override
  String get authHaveAccount => '已有帐户？ ';

  @override
  String get authEnterValid => '请输入有效的凭据';

  @override
  String get authFillRequired => '请填写所有必填字段';

  @override
  String get authInvalid => '凭据无效';

  @override
  String get authRegisterFailed => '注册失败';

  @override
  String get authSessionFailed => '无法启动会话，请重试。';

  @override
  String authPartialFail(String failed) {
    return '部分数据加载失败（$failed）。下拉重试。';
  }

  @override
  String get splashTagline => '旅行日记';

  @override
  String get splashGetStarted => '开始使用';

  @override
  String get authGenderMale => '男';

  @override
  String get authGenderFemale => '女';

  @override
  String get authGenderNonBinary => '非二元性别';

  @override
  String get authGenderPrefer => '不愿透露';

  @override
  String get homeSearchHint => '搜索国家或城市...';

  @override
  String get homeCountriesTitle => '国家';

  @override
  String homeCountriesCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n 个国家',
    );
    return '$_temp0';
  }

  @override
  String get homeLoadError => '无法加载国家';

  @override
  String get homeTapRetry => '点击重试';

  @override
  String get progressTitle => '旅行进度';

  @override
  String progressCount(int v, int t) {
    return '$v / $t 个国家';
  }

  @override
  String get countryRate => '评分';

  @override
  String get countryVisitedPrompt => '去过？';

  @override
  String get countryWishlist => '心愿单';

  @override
  String get countryWishlisted => '已在心愿单';

  @override
  String countryMarkedVisited(String name) {
    return '已将$name标记为去过';
  }

  @override
  String countryUnmarkedVisited(String name) {
    return '已取消$name的去过标记';
  }

  @override
  String countryAbout(String name) {
    return '关于$name';
  }

  @override
  String get countryMajorCities => '主要城市';

  @override
  String get countryMapPreview => '地图预览';

  @override
  String rateDialogTitle(String name) {
    return '为$name评分';
  }

  @override
  String get cityDiscover => '值得探索';

  @override
  String get catHistorical => '历史名胜';

  @override
  String get catArtLovers => '艺术爱好者';

  @override
  String get catAtmosphere => '氛围与体验';

  @override
  String get catHiddenGems => '隐藏瑰宝';

  @override
  String get catCloseBy => '附近';

  @override
  String get catMyPlaces => '我的地点';

  @override
  String get categoryPlaces => '地点';

  @override
  String get placeMarkVisited => '标记为去过';

  @override
  String get markShort => '标记';

  @override
  String get detailsAbout => '关于这个地方';

  @override
  String get detailsLocation => '位置';

  @override
  String get detailsWebsiteError => '无法打开网站';

  @override
  String get detailsVisitedAdded => '已标记为去过！';

  @override
  String get detailsVisitedRemoved => '已取消去过标记';

  @override
  String get detailsMarkAsVisited => '标记为去过';

  @override
  String get visitedLabel => '去过';

  @override
  String wishlistAdded(String name) {
    return '已将$name加入心愿单';
  }

  @override
  String wishlistRemoved(String name) {
    return '已将$name移出心愿单';
  }

  @override
  String get tripsNewTrip => '新建行程';

  @override
  String get tripsEmptyTitle => '还没有行程';

  @override
  String get tripsEmptyHint => '点击“新建行程”开始规划';

  @override
  String get tripsDraftHint => 'AI草稿已就绪 — 点击查看并保存';

  @override
  String tripDurationDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 天');
    return '$_temp0';
  }

  @override
  String get tripStyleSolo => '独自出行';

  @override
  String get tripStyleGroup => '结伴出行';

  @override
  String get tripTypeHistorical => '历史';

  @override
  String get tripTypeArt => '艺术';

  @override
  String get tripTypeMixed => '混合';

  @override
  String get tripFormTitleNew => '新建行程';

  @override
  String get tripFormTitleEdit => '编辑行程';

  @override
  String get tripSectionDestination => '目的地';

  @override
  String get tripSectionDates => '日期';

  @override
  String get tripSectionVacationType => '度假类型';

  @override
  String get tripSectionTravelStyle => '出行方式';

  @override
  String get tripSectionCompanions => '同行伙伴';

  @override
  String get tripChooseCountry => '选择国家';

  @override
  String get tripChooseCities => '选择要去的城市（可选）';

  @override
  String get tripArrivalCity => '到达城市';

  @override
  String get tripDepartureCity => '出发城市';

  @override
  String get tripStartDate => '开始日期';

  @override
  String get tripEndDate => '结束日期';

  @override
  String get tripSelect => '选择';

  @override
  String tripDurationLabel(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '时长：$n 天',
    );
    return '$_temp0';
  }

  @override
  String get tripNoFriendsHint => '还没有找到好友。关注其他旅行者（并让他们回关你），他们就会显示在这里，成为同行伙伴。';

  @override
  String get tripCountryFirst => '请先选择国家';

  @override
  String get tripSheetCities => '选择要去的城市';

  @override
  String tripSelectedCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '已选 $n 项',
    );
    return '$_temp0';
  }

  @override
  String tripCitiesIn(String name) {
    return '$name的城市';
  }

  @override
  String get tripNearbyCities => '邻国的附近城市';

  @override
  String get tripSearchCities => '搜索城市';

  @override
  String get tripSheetDone => '完成';

  @override
  String tripAddCities(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '添加 $n 个城市',
    );
    return '$_temp0';
  }

  @override
  String get tripGenerating => '生成中...';

  @override
  String get tripSave => '保存行程';

  @override
  String get tripGenerate => '生成行程计划';

  @override
  String get tripDurationLocked => '此处无法更改行程时长。如需更改天数，请新建行程。';

  @override
  String get tripGenFailTitle => '无法生成行程';

  @override
  String get tripGenFailFallback => '生成行程时出了问题。';

  @override
  String get tripGenBasic => '不使用AI创建基础行程';

  @override
  String get planNotFound => '未找到行程';

  @override
  String get planItineraryTitle => '逐日行程';

  @override
  String get planMapView => '地图视图';

  @override
  String get planExporting => '导出中...';

  @override
  String get planExportPdf => '导出PDF';

  @override
  String get planRegenerate => '重新生成';

  @override
  String get planDiscard => '放弃';

  @override
  String get planSaving => '保存中...';

  @override
  String get planDraftNote => 'AI草稿 — 尚未保存到你的行程中';

  @override
  String get planSaved => '行程已保存！';

  @override
  String get planSaveError => '无法保存行程';

  @override
  String get planRegenerated => '已生成新的行程';

  @override
  String get planRegenError => '无法重新生成行程';

  @override
  String get planLoadError => '无法加载行程详情';

  @override
  String get planPdfDone => 'PDF已下载';

  @override
  String get planPdfError => '无法导出PDF';

  @override
  String get planDiscardTitle => '放弃草稿？';

  @override
  String get planDiscardText => '该AI草稿将被删除。';

  @override
  String get planDeleteTitle => '删除行程';

  @override
  String get planDeleteText => '确定要删除该行程吗？';

  @override
  String planDayNumber(int n) {
    return '第 $n 天';
  }

  @override
  String get planMorning => '上午';

  @override
  String get planAfternoon => '下午';

  @override
  String get planEvening => '晚上';

  @override
  String get planActivityFallback => '活动';

  @override
  String get mapTitle => '行程地图';

  @override
  String mapDay(int n) {
    return '第 $n 天';
  }

  @override
  String get mapAllDays => '全部';

  @override
  String get mapViewDetails => '查看详情';

  @override
  String mapCategory(int id) {
    return '类别 $id';
  }

  @override
  String get mapPlaceError => '无法加载地点详情';

  @override
  String get mapEmptyTitle => '地图上没有地点';

  @override
  String get mapEmptyText => '该行程不包含有坐标的地点。基础行程和空白日期不会显示在地图上。';

  @override
  String mapPlacesShown(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '显示 $n 个地点',
    );
    return '$_temp0';
  }

  @override
  String get mapNoCoordsSuffix => '— 无坐标';

  @override
  String get journalOverviewTitle => '日记总览';

  @override
  String get journalDownload => '下载日记';

  @override
  String get journalPost => '发布到主页';

  @override
  String get journalNoCountries => '尚未加载国家';

  @override
  String get journalExploreMap => '探索地图';

  @override
  String journalCityCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n 个城市',
    );
    return '$_temp0';
  }

  @override
  String get journalNoneForCountry => '该国家还没有日记。';

  @override
  String get journalChooseCountry => '选择国家';

  @override
  String journalCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n 篇日记',
    );
    return '$_temp0';
  }

  @override
  String journalPageCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 页');
    return '$_temp0';
  }

  @override
  String get journalUntitled => '未命名日记';

  @override
  String get journalNoneToPost => '还没有可发布的日记。';

  @override
  String get journalPublic => '公开';

  @override
  String get journalPrivate => '私密';

  @override
  String get journalRemoveShort => '移除';

  @override
  String get journalRemoveTitle => '从主页移除？';

  @override
  String get journalPostTitle => '发布到主页？';

  @override
  String get journalRemoveText => '这会将日记设为私密，并从你的主页隐藏。';

  @override
  String get journalPostText => '这会将日记显示在你的主页上。公开日记对所有能查看你主页的人可见。';

  @override
  String get journalRemoved => '已从主页移除';

  @override
  String get journalPosted => '已发布到主页';

  @override
  String journalVisibilityError(String error) {
    return '无法更新可见性：$error';
  }

  @override
  String get journalUnknown => '未知';

  @override
  String get journalNew => '新建日记';

  @override
  String get journalNewHint => '开始记录你的旅程';

  @override
  String get journalEmpty => '还没有日记条目';

  @override
  String get journalStartWriting => '开始写作';

  @override
  String get journalRemoveProfile => '从主页移除';

  @override
  String get journalView => '查看';

  @override
  String editorSaveError(String error) {
    return '无法保存：$error';
  }

  @override
  String get editorSavedOffline => '已保存在本设备 — 联网后将同步。';

  @override
  String get editorDraftSaved => '草稿已保存！';

  @override
  String get editorAddPicture => '添加图片';

  @override
  String get editorFromGallery => '从相册选择';

  @override
  String get editorTakePhoto => '拍照';

  @override
  String get editorPicOffline => '图片已保存在本设备 — 联网后将同步。';

  @override
  String get editorPicAdded => '图片已添加！';

  @override
  String editorPicError(String error) {
    return '无法添加图片：$error';
  }

  @override
  String get editorTicketOffline => '票据已保存在本设备。联网后将同步。';

  @override
  String get editorTicketAdded => '票据已添加到你的日记！';

  @override
  String get editorClosedError => '日记编辑器已关闭。';

  @override
  String get editorPageGoneError => '该页面已不可用。';

  @override
  String editorTicketError(String error) {
    return '票据扫描失败：$error';
  }

  @override
  String get editorAddSticker => '添加贴纸';

  @override
  String get editorStickerAirplane => '飞机';

  @override
  String get editorStickerTicket => '票';

  @override
  String get editorStickerCamera => '相机';

  @override
  String get editorStickerArt => '艺术';

  @override
  String get editorStickerCoffee => '咖啡';

  @override
  String get editorStickerBuilding => '建筑';

  @override
  String get editorStickerTheater => '剧院';

  @override
  String get editorStickerWine => '葡萄酒';

  @override
  String get editorEditText => '编辑文本';

  @override
  String get editorDuplicate => '复制';

  @override
  String get editorBringForward => '前移';

  @override
  String get editorSendBackward => '后移';

  @override
  String get editorTextColor => '文字颜色';

  @override
  String get editorFontFamily => '字体';

  @override
  String get editorDupPage => '复制页面';

  @override
  String get editorMoveLeft => '左移';

  @override
  String get editorMoveRight => '右移';

  @override
  String get editorDeletePage => '删除页面';

  @override
  String get editorPageBg => '页面背景';

  @override
  String get editorBgCream => '奶油色';

  @override
  String get editorBgPeach => '蜜桃色';

  @override
  String get editorBgMint => '薄荷色';

  @override
  String get editorBgSky => '天蓝色';

  @override
  String get editorBgLavender => '薰衣草色';

  @override
  String get editorBgLemon => '柠檬色';

  @override
  String get editorMinPage => '日记至少需要一页。';

  @override
  String get editorToolText => '文本';

  @override
  String get editorToolPicture => '图片';

  @override
  String get editorToolTicket => '票据';

  @override
  String get editorToolSticker => '贴纸';

  @override
  String get editorAddPage => '添加页面';

  @override
  String get editorFormatTooltip => '格式';

  @override
  String get editorRotateLeft => '向左旋转';

  @override
  String get editorRotateRight => '向右旋转';

  @override
  String get editorSmaller => '缩小';

  @override
  String get editorBigger => '放大';

  @override
  String get editorRetakePhoto => '重新拍照';

  @override
  String get editorCropTicket => '裁剪票据';

  @override
  String get journalNotFound => '未找到';

  @override
  String get journalNoPages => '没有页面';

  @override
  String journalPageTitle(int n) {
    return '第 $n 页';
  }

  @override
  String get journalPdfError => '无法下载PDF';

  @override
  String get wishEmpty => '没有已保存的目的地';

  @override
  String get wishEmptyHint => '点击地点或国家上的爱心以保存';

  @override
  String get wishCountryBadge => '国家';

  @override
  String get wishRemoveTitle => '从心愿单移除';

  @override
  String wishRemoveText(String name) {
    return '从心愿单中移除$name？';
  }

  @override
  String get profileTagline => '旅行爱好者';

  @override
  String get profileStatPlaces => '地点';

  @override
  String get profileStatTrips => '行程';

  @override
  String get profileStatFollowers => '粉丝';

  @override
  String get profileStatFollowing => '关注';

  @override
  String get profileFindTravellers => '寻找要关注的旅行者';

  @override
  String get profilePhotos => '旅行照片';

  @override
  String get profileJournals => '日记';

  @override
  String get profileAdd => '添加';

  @override
  String get profileEdit => '编辑资料';

  @override
  String get profileFirstName => '名';

  @override
  String get profileLastName => '姓';

  @override
  String get profileBio => '简介';

  @override
  String get profilePhotoDone => '照片已上传';

  @override
  String get profilePhotoError => '无法上传照片';

  @override
  String get profilePhotoDeleteError => '无法删除照片';

  @override
  String get profileSaved => '资料已更新';

  @override
  String get profileDeletePhotoTitle => '删除照片';

  @override
  String get profileDeletePhotoText => '从你的主页移除这张照片？';

  @override
  String get searchTitle => '寻找旅行者';

  @override
  String get searchHint => '按用户名或姓名搜索';

  @override
  String get searchError => '搜索失败';

  @override
  String get searchPrompt => '输入以寻找其他旅行者';

  @override
  String get searchEmpty => '未找到旅行者';

  @override
  String get userFollow => '关注';

  @override
  String get userUnfollow => '取消关注';

  @override
  String userPrivateText(String username) {
    return '该主页为私密。关注$username以查看旅行照片。';
  }

  @override
  String get userFollowError => '无法更新关注状态';

  @override
  String get journalDeleteAction => '删除日记';

  @override
  String get journalDeleteTitle => '删除日记？';

  @override
  String journalDeleteText(String name) {
    return '这将永久删除“$name”。此操作无法撤销。';
  }

  @override
  String get journalDeleted => '日记已删除';

  @override
  String get journalDeleteError => '无法删除日记';
}
