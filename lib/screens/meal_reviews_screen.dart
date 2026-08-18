import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../state/coach_session.dart';
import '../theme/app_theme.dart';
import '../widgets/ui.dart';

class MealReviewsScreen extends StatelessWidget {
  const MealReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.watch<CoachSession>();
    final pending = session.meals.where((m) => m.status == MealReviewStatus.pending).toList();
    final others = session.meals.where((m) => m.status != MealReviewStatus.pending).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Pending Meal Reviews')),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          const ScreenHeader(
            title: 'Meal inbox',
            subtitle: 'Respond with warmth. Recovery meals are about sufficiency, not perfection.',
          ),
          if (pending.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SoftCard(child: Text('No meals waiting. Nice work staying current.')),
            ),
          for (final meal in pending) _MealCard(meal: meal, actionable: true),
          if (others.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: Text('Recently reviewed', style: TextStyle(fontWeight: FontWeight.w800)),
            ),
            for (final meal in others) _MealCard(meal: meal, actionable: false),
          ],
        ],
      ),
    );
  }
}

class _MealCard extends StatelessWidget {
  const _MealCard({required this.meal, required this.actionable});

  final MealReview meal;
  final bool actionable;

  @override
  Widget build(BuildContext context) {
    final session = context.read<CoachSession>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: SoftCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(meal.clientName, style: const TextStyle(fontWeight: FontWeight.w800)),
                ),
                StatusChip(
                  label: meal.status == MealReviewStatus.pending
                      ? 'Pending'
                      : meal.status == MealReviewStatus.approved
                          ? 'Approved'
                          : 'Needs changes',
                  color: meal.status == MealReviewStatus.needsChanges
                      ? AppColors.terracotta
                      : AppColors.forest,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(meal.mealName, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            Text(
              '${DateFormat.MMMd().add_jm().format(meal.loggedAt)} · ~${meal.calories} kcal',
              style: const TextStyle(color: AppColors.muted, fontSize: 13),
            ),
            const SizedBox(height: 10),
            Text(meal.notes, style: const TextStyle(height: 1.4)),
            if (actionable) ...[
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => session.updateMeal(meal.id, MealReviewStatus.needsChanges),
                      child: const Text('Needs changes'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => session.updateMeal(meal.id, MealReviewStatus.approved),
                      child: const Text('Approve'),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
