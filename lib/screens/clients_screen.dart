import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../state/coach_session.dart';
import '../theme/app_theme.dart';
import '../widgets/ui.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final clients = context.watch<CoachSession>().clients;
    return Scaffold(
      appBar: AppBar(title: const Text('My Clients')),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          const ScreenHeader(
            title: 'Caseload',
            subtitle: 'People currently in your recovery studio.',
          ),
          for (final client in clients)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: SoftCard(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ClientDetailScreen(client: client)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.mist,
                          foregroundColor: AppColors.forest,
                          child: Text(client.name[0]),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(client.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                              Text(client.goal, style: const TextStyle(color: AppColors.muted)),
                            ],
                          ),
                        ),
                        StatusChip(
                          label: client.status,
                          color: client.status == 'Needs support' || client.status == 'Watch'
                              ? AppColors.terracotta
                              : AppColors.forest,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    LinearProgressIndicator(
                      value: client.adherence / 100,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.forest,
                      backgroundColor: AppColors.mist,
                    ),
                    const SizedBox(height: 8),
                    Text('${client.adherence}% meal adherence · ${client.plan}'),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ClientDetailScreen extends StatelessWidget {
  const ClientDetailScreen({super.key, required this.client});

  final Client client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(client.name)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(client.goal, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
                const SizedBox(height: 6),
                Text('Plan: ${client.plan}', style: const TextStyle(color: AppColors.muted)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _Mini(label: 'Energy', value: '${client.energyScore}/10'),
                    _Mini(label: 'Meals logged', value: '${client.mealsLogged}'),
                    _Mini(label: 'Last check-in', value: DateFormat.MMMd().add_jm().format(client.lastCheckIn)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Coach notes', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                const SizedBox(height: 8),
                Text(client.notes, style: const TextStyle(height: 1.45)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Mini extends StatelessWidget {
  const _Mini({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: AppColors.muted, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
        ],
      ),
    );
  }
}
