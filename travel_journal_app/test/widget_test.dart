// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package.

import 'package:flutter_test/flutter_test.dart';

import 'package:pinmap_travel_journal/main.dart';

void main() {
  testWidgets('App builds and displays the splash screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TravelJournalApp());
    await tester.pump();

    // Verify that the app title is displayed.
    expect(find.text('PinMap'), findsOneWidget);
    expect(find.text('Travel journal'), findsOneWidget);
  });
}
