import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/welcome_screen.dart';
import 'state/coach_session.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const DietRecoveryHubCoachApp());
}

class DietRecoveryHubCoachApp extends StatelessWidget {
  const DietRecoveryHubCoachApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CoachSession(),
      child: MaterialApp(
        title: 'Diet Recovery Hub Coach',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: const WelcomeScreen(),
      ),
    );
  }
}
