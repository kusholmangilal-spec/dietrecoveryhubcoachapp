import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:diet_recovery_hub_coach/main.dart';
import 'package:diet_recovery_hub_coach/state/coach_session.dart';

void main() {
  testWidgets('welcome screen shows brand and coach CTA', (tester) async {
    await tester.pumpWidget(const DietRecoveryHubCoachApp());
    expect(find.text('Diet Recovery Hub'), findsOneWidget);
    expect(find.text('Become a coach'), findsOneWidget);
    expect(find.text('I already have an account'), findsOneWidget);
  });

  testWidgets('demo login opens coach dashboard', (tester) async {
    await tester.pumpWidget(const DietRecoveryHubCoachApp());
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
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => CoachSession(),
        child: const DietRecoveryHubCoachApp(),
      ),
    );
    await tester.tap(find.text('Become a coach'));
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextFormField, 'Full name'), 'Alex Reed');
    await tester.enterText(find.widgetWithText(TextFormField, 'Work email'), 'alex@hub.test');
    await tester.enterText(find.widgetWithText(TextFormField, 'Phone'), '4155550199');
    await tester.enterText(find.widgetWithText(TextFormField, 'Credentials (e.g. RD, RDN, LDN)'), 'RD');
    await tester.enterText(find.widgetWithText(TextFormField, 'License / registration ID'), 'RD-100');
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Short bio for your coach profile'),
      'I help clients rebuild regular eating after years of restriction.',
    );
    await tester.enterText(find.widgetWithText(TextFormField, 'Create password'), 'secret1');

    await tester.ensureVisible(find.text('Submit for admin review'));
    await tester.tap(find.text('Submit for admin review'));
    await tester.pumpAndSettle();

    expect(find.text('Admin verification'), findsOneWidget);
    expect(find.text('Simulate admin approval'), findsOneWidget);
  });
}
