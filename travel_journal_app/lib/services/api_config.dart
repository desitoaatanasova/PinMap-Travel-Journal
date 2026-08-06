import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Platform-aware server configuration.
///
/// The server base URL can be changed at runtime from the Settings screen
/// ("Server address"), which persists an override. This lets a built APK work
/// on any network:
///   - at home:     http://PC-LAN-IP:3001  (phone on the same Wi-Fi)
///   - anywhere:    an HTTPS tunnel URL such as https://xxx.trycloudflare.com
class ApiConfig {
  static const String _overrideKey = 'server_base_url';
  static String _override = '';
  static const String physicalDeviceBaseUrlOverride = '';

  /// Server address chosen in the app, or '' when not set.
  static String get serverOverride => _override;

  static String get baseUrl {
    if (_override.isNotEmpty) {
      return _override;
    }
    if (physicalDeviceBaseUrlOverride.isNotEmpty) {
      return physicalDeviceBaseUrlOverride;
    }
    // Android emulator reaches the host machine via 10.0.2.2
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:3001';
    }
    return 'http://localhost:3001';
  }

  static String get apiBaseUrl => '$baseUrl/api';

  /// Loads the persisted server override (called once at startup).
  static Future<void> loadOverride() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _override = prefs.getString(_overrideKey) ?? '';
      _override = _normalize(_override);
    } catch (_) {
      _override = '';
    }
  }

  /// Persists a new server address. An empty value resets to the default.
  static Future<void> setOverride(String url) async {
    _override = _normalize(url);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_overrideKey, _override);
  }

  static String _normalize(String url) {
    var value = url.trim();
    while (value.endsWith('/')) {
      value = value.substring(0, value.length - 1);
    }
    return value;
  }

  /// Resolves a relative server path (e.g. '/uploads/...') to an absolute URL.
  static String assetUrl(String path) {
    if (path.startsWith('http://') || path.startsWith('https://')) return path;
    return '$baseUrl$path';
  }
}
