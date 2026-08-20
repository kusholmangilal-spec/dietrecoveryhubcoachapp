import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/coach_session.dart';
import '../theme/app_theme.dart';
import '../widgets/ui.dart';
import 'clients_screen.dart';
import 'consultations_screen.dart';
import 'diet_plans_screen.dart';
import 'meal_reviews_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';
import 'progress_screen.dart';
import 'reports_screen.dart';
import 'welcome_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.watch<CoachSession>();
    final firstName = (session.coach?.fullName ?? 'Coach').split(' ').first;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, MediaQuery.paddingOf(context).top + 16, 20, 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.forestDeep, AppColors.forest],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const BrandMark(size: 48),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Coach dashboard',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _open(context, const NotificationsScreen()),
                        icon: Badge(
                          isLabelVisible: session.unreadCount > 0,
                          label: Text('${session.unreadCount}'),
                          child: const Icon(Icons.notifications_outlined, color: Colors.white),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          session.logout();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                            (route) => false,
                          );
                        },
                        icon: const Icon(Icons.logout_rounded, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Text('Good to see you, $firstName', style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Text(
                    'Keep recovery gentle, consistent, and close.',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.82)),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      _StatPill(label: 'Clients', value: '${session.clients.length}'),
                      const SizedBox(width: 8),
                      _StatPill(label: 'Reviews', value: '${session.pendingMealCount}'),
                      const SizedBox(width: 8),
                      _StatPill(label: 'Sessions', value: '${session.upcomingConsults}'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.05,
              children: [
                _ModuleTile(
                  icon: Icons.groups_rounded,
                  title: 'My Clients',
                  subtitle: '${session.clients.length} active',
                  onTap: () => _open(context, const ClientsScreen()),
                ),
                _ModuleTile(
                  icon: Icons.restaurant_rounded,
                  title: 'Pending Meal Reviews',
                  subtitle: '${session.pendingMealCount} waiting',
                  accent: AppColors.terracotta,
                  onTap: () => _open(context, const MealReviewsScreen()),
                ),
                _ModuleTile(
                  icon: Icons.menu_book_rounded,
                  title: 'Diet Plans',
                  subtitle: '${session.plans.length} templates',
                  onTap: () => _open(context, const DietPlansScreen()),
                ),
                _ModuleTile(
                  icon: Icons.trending_up_rounded,
                  title: 'Client Progress',
                  subtitle: 'Weekly trends',
                  onTap: () => _open(context, const ProgressScreen()),
                ),
                _ModuleTile(
                  icon: Icons.insights_rounded,
                  title: 'Reports',
                  subtitle: 'Caseload snapshot',
                  onTap: () => _open(context, const ReportsScreen()),
                ),
                _ModuleTile(
                  icon: Icons.event_available_rounded,
                  title: 'Consultations',
                  subtitle: '${session.upcomingConsults} upcoming',
                  onTap: () => _open(context, const ConsultationsScreen()),
                ),
                _ModuleTile(
                  icon: Icons.notifications_active_rounded,
                  title: 'Notifications',
                  subtitle: '${session.unreadCount} unread',
                  onTap: () => _open(context, const NotificationsScreen()),
                ),
                _ModuleTile(
                  icon: Icons.person_rounded,
                  title: 'Profile',
                  subtitle: session.coach?.credentials ?? 'Coach',
                  onTap: () => _open(context, const ProfileScreen()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void _open(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
            Text(label, style: TextStyle(color: Colors.white.withValues(alpha: 0.75), fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _ModuleTile extends StatelessWidget {
  const _ModuleTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.accent = AppColors.forest,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: accent.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(14)),
            child: Icon(icon, color: accent),
          ),
          const Spacer(),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, height: 1.2)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: AppColors.muted, fontSize: 13)),
        ],
      ),
    );
  }
}
