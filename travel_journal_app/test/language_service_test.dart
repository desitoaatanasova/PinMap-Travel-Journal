import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pinmap_travel_journal/l10n/app_localizations.dart';
import 'package:pinmap_travel_journal/services/language_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LanguageService mapping', () {
    test('all picker display names resolve to locales', () {
      expect(LanguageService.localeForLanguage('English'), const Locale('en'));
      expect(
        LanguageService.localeForLanguage('Bulgarian'),
        const Locale('bg'),
      );
      expect(LanguageService.localeForLanguage('Spanish'), const Locale('es'));
      expect(LanguageService.localeForLanguage('French'), const Locale('fr'));
      expect(LanguageService.localeForLanguage('German'), const Locale('de'));
      expect(LanguageService.localeForLanguage('Japanese'), const Locale('ja'));
      expect(LanguageService.localeForLanguage('Chinese'), const Locale('zh'));
      expect(LanguageService.localeForLanguage('Italian'), const Locale('it'));
    });

    test('unknown and legacy values fall back to English', () {
      expect(
        LanguageService.localeForLanguage('Portuguese'),
        const Locale('en'),
      );
      expect(LanguageService.localeForLanguage('Russian'), const Locale('en'));
      expect(LanguageService.localeForLanguage(null), const Locale('en'));
      expect(LanguageService.localeForLanguage(''), const Locale('en'));
      expect(LanguageService.languageForLocale(const Locale('pt')), 'English');
      expect(LanguageService.languageForLocale(const Locale('ru')), 'English');
      expect(LanguageService.localeForCode('pt'), const Locale('en'));
      expect(LanguageService.localeForCode('ru'), const Locale('en'));
    });

    test('locale codes resolve and round-trip', () {
      expect(LanguageService.localeForCode('bg'), const Locale('bg'));
      expect(LanguageService.localeForCode('xx'), const Locale('en'));
      expect(LanguageService.localeForCode(null), const Locale('en'));
      expect(LanguageService.languageForLocale(const Locale('de')), 'German');
      expect(LanguageService.languageForLocale(null), 'English');
    });

    test('supported locales cover all 8 picker languages', () {
      expect(LanguageService.supportedLocales, hasLength(8));
      expect(LanguageService.supportedLanguages, hasLength(8));
    });

    test('endonyms resolve per language without changing stored values', () {
      expect(LanguageService.endonymForLanguage('English'), 'English');
      expect(LanguageService.endonymForLanguage('Bulgarian'), 'Български');
      expect(LanguageService.endonymForLanguage('Spanish'), 'Español');
      expect(LanguageService.endonymForLanguage('French'), 'Français');
      expect(LanguageService.endonymForLanguage('German'), 'Deutsch');
      expect(LanguageService.endonymForLanguage('Japanese'), '日本語');
      expect(LanguageService.endonymForLanguage('Chinese'), '中文');
      expect(LanguageService.endonymForLanguage('Italian'), 'Italiano');
      expect(LanguageService.endonymForLanguage('Portuguese'), 'English');
      expect(LanguageService.endonymForLanguage(null), 'English');
      expect(
        LanguageService.languageForEndonym('Български'),
        'Bulgarian',
      );
      expect(LanguageService.languageForEndonym('日本語'), 'Japanese');
      expect(LanguageService.languageForEndonym('Português'), isNull);
      expect(
        LanguageService.endonymForLocale(const Locale('bg')),
        'Български',
      );
      expect(LanguageService.endonymForLocale(null), 'English');
    });

    test('device locale resolves with English fallback', () {
      expect(
        LanguageService.resolveLocale(const Locale('fr')),
        const Locale('fr'),
      );
      expect(
        LanguageService.resolveLocale(const Locale('pt')),
        const Locale('en'),
      );
      expect(LanguageService.resolveLocale(null), const Locale('en'));
    });
  });

  group('LanguageService persistence', () {
    test('persisted locale code loads on init', () async {
      SharedPreferences.setMockInitialValues({'locale_code': 'bg'});
      await LanguageService.init();
      expect(LanguageService.locale, const Locale('bg'));
      expect(LanguageService.currentLanguage, 'Bulgarian');
    });

    test('setLanguage persists and notifies', () async {
      SharedPreferences.setMockInitialValues({});
      await LanguageService.init();
      expect(LanguageService.locale, isNull);
      await LanguageService.setLanguage('Japanese');
      expect(LanguageService.locale, const Locale('ja'));
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('locale_code'), 'ja');
    });

    test(
      'syncFromServer adopts server value only when no local cache',
      () async {
        SharedPreferences.setMockInitialValues({});
        await LanguageService.init();
        await LanguageService.syncFromServer('French');
        expect(LanguageService.locale, const Locale('fr'));

        await LanguageService.setLanguage('German');
        await LanguageService.syncFromServer('French');
        expect(LanguageService.locale, const Locale('de'));
      },
    );

    test('stored legacy display names remain compatible', () async {
      SharedPreferences.setMockInitialValues({});
      await LanguageService.init();
      await LanguageService.syncFromServer('Italian');
      expect(LanguageService.locale, const Locale('it'));
      expect(LanguageService.currentLanguage, 'Italian');
    });
  });

  group('Localization widgets', () {
    Future<void> pumpLocalized(
      WidgetTester tester, {
      required Locale? locale,
    }) async {
      await tester.pumpWidget(
        ValueListenableBuilder<Locale?>(
          valueListenable: LanguageService.notifier,
          builder:
              (context, active, _) => MaterialApp(
                locale: active ?? locale,
                supportedLocales: LanguageService.supportedLocales,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                home: Builder(
                  builder:
                      (context) => Text(AppLocalizations.of(context).navHome),
                ),
              ),
        ),
      );
    }

    testWidgets('initial locale renders translated text', (tester) async {
      SharedPreferences.setMockInitialValues({'locale_code': 'bg'});
      await LanguageService.init();
      await pumpLocalized(tester, locale: null);
      expect(find.text('Начало'), findsOneWidget);
    });

    testWidgets('changing language updates text without restart', (
      tester,
    ) async {
      SharedPreferences.setMockInitialValues({});
      await LanguageService.init();
      await pumpLocalized(tester, locale: const Locale('en'));
      expect(find.text('Home'), findsOneWidget);
      await LanguageService.setLanguage('Bulgarian');
      await tester.pump();
      expect(find.text('Начало'), findsOneWidget);
      expect(find.text('Home'), findsNothing);
    });
  });
}
