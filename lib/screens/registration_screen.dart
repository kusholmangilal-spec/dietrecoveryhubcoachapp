import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../state/coach_session.dart';
import '../theme/app_theme.dart';
import '../widgets/ui.dart';
import 'admin_verification_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _credentials = TextEditingController();
  final _license = TextEditingController();
  final _bio = TextEditingController();
  final _password = TextEditingController();
  String _specialization = 'Diet recovery & metabolic restoration';
  int _years = 3;

  static const _specialties = [
    'Diet recovery & metabolic restoration',
    'Disordered eating support',
    'Sports nutrition',
    'Clinical nutrition',
    'Plant-based recovery',
  ];

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _credentials.dispose();
    _license.dispose();
    _bio.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final profile = CoachProfile(
      fullName: _name.text.trim(),
      email: _email.text.trim(),
      phone: _phone.text.trim(),
      credentials: _credentials.text.trim(),
      specialization: _specialization,
      yearsExperience: _years,
      licenseId: _license.text.trim(),
      bio: _bio.text.trim(),
      verificationStatus: VerificationStatus.pending,
    );
    context.read<CoachSession>().register(profile, _password.text);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const AdminVerificationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coach registration')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            const ScreenHeader(
              title: 'Join the hub',
              subtitle: 'Admins review credentials before coaches can access client data.',
            ),
            SoftCard(
              child: Column(
                children: [
                  TextFormField(
                    controller: _name,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(labelText: 'Full name'),
                    validator: (v) => v == null || v.trim().length < 3 ? 'Enter your name' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Work email'),
                    validator: (v) => v == null || !v.contains('@') ? 'Enter a valid email' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _phone,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(labelText: 'Phone'),
                    validator: (v) => v == null || v.trim().length < 7 ? 'Enter a phone number' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _credentials,
                    decoration: const InputDecoration(labelText: 'Credentials (e.g. RD, RDN, LDN)'),
                    validator: (v) => v == null || v.trim().isEmpty ? 'Add your credentials' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _license,
                    decoration: const InputDecoration(labelText: 'License / registration ID'),
                    validator: (v) => v == null || v.trim().isEmpty ? 'License ID is required' : null,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: _specialization,
                    items: [
                      for (final item in _specialties)
                        DropdownMenuItem(value: item, child: Text(item, overflow: TextOverflow.ellipsis)),
                    ],
                    onChanged: (v) => setState(() => _specialization = v ?? _specialization),
                    decoration: const InputDecoration(labelText: 'Specialization'),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text('Years of experience', style: TextStyle(color: AppColors.muted)),
                      const Spacer(),
                      Text('$_years', style: const TextStyle(fontWeight: FontWeight.w800)),
                    ],
                  ),
                  Slider(
                    value: _years.toDouble(),
                    min: 1,
                    max: 30,
                    divisions: 29,
                    label: '$_years',
                    onChanged: (v) => setState(() => _years = v.round()),
                  ),
                  TextFormField(
                    controller: _bio,
                    maxLines: 4,
                    decoration: const InputDecoration(labelText: 'Short bio for your coach profile'),
                    validator: (v) => v == null || v.trim().length < 20 ? 'Write a short bio (20+ characters)' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _password,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Create password'),
                    validator: (v) => v == null || v.length < 6 ? 'Use at least 6 characters' : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(onPressed: _submit, child: const Text('Submit for admin review')),
          ],
        ),
      ),
    );
  }
}
