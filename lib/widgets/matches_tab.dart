import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/database_provider.dart';
import '../providers/meet_detail_providers.dart';
import 'edit_match_players_dialog.dart';
import 'player_avatar.dart';
import 'score_entry_dialog.dart';
import 'section_header.dart';

class MatchesTab extends ConsumerWidget {
  final int meetId;
  final int courtCount;

  const MatchesTab({super.key, required this.meetId, required this.courtCount});

  Future<void> _generate(BuildContext context, WidgetRef ref) async {
    final count = await ref.read(databaseProvider).generateMatches(meetId, courtCount);
    if (!context.mounted) return;
    final message = count == 0
        ? 'No matches generated — need at least 4 checked-in players on a free court.'
        : 'Generated $count match${count == 1 ? '' : 'es'}.';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchViewsAsync = ref.watch(matchViewsProvider(meetId));

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => _generate(context, ref),
                icon: const Icon(Icons.shuffle),
                label: const Text('Generate matches'),
              ),
            ),
          ),
          Expanded(
            child: matchViewsAsync.when(
              data: (matches) {
                if (matches.isEmpty) {
                  return _EmptyState(
                    icon: Icons.sports_tennis,
                    text: 'No matches yet.\nCheck players in, then generate matches.',
                  );
                }
                final pending =
                    matches.where((m) => m.match.status == 'pending').toList();
                final completed = matches
                    .where((m) => m.match.status == 'completed')
                    .toList()
                    .reversed
                    .toList();

                return ListView(
                  padding: const EdgeInsets.only(bottom: 24),
                  children: [
                    if (pending.isNotEmpty) ...[
                      const SectionHeader('Ongoing'),
                      for (final match in pending) _MatchCard(meetId: meetId, view: match),
                    ],
                    if (completed.isNotEmpty) ...[
                      const SectionHeader('Completed'),
                      for (final match in completed) _MatchCard(meetId: meetId, view: match),
                    ],
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String text;

  const _EmptyState({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: theme.colorScheme.outline),
            const SizedBox(height: 12),
            Text(
              text,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
            ),
          ],
        ),
      ),
    );
  }
}

class _MatchCard extends StatelessWidget {
  final int meetId;
  final MatchView view;

  const _MatchCard({required this.meetId, required this.view});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final match = view.match;
    final isCompleted = match.status == 'completed';
    final team1Won = isCompleted && (match.team1Score ?? 0) > (match.team2Score ?? 0);
    final team2Won = isCompleted && (match.team2Score ?? 0) > (match.team1Score ?? 0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Material(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: isCompleted
              ? null
              : () => showDialog(
                    context: context,
                    builder: (context) => ScoreEntryDialog(view: view),
                  ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Court ${match.courtNumber}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (!isCompleted)
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) =>
                              EditMatchPlayersDialog(meetId: meetId, view: view),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(Icons.edit_outlined,
                              size: 16, color: theme.colorScheme.outline),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _TeamColumn(
                        player1: view.team1Player1.name,
                        player2: view.team1Player2.name,
                        won: team1Won,
                      ),
                    ),
                    SizedBox(
                      width: 64,
                      child: Text(
                        isCompleted ? '${match.team1Score} – ${match.team2Score}' : 'vs',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: _TeamColumn(
                        player1: view.team2Player1.name,
                        player2: view.team2Player2.name,
                        won: team2Won,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TeamColumn extends StatelessWidget {
  final String player1;
  final String player2;
  final bool won;

  const _TeamColumn({required this.player1, required this.player2, required this.won});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PlayerAvatar(name: player1, radius: 14),
            const SizedBox(width: 4),
            PlayerAvatar(name: player2, radius: 14),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          '$player1 & $player2',
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: won ? FontWeight.bold : FontWeight.normal,
            color: won ? theme.colorScheme.primary : null,
          ),
        ),
      ],
    );
  }
}
