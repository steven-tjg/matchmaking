import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../providers/meets_providers.dart';
import 'meet_detail_screen.dart';
import 'meet_form_screen.dart';
import 'roster_screen.dart';

class MeetsListScreen extends ConsumerWidget {
  const MeetsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meetsAsync = ref.watch(meetsListProvider);
    final dateFormat = DateFormat('EEE, MMM d • h:mm a');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Matchmaking'),
        actions: [
          IconButton(
            icon: const Icon(Icons.people_outline),
            tooltip: 'Player roster',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const RosterScreen()),
            ),
          ),
        ],
      ),
      body: meetsAsync.when(
        data: (meets) {
          if (meets.isEmpty) {
            return const Center(
              child: Text('No meets yet.\nTap + to create your first one.', textAlign: TextAlign.center),
            );
          }
          return ListView.builder(
            itemCount: meets.length,
            itemBuilder: (context, index) {
              final meet = meets[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(meet.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    '${dateFormat.format(meet.scheduledAt)}\n${meet.location} • ${meet.courtCount} court${meet.courtCount > 1 ? 's' : ''}',
                  ),
                  isThreeLine: true,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MeetDetailScreen(meetId: meet.id),
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const MeetFormScreen()),
        ),
        icon: const Icon(Icons.add),
        label: const Text('New meet'),
      ),
    );
  }
}
