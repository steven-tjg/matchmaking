import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/database_provider.dart';
import '../providers/meet_detail_providers.dart';
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
                  return const Center(
                    child: Text(
                      'No matches yet.\nCheck players in, then generate matches.',
                      textAlign: TextAlign.center,
                    ),
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
                  children: [
                    if (pending.isNotEmpty) ...[
                      const SectionHeader('Ongoing'),
                      for (final match in pending) _MatchCard(view: match),
                    ],
                    if (completed.isNotEmpty) ...[
                      const SectionHeader('Completed'),
                      for (final match in completed) _MatchCard(view: match),
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

class _MatchCard extends StatelessWidget {
  final MatchView view;

  const _MatchCard({required this.view});

  @override
  Widget build(BuildContext context) {
    final match = view.match;
    final isCompleted = match.status == 'completed';
    final scoreText =
        isCompleted ? '${match.team1Score} - ${match.team2Score}' : 'vs';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(child: Text('${match.courtNumber}')),
        title: Text('${view.team1Player1.name} & ${view.team1Player2.name}'),
        subtitle: Text('${view.team2Player1.name} & ${view.team2Player2.name}'),
        trailing: Text(scoreText, style: Theme.of(context).textTheme.titleMedium),
        onTap: isCompleted
            ? null
            : () => showDialog(
                  context: context,
                  builder: (context) => ScoreEntryDialog(view: view),
                ),
      ),
    );
  }
}
