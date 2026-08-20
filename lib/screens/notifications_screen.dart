import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../state/coach_session.dart';
import '../theme/app_theme.dart';
import '../widgets/ui.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.watch<CoachSession>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: session.markAllNotificationsRead,
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          const ScreenHeader(
            title: 'Inbox',
            subtitle: 'Meals, sessions, and weekly reports that need your eye.',
          ),
          for (final item in session.notifications)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: SoftCard(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: item.read ? const Color(0xFFEEF2F0) : AppColors.mist,
                      foregroundColor: AppColors.forest,
                      child: Icon(item.read ? Icons.notifications_none : Icons.notifications_active),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.title, style: const TextStyle(fontWeight: FontWeight.w800)),
                          const SizedBox(height: 4),
                          Text(item.body, style: const TextStyle(color: AppColors.muted, height: 1.4)),
                          const SizedBox(height: 8),
                          Text(
                            '${item.category} · ${DateFormat.MMMd().add_jm().format(item.createdAt)}',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
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
