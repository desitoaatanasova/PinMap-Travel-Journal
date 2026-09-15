import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static const String _key = 'locale_code';

  static const Map<String, Locale> languageLocales = {
    'English': Locale('en'),
    'Bulgarian': Locale('bg'),
    'Spanish': Locale('es'),
    'French': Locale('fr'),
    'German': Locale('de'),
    'Japanese': Locale('ja'),
    'Chinese': Locale('zh'),
    'Italian': Locale('it'),
  };

  static List<Locale> get supportedLocales => languageLocales.values.toList();

  static List<String> get supportedLanguages => languageLocales.keys.toList();

  static final ValueNotifier<Locale?> notifier = ValueNotifier<Locale?>(null);

  static Locale? get locale => notifier.value;

  static String get currentLanguage => languageForLocale(notifier.value);

  static Locale localeForLanguage(String? name) =>
      languageLocales[name] ?? const Locale('en');

  static Locale localeForCode(String? code) {
    if (code == null || code.isEmpty) return const Locale('en');
    for (final locale in languageLocales.values) {
      if (locale.languageCode == code) return locale;
    }
    return const Locale('en');
  }

  static String languageForLocale(Locale? locale) {
    if (locale == null) return 'English';
    for (final entry in languageLocales.entries) {
      if (entry.value.languageCode == locale.languageCode) return entry.key;
    }
    return 'English';
  }

  static Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_key);
      if (raw != null && raw.isNotEmpty) {
        notifier.value = localeForCode(raw);
      } else {
        notifier.value = null;
      }
    } catch (_) {
      notifier.value = null;
    }
  }

  static Future<void> setLanguage(String name) async {
    final locale = localeForLanguage(name);
    notifier.value = locale;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, locale.languageCode);
    } catch (_) {}
  }

  static Future<void> syncFromServer(String? name) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey(_key)) return;
      final locale = localeForLanguage(name);
      notifier.value = locale;
      await prefs.setString(_key, locale.languageCode);
    } catch (_) {}
  }

  static Locale resolveLocale(Locale? deviceLocale) {
    final code = deviceLocale?.languageCode;
    if (code != null) {
      for (final locale in languageLocales.values) {
        if (locale.languageCode == code) return locale;
      }
    }
    return const Locale('en');
  }
}
