import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:diet_recovery_hub_coach/main.dart';
import 'package:diet_recovery_hub_coach/state/coach_session.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 2600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const DietRecoveryHubCoachApp());
  }

  testWidgets('welcome screen shows brand and coach CTA', (tester) async {
    await pumpApp(tester);
    expect(find.text('Diet Recovery Hub'), findsOneWidget);
    expect(find.text('Become a coach'), findsOneWidget);
    expect(find.text('I already have an account'), findsOneWidget);
  });

  testWidgets('demo login opens coach dashboard', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('I already have an account'));
    await tester.pumpAndSettle();

    expect(find.text('Coach login'), findsOneWidget);
    await tester.enterText(find.byType(TextField).at(1), CoachSession.demoPassword);
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();

    expect(find.text('Coach dashboard'), findsOneWidget);
    expect(find.text('My Clients'), findsOneWidget);
    expect(find.text('Pending Meal Reviews'), findsOneWidget);
    expect(find.text('Diet Plans'), findsOneWidget);
    expect(find.text('Client Progress'), findsOneWidget);
    expect(find.text('Reports'), findsOneWidget);
    expect(find.text('Consultations'), findsOneWidget);
    expect(find.text('Notifications'), findsWidgets);
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('registration moves to admin verification', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('Become a coach'));
    await tester.pumpAndSettle();

    Future<void> fill(String label, String value) async {
      final field = find.widgetWithText(TextFormField, label);
      await tester.scrollUntilVisible(field, 200, scrollable: find.byType(Scrollable).first);
      await tester.enterText(field, value);
    }

    await fill('Full name', 'Alex Reed');
    await fill('Work email', 'alex@hub.test');
    await fill('Phone', '4155550199');
    await fill('Credentials (e.g. RD, RDN, LDN)', 'RD');
    await fill('License / registration ID', 'RD-100');
    await fill('Short bio for your coach profile', 'I help clients rebuild regular eating after years of restriction.');
    await fill('Create password', 'secret1');

    final submit = find.text('Submit for admin review');
    await tester.scrollUntilVisible(submit, 300, scrollable: find.byType(Scrollable).first);
    await tester.tap(submit);
    await tester.pumpAndSettle();

    expect(find.text('Admin verification'), findsOneWidget);
    expect(find.text('Simulate admin approval'), findsOneWidget);
  });
}
