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
}
