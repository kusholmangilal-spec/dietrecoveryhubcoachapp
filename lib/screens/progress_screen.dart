import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/coach_session.dart';
import '../theme/app_theme.dart';
import '../widgets/ui.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = context.watch<CoachSession>().progress;
    return Scaffold(
      appBar: AppBar(title: const Text('Client Progress')),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          const ScreenHeader(
            title: 'Trends',
            subtitle: 'Track consistency, energy, and exposures — not just the scale.',
          ),
          for (final item in items)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: SoftCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.clientName, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                    Text(item.metric, style: const TextStyle(color: AppColors.muted)),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 92,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          for (final point in item.points)
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: FractionallySizedBox(
                                          heightFactor: (point.value / 20).clamp(0.15, 1),
                                          widthFactor: 1,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: AppColors.forest.withValues(alpha: 0.75),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(point.label, style: const TextStyle(fontSize: 11, color: AppColors.muted)),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(item.trend, style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.forest)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
