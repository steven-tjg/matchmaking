import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../providers/database_provider.dart';
import '../providers/meet_detail_providers.dart';

class EditMatchPlayersDialog extends ConsumerStatefulWidget {
  final int meetId;
  final MatchView view;

  const EditMatchPlayersDialog({super.key, required this.meetId, required this.view});

  @override
  ConsumerState<EditMatchPlayersDialog> createState() => _EditMatchPlayersDialogState();
}

class _EditMatchPlayersDialogState extends ConsumerState<EditMatchPlayersDialog> {
  late int _team1P1;
  late int _team1P2;
  late int _team2P1;
  late int _team2P2;
  String? _error;

  @override
  void initState() {
    super.initState();
    final match = widget.view.match;
    _team1P1 = match.team1Player1Id;
    _team1P2 = match.team1Player2Id;
    _team2P1 = match.team2Player1Id;
    _team2P2 = match.team2Player2Id;
  }

  Future<void> _save() async {
    final ids = [_team1P1, _team1P2, _team2P1, _team2P2];
    if (ids.toSet().length != ids.length) {
      setState(() => _error = 'Each player can only appear once in a match.');
      return;
    }
    await ref.read(databaseProvider).updateMatchPlayers(
          widget.view.match.id,
          team1Player1Id: _team1P1,
          team1Player2Id: _team1P2,
          team2Player1Id: _team2P1,
          team2Player2Id: _team2P2,
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final participantsAsync = ref.watch(participantsProvider(widget.meetId));
    final matchesAsync = ref.watch(matchesProvider(widget.meetId));

    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.swap_horiz, size: 20),
          const SizedBox(width: 8),
          Text('Court ${widget.view.match.courtNumber} players'),
        ],
      ),
      content: participantsAsync.when(
        data: (participants) {
          final matches = matchesAsync.value ?? [];

          // Participants busy in a different pending match can't be picked here.
          final busyElsewhere = <int>{};
          for (final match in matches) {
            if (match.id == widget.view.match.id || match.status != 'pending') continue;
            busyElsewhere.addAll([
              match.team1Player1Id,
              match.team1Player2Id,
              match.team2Player1Id,
              match.team2Player2Id,
            ]);
          }
          final checkedIn = participants.where((p) => p.participant.arrivalOrder != null).toList()
            ..sort((a, b) => a.player.name.compareTo(b.player.name));

          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Team 1', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 4),
                _PlayerDropdown(
                  value: _team1P1,
                  options: checkedIn,
                  busyElsewhere: busyElsewhere,
                  otherSelected: {_team1P2, _team2P1, _team2P2},
                  onChanged: (value) => setState(() {
                    _team1P1 = value;
                    _error = null;
                  }),
                ),
                const SizedBox(height: 8),
                _PlayerDropdown(
                  value: _team1P2,
                  options: checkedIn,
                  busyElsewhere: busyElsewhere,
                  otherSelected: {_team1P1, _team2P1, _team2P2},
                  onChanged: (value) => setState(() {
                    _team1P2 = value;
                    _error = null;
                  }),
                ),
                const SizedBox(height: 16),
                Text('Team 2', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 4),
                _PlayerDropdown(
                  value: _team2P1,
                  options: checkedIn,
                  busyElsewhere: busyElsewhere,
                  otherSelected: {_team1P1, _team1P2, _team2P2},
                  onChanged: (value) => setState(() {
                    _team2P1 = value;
                    _error = null;
                  }),
                ),
                const SizedBox(height: 8),
                _PlayerDropdown(
                  value: _team2P2,
                  options: checkedIn,
                  busyElsewhere: busyElsewhere,
                  otherSelected: {_team1P1, _team1P2, _team2P1},
                  onChanged: (value) => setState(() {
                    _team2P2 = value;
                    _error = null;
                  }),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 8),
                  Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                ],
              ],
            ),
          );
        },
        loading: () => const SizedBox(
          height: 80,
          child: Center(child: CircularProgressIndicator()),
        ),
        error: (error, stack) => Text('Error: $error'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(onPressed: _save, child: const Text('Save')),
      ],
    );
  }
}

class _PlayerDropdown extends StatelessWidget {
  final int value;
  final List<ParticipantWithPlayer> options;
  final Set<int> busyElsewhere;
  final Set<int> otherSelected;
  final ValueChanged<int> onChanged;

  const _PlayerDropdown({
    required this.value,
    required this.options,
    required this.busyElsewhere,
    required this.otherSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final eligible = options.where((p) =>
        p.participant.id == value ||
        (!busyElsewhere.contains(p.participant.id) && !otherSelected.contains(p.participant.id)));

    return DropdownButtonFormField<int>(
      initialValue: value,
      isExpanded: true,
      decoration: const InputDecoration(isDense: true),
      items: [
        for (final p in eligible)
          DropdownMenuItem(value: p.participant.id, child: Text(p.player.name)),
      ],
      onChanged: (newValue) {
        if (newValue != null) onChanged(newValue);
      },
    );
  }
}
