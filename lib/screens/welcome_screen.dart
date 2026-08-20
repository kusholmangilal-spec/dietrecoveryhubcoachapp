import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/welcome_illustration.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontal = width < 360 ? 18.0 : 24.0;
    final headlineSize = width < 360 ? 28.0 : 32.0;

    return Scaffold(
      backgroundColor: AppColors.parchment,
      body: Stack(
        children: [
          const Positioned.fill(child: WelcomeBackdrop()),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(horizontal, 18, horizontal, 20),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight - 38),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Image.asset(
                          'assets/images/diet_recovery_hub_logo.png',
                          height: width < 360 ? 72 : 88,
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high,
                          semanticLabel: 'Diet Recovery Hub logo',
                        ),
                        SizedBox(height: width < 360 ? 20 : 28),
                        Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontFamily: 'serif',
                              fontSize: headlineSize,
                              fontWeight: FontWeight.w700,
                              height: 1.22,
                              color: AppColors.forestDeep,
                            ),
                            children: const [
                              TextSpan(text: 'Help people heal\n'),
                              TextSpan(text: 'their '),
                              TextSpan(
                                text: 'health with food.',
                                style: TextStyle(color: Color(0xFF3E8F6F)),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 14),
                        const _HeadlineDivider(),
                        const SizedBox(height: 14),
                        const Text(
                          'Create personalized recovery plans.\n'
                          'Schedule consultations, manage clients,\n'
                          'and track progress.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 15,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 18),
                        const WelcomeConsultationIllustration(),
                        const SizedBox(height: 18),
                        const _FeatureStrip(),
                        const SizedBox(height: 22),
                        _WelcomePrimaryButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const RegistrationScreen()),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        _WelcomeSecondaryButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const LoginScreen()),
                            );
                          },
                        ),
                        const SizedBox(height: 18),
                        const _TrustMessage(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _HeadlineDivider extends StatelessWidget {
  const _HeadlineDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.forest.withValues(alpha: 0.18), indent: 36)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(Icons.favorite_rounded, size: 14, color: AppColors.forest),
        ),
        Expanded(child: Divider(color: AppColors.forest.withValues(alpha: 0.18), endIndent: 36)),
      ],
    );
  }
}

class _FeatureStrip extends StatelessWidget {
  const _FeatureStrip();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFE4F0E6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 6),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: _FeatureCell(
                  icon: Icons.calendar_month_rounded,
                  label: 'Schedule\nConsultations',
                ),
              ),
              VerticalDivider(width: 1, thickness: 1, color: Color(0xFFC5D9C8)),
              Expanded(
                child: _FeatureCell(
                  icon: Icons.groups_rounded,
                  label: 'Manage\nClients',
                ),
              ),
              VerticalDivider(width: 1, thickness: 1, color: Color(0xFFC5D9C8)),
              Expanded(
                child: _FeatureCell(
                  icon: Icons.trending_up_rounded,
                  label: 'Track\nProgress',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureCell extends StatelessWidget {
  const _FeatureCell({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.forestDeep, size: 26),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.forestDeep,
            fontWeight: FontWeight.w700,
            fontSize: 12,
            height: 1.25,
          ),
        ),
      ],
    );
  }
}

class _WelcomePrimaryButton extends StatelessWidget {
  const _WelcomePrimaryButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.forest,
          foregroundColor: Colors.white,
          elevation: 6,
          shadowColor: AppColors.forest.withValues(alpha: 0.38),
          shape: const StadiumBorder(),
        ),
        child: const Row(
          children: [
            Icon(Icons.eco_rounded, size: 22),
            Expanded(
              child: Text(
                'Become a Coach',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
              ),
            ),
            Icon(Icons.arrow_forward_rounded, size: 20),
          ],
        ),
      ),
    );
  }
}

class _WelcomeSecondaryButton extends StatelessWidget {
  const _WelcomeSecondaryButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white.withValues(alpha: 0.72),
          foregroundColor: AppColors.forest,
          elevation: 0,
          side: const BorderSide(color: AppColors.forest, width: 1.4),
          shape: const StadiumBorder(),
        ),
        child: const Row(
          children: [
            Icon(Icons.person_outline_rounded, size: 22),
            Expanded(
              child: Text(
                'I already have an account',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
            ),
            Icon(Icons.arrow_forward_rounded, size: 20),
          ],
        ),
      ),
    );
  }
}

class _TrustMessage extends StatelessWidget {
  const _TrustMessage();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.verified_user_rounded, size: 16, color: AppColors.forest),
        SizedBox(width: 8),
        Flexible(
          child: Text.rich(
            TextSpan(
              style: TextStyle(color: AppColors.muted, fontSize: 12.5, height: 1.35),
              children: [
                TextSpan(text: 'Trusted care. '),
                TextSpan(
                  text: 'Better health.',
                  style: TextStyle(color: Color(0xFF3E8F6F), fontWeight: FontWeight.w700),
                ),
                TextSpan(text: ' One step at a time.'),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
