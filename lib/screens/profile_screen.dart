import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/coach_session.dart';
import '../theme/app_theme.dart';
import '../widgets/ui.dart';
import 'welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _phone;
  late final TextEditingController _bio;
  late final TextEditingController _spec;

  @override
  void initState() {
    super.initState();
    final coach = context.read<CoachSession>().coach;
    _phone = TextEditingController(text: coach?.phone ?? '');
    _bio = TextEditingController(text: coach?.bio ?? '');
    _spec = TextEditingController(text: coach?.specialization ?? '');
  }

  @override
  void dispose() {
    _phone.dispose();
    _bio.dispose();
    _spec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<CoachSession>();
    final coach = session.coach;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          SoftCard(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: AppColors.mist,
                  foregroundColor: AppColors.forest,
                  child: Text(
                    (coach?.fullName ?? 'C')[0],
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(height: 12),
                Text(coach?.fullName ?? 'Coach', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 22)),
                Text('${coach?.credentials ?? ''} · ${coach?.licenseId ?? ''}', style: const TextStyle(color: AppColors.muted)),
                const SizedBox(height: 8),
                StatusChip(label: 'Verified coach', color: AppColors.forest),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SoftCard(
            child: Column(
              children: [
                TextField(controller: _phone, decoration: const InputDecoration(labelText: 'Phone')),
                const SizedBox(height: 12),
                TextField(controller: _spec, decoration: const InputDecoration(labelText: 'Specialization')),
                const SizedBox(height: 12),
                TextField(controller: _bio, maxLines: 4, decoration: const InputDecoration(labelText: 'Bio')),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {
              session.updateProfile(phone: _phone.text, bio: _bio.text, specialization: _spec.text);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile saved')));
            },
            child: const Text('Save profile'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {
              session.logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                (route) => false,
              );
            },
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
  }
}
