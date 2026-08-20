import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../state/coach_session.dart';
import '../theme/app_theme.dart';
import '../widgets/ui.dart';

class ConsultationsScreen extends StatelessWidget {
  const ConsultationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = context.watch<CoachSession>().consultations;
    return Scaffold(
      appBar: AppBar(title: const Text('Consultations')),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          const ScreenHeader(
            title: 'Sessions',
            subtitle: 'Upcoming and completed check-ins with your clients.',
          ),
          for (final item in items)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: SoftCard(
                child: Row(
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: AppColors.mist,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        item.mode == 'Video' ? Icons.videocam_rounded : Icons.phone_rounded,
                        color: AppColors.forest,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.clientName, style: const TextStyle(fontWeight: FontWeight.w800)),
                          Text(item.topic, style: const TextStyle(color: AppColors.muted)),
                          Text(
                            DateFormat.MMMd().add_jm().format(item.startsAt),
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    StatusChip(
                      label: item.status == ConsultationStatus.upcoming ? 'Upcoming' : 'Done',
                      color: item.status == ConsultationStatus.upcoming ? AppColors.gold : AppColors.forest,
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
