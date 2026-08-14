import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../providers/database_provider.dart';
import '../providers/meet_detail_providers.dart';
import '../providers/meets_providers.dart';
import 'player_avatar.dart';
import 'section_header.dart';

class ParticipantsTab extends ConsumerWidget {
  final int meetId;

  const ParticipantsTab({super.key, required this.meetId});

  Future<void> _openAddParticipantSheet(BuildContext context, WidgetRef ref) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _AddParticipantSheet(meetId: meetId),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final participantsAsync = ref.watch(participantsProvider(meetId));
    final db = ref.read(databaseProvider);

    return Scaffold(
      body: participantsAsync.when(
        data: (participants) {
          final waiting = participants
              .where((p) => p.participant.arrivalOrder == null)
              .toList()
            ..sort((a, b) => a.player.name.compareTo(b.player.name));
          final checkedIn = participants
              .where((p) => p.participant.arrivalOrder != null)
              .toList()
            ..sort((a, b) =>
                a.participant.arrivalOrder!.compareTo(b.participant.arrivalOrder!));

          if (participants.isEmpty) {
            return _EmptyState(
              icon: Icons.group_add_outlined,
              text: 'No participants yet.\nTap + to add players from your roster.',
            );
          }

          return ListView(
            padding: const EdgeInsets.only(bottom: 88),
            children: [
              if (checkedIn.isNotEmpty) ...[
                const SectionHeader('Checked in'),
                for (var i = 0; i < checkedIn.length; i++)
                  _CheckedInTile(
                    entry: checkedIn[i],
                    canMoveUp: i > 0,
                    canMoveDown: i < checkedIn.length - 1,
                    onMoveUp: () => db.moveParticipant(meetId, checkedIn[i].participant.id, up: true),
                    onMoveDown: () => db.moveParticipant(meetId, checkedIn[i].participant.id, up: false),
                    onUndo: () => db.undoCheckIn(checkedIn[i].participant.id),
                  ),
              ],
              if (waiting.isNotEmpty) ...[
                const SectionHeader('Waiting to check in'),
                for (final entry in waiting)
                  _WaitingTile(
                    entry: entry,
                    onCheckIn: () => db.checkInParticipant(meetId, entry.participant.id),
                    onRemove: () => db.removeParticipant(entry.participant.id),
                  ),
              ],
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddParticipantSheet(context, ref),
        child: const Icon(Icons.person_add),
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

class _CheckedInTile extends StatelessWidget {
  final ParticipantWithPlayer entry;
  final bool canMoveUp;
  final bool canMoveDown;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;
  final VoidCallback onUndo;

  const _CheckedInTile({
    required this.entry,
    required this.canMoveUp,
    required this.canMoveDown,
    required this.onMoveUp,
    required this.onMoveDown,
    required this.onUndo,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final games = entry.participant.gamesPlayed;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          children: [
            SizedBox(
              width: 28,
              child: Text(
                '${entry.participant.arrivalOrder}',
                textAlign: TextAlign.center,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.primary,
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
                  const SizedBox(height: 2),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$games game${games == 1 ? '' : 's'}',
                      style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_upward),
              iconSize: 20,
              onPressed: canMoveUp ? onMoveUp : null,
              tooltip: 'Move earlier',
            ),
            IconButton(
              icon: const Icon(Icons.arrow_downward),
              iconSize: 20,
              onPressed: canMoveDown ? onMoveDown : null,
              tooltip: 'Move later',
            ),
            IconButton(
              icon: const Icon(Icons.undo),
              iconSize: 20,
              onPressed: onUndo,
              tooltip: 'Undo check-in',
            ),
          ],
        ),
      ),
    );
  }
}

class _WaitingTile extends StatelessWidget {
  final ParticipantWithPlayer entry;
  final VoidCallback onCheckIn;
  final VoidCallback onRemove;

  const _WaitingTile({
    required this.entry,
    required this.onCheckIn,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: PlayerAvatar(name: entry.player.name),
      title: Text(entry.player.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FilledButton.tonal(
            onPressed: onCheckIn,
            style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8)),
            child: const Text('Check in'),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: onRemove,
            tooltip: 'Remove from meet',
          ),
        ],
      ),
    );
  }
}

class _AddParticipantSheet extends ConsumerWidget {
  final int meetId;

  const _AddParticipantSheet({required this.meetId});

  Future<void> _addNewPlayer(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New player'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Name'),
          onSubmitted: (value) => Navigator.of(context).pop(value),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: const Text('Add'),
          ),
        ],
      ),
    );
    if (name != null && name.trim().isNotEmpty) {
      final db = ref.read(databaseProvider);
      final playerId = await db.addPlayer(name.trim());
      await db.addParticipant(meetId, playerId);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rosterAsync = ref.watch(rosterProvider);
    final participantsAsync = ref.watch(participantsProvider(meetId));
    final db = ref.read(databaseProvider);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          builder: (context, scrollController) {
            return rosterAsync.when(
              data: (roster) {
                final existingPlayerIds = (participantsAsync.valueOrNull ?? [])
                    .map((p) => p.participant.playerId)
                    .toSet();
                final available =
                    roster.where((p) => !existingPlayerIds.contains(p.id)).toList();

                return ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.outlineVariant,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    Text('Add participants', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person_add_alt_1)),
                      title: const Text('New player'),
                      onTap: () => _addNewPlayer(context, ref),
                    ),
                    const Divider(),
                    if (available.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text('Everyone in your roster is already in this meet.'),
                      ),
                    for (final player in available)
                      ListTile(
                        leading: PlayerAvatar(name: player.name),
                        title: Text(player.name),
                        trailing: const Icon(Icons.add),
                        onTap: () => db.addParticipant(meetId, player.id),
                      ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            );
          },
        ),
      ),
    );
  }
}
