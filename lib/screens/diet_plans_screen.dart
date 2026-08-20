import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/coach_session.dart';
import '../theme/app_theme.dart';
import '../widgets/ui.dart';

class DietPlansScreen extends StatelessWidget {
  const DietPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plans = context.watch<CoachSession>().plans;
    return Scaffold(
      appBar: AppBar(title: const Text('Diet Plans')),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          const ScreenHeader(
            title: 'Plan library',
            subtitle: 'Restorative templates you can assign and adapt per client.',
          ),
          for (final plan in plans)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: SoftCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(plan.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                    const SizedBox(height: 4),
                    Text(plan.focus, style: const TextStyle(color: AppColors.muted)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final h in plan.highlights)
                          StatusChip(label: h, color: AppColors.forest),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      '${plan.durationWeeks} weeks · ~${plan.dailyCalories} kcal/day starting point · ${plan.assignedClients} clients',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
