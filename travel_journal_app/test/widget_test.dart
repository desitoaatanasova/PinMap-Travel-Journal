// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package.

import 'package:flutter_test/flutter_test.dart';

import 'package:travel_journal_app/main.dart';

void main() {
  testWidgets('App builds and displays Travel Journal', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TravelJournalApp());

    // Verify that the app title is displayed.
    expect(find.text('Travel Journal'), findsWidgets);
  });
}
