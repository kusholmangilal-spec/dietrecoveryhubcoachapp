import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../state/coach_session.dart';
import '../theme/app_theme.dart';
import '../widgets/ui.dart';
import 'login_screen.dart';

class AdminVerificationScreen extends StatelessWidget {
  const AdminVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.watch<CoachSession>();
    final coach = session.coach;
    final status = coach?.verificationStatus ?? VerificationStatus.pending;

    return Scaffold(
      appBar: AppBar(title: const Text('Admin verification')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          const ScreenHeader(
            title: 'Almost there',
            subtitle: 'A hub admin confirms your license before you can coach clients.',
          ),
          SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColors.mist,
                      child: Text(
                        _initials(coach?.fullName ?? 'C'),
                        style: const TextStyle(color: AppColors.forest, fontWeight: FontWeight.w800),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(coach?.fullName ?? 'New coach', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                          Text(coach?.email ?? '', style: const TextStyle(color: AppColors.muted)),
                        ],
                      ),
                    ),
                    StatusChip(label: _label(status), color: _color(status)),
                  ],
                ),
                const SizedBox(height: 18),
                _CheckRow(done: true, label: 'Application submitted'),
                _CheckRow(done: status != VerificationStatus.pending, label: 'Credentials in review'),
                _CheckRow(done: status == VerificationStatus.approved, label: 'Admin approval'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('What happens next', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                const SizedBox(height: 8),
                Text(
                  'We typically verify licenses within one business day. You will be able to sign in as soon as your status is Approved.',
                  style: TextStyle(color: AppColors.muted.withValues(alpha: 0.95), height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (status != VerificationStatus.approved) ...[
            OutlinedButton(
              onPressed: session.markUnderReview,
              child: const Text('Check review status'),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: session.approveCoach,
              child: const Text('Simulate admin approval'),
            ),
          ] else
            FilledButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => route.isFirst,
                );
              },
              child: const Text('Continue to login'),
            ),
        ],
      ),
    );
  }

  static String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    return parts.take(2).map((p) => p[0].toUpperCase()).join();
  }

  static String _label(VerificationStatus status) {
    return switch (status) {
      VerificationStatus.pending => 'Pending',
      VerificationStatus.underReview => 'In review',
      VerificationStatus.approved => 'Approved',
      VerificationStatus.rejected => 'Rejected',
    };
  }

  static Color _color(VerificationStatus status) {
    return switch (status) {
      VerificationStatus.pending => AppColors.gold,
      VerificationStatus.underReview => Colors.blue.shade700,
      VerificationStatus.approved => AppColors.forest,
      VerificationStatus.rejected => AppColors.terracotta,
    };
  }
}

class _CheckRow extends StatelessWidget {
  const _CheckRow({required this.done, required this.label});

  final bool done;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            done ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
            color: done ? AppColors.forest : AppColors.sage,
          ),
          const SizedBox(width: 10),
          Text(label, style: TextStyle(fontWeight: done ? FontWeight.w700 : FontWeight.w500)),
        ],
      ),
    );
  }
}
