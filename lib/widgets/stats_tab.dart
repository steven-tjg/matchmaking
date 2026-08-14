import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/meet_detail_providers.dart';
import 'player_avatar.dart';

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
        final theme = Theme.of(context);

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          itemCount: sorted.length,
          itemBuilder: (context, index) {
            final entry = sorted[index];
            final games = entry.participant.gamesPlayed;
            final isTopRank = maxGames > 0 && games == maxGames;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Row(
                children: [
                  SizedBox(
                    width: 28,
                    child: Text(
                      '${index + 1}',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.outline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  PlayerAvatar(name: entry.player.name),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(entry.player.name, style: theme.textTheme.titleSmall),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: maxGames == 0 ? 0 : games / maxGames,
                            minHeight: 6,
                            backgroundColor: theme.colorScheme.surfaceContainerHighest,
                            color: isTopRank ? theme.colorScheme.tertiary : theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '$games',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
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
