import 'package:flutter/foundation.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';
import 'package:pinmap_travel_journal/services/sync_queue_service.dart';

class UserSettings {
  final int userId;
  final bool notificationsEnabled;
  final bool offlineModeEnabled;
  final String language;

  const UserSettings({
    this.userId = 0,
    this.notificationsEnabled = true,
    this.offlineModeEnabled = false,
    this.language = 'English',
  });

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      userId: (json['userId'] as num?)?.toInt() ?? 0,
      notificationsEnabled: json['notificationsEnabled'] ?? true,
      offlineModeEnabled: json['offlineModeEnabled'] ?? false,
      language: json['language'] ?? 'English',
    );
  }
}

class SettingsService {
  static UserSettings? _settings;
  static bool _loaded = false;

  static const List<String> supportedLanguages = [
    'English',
    'Bulgarian',
    'German',
    'French',
    'Spanish',
  ];

  static Future<UserSettings> getSettings() async {
    if (_loaded && _settings != null) return _settings!;
    try {
      final data = await ApiClient.get('/settings');
      _settings = UserSettings.fromJson(data);
      _loaded = true;
    } catch (e) {
      debugPrint('SettingsService.getSettings error: $e');
      _settings = const UserSettings();
      _loaded = true;
    }
    return _settings!;
  }

  static Future<UserSettings> updateSettings({
    bool? notificationsEnabled,
    bool? offlineModeEnabled,
    String? language,
  }) async {
    final current = await getSettings();
    final next = UserSettings(
      userId: current.userId,
      notificationsEnabled:
          notificationsEnabled ?? current.notificationsEnabled,
      offlineModeEnabled: offlineModeEnabled ?? current.offlineModeEnabled,
      language: language ?? current.language,
    );
    _settings = next;

    final body = <String, dynamic>{
      if (notificationsEnabled != null)
        'notificationsEnabled': notificationsEnabled,
      if (offlineModeEnabled != null) 'offlineModeEnabled': offlineModeEnabled,
      if (language != null) 'language': language,
    };
    try {
      final data = await ApiClient.put('/settings', body: body);
      _settings = UserSettings.fromJson(data);
    } catch (e) {
      debugPrint('SettingsService.updateSettings offline: $e');
      await SyncQueueService.enqueue(SyncAction(
        type: SyncActionType.saveSettings,
        data: body,
        timestamp: DateTime.now(),
      ));
    }
    return _settings!;
  }

  static void reset() {
    _settings = null;
    _loaded = false;
  }
}
