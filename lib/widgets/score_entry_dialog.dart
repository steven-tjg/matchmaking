import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/database_provider.dart';
import '../providers/meet_detail_providers.dart';
import 'player_avatar.dart';

class ScoreEntryDialog extends ConsumerStatefulWidget {
  final MatchView view;

  const ScoreEntryDialog({super.key, required this.view});

  @override
  ConsumerState<ScoreEntryDialog> createState() => _ScoreEntryDialogState();
}

class _ScoreEntryDialogState extends ConsumerState<ScoreEntryDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _team1Controller;
  late final TextEditingController _team2Controller;

  @override
  void initState() {
    super.initState();
    _team1Controller =
        TextEditingController(text: widget.view.match.team1Score?.toString());
    _team2Controller =
        TextEditingController(text: widget.view.match.team2Score?.toString());
  }

  @override
  void dispose() {
    _team1Controller.dispose();
    _team2Controller.dispose();
    super.dispose();
  }

  String? _validateScore(String? value) {
    final n = int.tryParse(value?.trim() ?? '');
    if (n == null || n < 0) return 'Enter a score';
    return null;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final team1Score = int.parse(_team1Controller.text.trim());
    final team2Score = int.parse(_team2Controller.text.trim());
    await ref
        .read(databaseProvider)
        .enterScore(widget.view.match.id, team1Score, team2Score);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final view = widget.view;
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.sports_score, size: 20),
          const SizedBox(width: 8),
          Text('Court ${view.match.courtNumber} score'),
        ],
      ),
      content: Form(
        key: _formKey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PlayerAvatar(name: view.team1Player1.name, radius: 14),
                      const SizedBox(width: 4),
                      PlayerAvatar(name: view.team1Player2.name, radius: 14),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text('${view.team1Player1.name} /\n${view.team1Player2.name}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _team1Controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    validator: _validateScore,
                    autofocus: true,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text('–', style: TextStyle(fontSize: 20)),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PlayerAvatar(name: view.team2Player1.name, radius: 14),
                      const SizedBox(width: 4),
                      PlayerAvatar(name: view.team2Player2.name, radius: 14),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text('${view.team2Player1.name} /\n${view.team2Player2.name}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _team2Controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    validator: _validateScore,
                  ),
                ],
              ),
            ),
          ],
        ),
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
