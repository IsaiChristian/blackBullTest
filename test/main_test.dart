import 'package:black_bull/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('MyApp displays API key in AppBar title', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('TEST_API_KEY'), findsOneWidget);
    expect(find.byType(MyHomePage), findsOneWidget);
  });

  testWidgets('Counter increments when FAB is tapped', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    // Initial counter value
    expect(find.text('0'), findsOneWidget);

    // Tap the FloatingActionButton
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    // Counter should increment
    expect(find.text('1'), findsOneWidget);
  });
}
