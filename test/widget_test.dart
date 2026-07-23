import 'package:eqms/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('UserHomepage loads correctly smoke test (Light Theme)', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.text('Afsal VN'), findsOneWidget);
    expect(find.text('QA Analyst'), findsOneWidget);
    expect(find.text('Inspection Form'), findsOneWidget);
    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Line Inspection'), findsOneWidget);
    expect(find.text('Lab Inspection'), findsOneWidget);
  });

  testWidgets('UserHomepage loads correctly in Dark Theme', (WidgetTester tester) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.text('Afsal VN'), findsOneWidget);
    expect(find.text('QA Analyst'), findsOneWidget);
    expect(find.text('Inspection Form'), findsOneWidget);
    expect(find.text('Dashboard'), findsOneWidget);
  });
}
