import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/meet_detail_providers.dart';

class StatsTab extends ConsumerWidget {
  final int meetId;

  const StatsTab({super.key, required this.meetId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final participantsAsync = ref.watch(participantsProvider(meetId));

    return participantsAsync.when(
      data: (participants) {
        if (participants.isEmpty) {
          return const Center(child: Text('No participants yet.'));
        }
        final sorted = [...participants]..sort((a, b) {
            final byGames = b.participant.gamesPlayed.compareTo(a.participant.gamesPlayed);
            if (byGames != 0) return byGames;
            return a.player.name.compareTo(b.player.name);
          });
        final maxGames = sorted.first.participant.gamesPlayed;

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: sorted.length,
          itemBuilder: (context, index) {
            final entry = sorted[index];
            final games = entry.participant.gamesPlayed;
            return ListTile(
              title: Text(entry.player.name),
              subtitle: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: maxGames == 0 ? 0 : games / maxGames,
                  minHeight: 6,
                ),
              ),
              trailing: Text(
                '$games game${games == 1 ? '' : 's'}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
