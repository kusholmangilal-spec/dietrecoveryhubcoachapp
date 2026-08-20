import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/coach_session.dart';
import '../theme/app_theme.dart';
import '../widgets/ui.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController(text: CoachSession.demoEmail);
  final _password = TextEditingController();
  String? _error;
  bool _obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    final error = context.read<CoachSession>().login(_email.text, _password.text);
    if (error != null) {
      setState(() => _error = error);
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const DashboardScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coach login')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          const ScreenHeader(
            title: 'Welcome back',
            subtitle: 'Sign in to review meals, plans, and client progress.',
          ),
          SoftCard(
            child: Column(
              children: [
                TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _password,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => _obscure = !_obscure),
                      icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                    ),
                  ),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(_error!, style: const TextStyle(color: AppColors.terracotta, fontWeight: FontWeight.w600)),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(onPressed: _submit, child: const Text('Sign in')),
          const SizedBox(height: 16),
          SoftCard(
            child: Text(
              'Demo coach: ${CoachSession.demoEmail}\nPassword: ${CoachSession.demoPassword}',
              style: const TextStyle(color: AppColors.muted, height: 1.45),
            ),
          ),
        ],
      ),
    );
  }
}
