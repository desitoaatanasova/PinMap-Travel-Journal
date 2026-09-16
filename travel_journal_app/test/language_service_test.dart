import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pinmap_travel_journal/l10n/app_localizations.dart';
import 'package:pinmap_travel_journal/services/language_service.dart';
import 'package:pinmap_travel_journal/utils/category_label.dart';
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

  group('ARB parity', () {
    test('all 8 ARBs share the same key set', () {
      const codes = ['en', 'bg', 'de', 'es', 'fr', 'it', 'ja', 'zh'];
      Set<String>? reference;
      for (final code in codes) {
        final raw = File(
          'lib/l10n/app_$code.arb',
        ).readAsStringSync();
        final map = jsonDecode(raw) as Map<String, dynamic>;
        final keys =
            map.keys.where((k) => !k.startsWith('@')).toSet();
        if (reference == null) {
          reference = keys;
        } else {
          expect(keys, reference, reason: 'app_$code.arb key mismatch');
        }
      }
      expect(reference, contains('authWelcomeBack'));
      expect(reference, contains('authPartialFail'));
      expect(reference, contains('splashGetStarted'));
      expect(reference, contains('commonOk'));
      expect(reference, contains('commonYes'));
      expect(reference, contains('commonNo'));
      expect(reference, contains('commonEdit'));
    });

    test('no ARB uses English placeholders for translated keys', () {
      const translated = ['bg', 'de', 'es', 'fr', 'it', 'ja', 'zh'];
      final enRaw = File(
        'lib/l10n/app_en.arb',
      ).readAsStringSync();
      final enMap = jsonDecode(enRaw) as Map<String, dynamic>;
      for (final code in translated) {
        final raw = File(
          'lib/l10n/app_$code.arb',
        ).readAsStringSync();
        final map = jsonDecode(raw) as Map<String, dynamic>;
        for (final key in ['authWelcomeBack', 'authLogin', 'splashGetStarted']) {
          expect(
            map[key],
            isNot(equals(enMap[key])),
            reason: 'app_$code.arb $key must be translated',
          );
        }
      }
    });

    test('home/places keys exist in all 8 ARBs', () {
      const codes = ['en', 'bg', 'de', 'es', 'fr', 'it', 'ja', 'zh'];
      const expected = [
        'homeSearchHint',
        'homeCountriesTitle',
        'homeCountriesCount',
        'homeLoadError',
        'homeTapRetry',
        'progressTitle',
        'progressCount',
        'countryRate',
        'countryVisitedPrompt',
        'countryWishlist',
        'countryWishlisted',
        'countryMarkedVisited',
        'countryUnmarkedVisited',
        'countryAbout',
        'countryMajorCities',
        'countryMapPreview',
        'rateDialogTitle',
        'cityDiscover',
        'catHistorical',
        'catArtLovers',
        'catAtmosphere',
        'catHiddenGems',
        'catCloseBy',
        'catMyPlaces',
        'categoryPlaces',
        'placeMarkVisited',
        'markShort',
        'detailsAbout',
        'detailsLocation',
        'detailsWebsiteError',
        'detailsVisitedAdded',
        'detailsVisitedRemoved',
        'detailsMarkAsVisited',
        'visitedLabel',
        'wishlistAdded',
        'wishlistRemoved',
      ];
      expect(expected, hasLength(36));
      for (final code in codes) {
        final raw = File('lib/l10n/app_$code.arb').readAsStringSync();
        final map = jsonDecode(raw) as Map<String, dynamic>;
        for (final key in expected) {
          expect(map[key], isNotNull, reason: 'app_$code.arb missing $key');
          expect(
            map[key],
            isA<String>(),
            reason: 'app_$code.arb $key must be a string',
          );
        }
      }
    });

    test('home/places keys resolve without English placeholders', () {
      expect(
        lookupAppLocalizations(const Locale('bg')).homeCountriesTitle,
        'Държави',
      );
      expect(
        lookupAppLocalizations(const Locale('bg')).homeCountriesCount(1),
        '1 държава',
      );
      expect(
        lookupAppLocalizations(const Locale('bg')).homeCountriesCount(5),
        '5 държави',
      );
      expect(
        lookupAppLocalizations(const Locale('en')).homeCountriesCount(1),
        '1 country',
      );
      expect(
        lookupAppLocalizations(const Locale('ja')).homeCountriesCount(3),
        '3か国',
      );
      expect(
        lookupAppLocalizations(const Locale('zh')).progressCount(2, 10),
        '2 / 10 个国家',
      );
      expect(
        lookupAppLocalizations(const Locale('de')).wishlistAdded('Paris'),
        'Paris zur Wunschliste hinzugefügt',
      );
      expect(
        lookupAppLocalizations(const Locale('fr')).countryAbout('Paris'),
        'À propos de Paris',
      );
    });
  });

  group('categoryLabel', () {
    const identifiers = [
      'Historical Sights',
      'For the Art Lovers',
      'Atmosphere & experience',
      'Hidden Gems',
      'Close by',
      'My places',
    ];

    test('canonical English identifiers stay unchanged in English', () {
      final l10n = lookupAppLocalizations(const Locale('en'));
      for (final id in identifiers) {
        expect(categoryLabel(id, l10n), id);
      }
    });

    test('supported identifiers map to translated labels', () {
      final bg = lookupAppLocalizations(const Locale('bg'));
      expect(categoryLabel('Historical Sights', bg), 'Исторически забележителности');
      expect(categoryLabel('Hidden Gems', bg), 'Скрити съкровища');
      expect(categoryLabel('My places', bg), 'Моите места');
      final ja = lookupAppLocalizations(const Locale('ja'));
      expect(categoryLabel('Close by', ja), '近隣');
      final de = lookupAppLocalizations(const Locale('de'));
      expect(
        categoryLabel('For the Art Lovers', de),
        'Für Kunstliebhaber',
      );
    });

    test('unknown identifiers fall back to the identifier itself', () {
      final bg = lookupAppLocalizations(const Locale('bg'));
      expect(categoryLabel('Unknown Category', bg), 'Unknown Category');
      expect(categoryLabel('', bg), '');
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

    testWidgets('auth strings resolve across locales', (tester) async {
      Future<String> welcomeFor(Locale locale) async {
        String? value;
        await tester.pumpWidget(
          MaterialApp(
            locale: locale,
            supportedLocales: LanguageService.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            home: Builder(
              builder: (context) {
                value = AppLocalizations.of(context).authWelcomeBack;
                return const SizedBox();
              },
            ),
          ),
        );
        await tester.pump();
        return value!;
      }

      expect(await welcomeFor(const Locale('en')), 'Welcome Back');
      expect(await welcomeFor(const Locale('bg')), 'Добре дошли отново');
      expect(await welcomeFor(const Locale('de')), 'Willkommen zurück');
      expect(await welcomeFor(const Locale('ja')), 'おかえりなさい');
      expect(await welcomeFor(const Locale('zh')), '欢迎回来');
    });
  });
}
