import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../providers/meets_providers.dart';
import '../widgets/matches_tab.dart';
import '../widgets/participants_tab.dart';
import '../widgets/stats_tab.dart';
import 'meet_form_screen.dart';

class MeetDetailScreen extends ConsumerWidget {
  final int meetId;

  const MeetDetailScreen({super.key, required this.meetId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meetAsync = ref.watch(meetProvider(meetId));
    final theme = Theme.of(context);
    final subtitleStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: meetAsync.maybeWhen(
            data: (meet) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(meet.name),
                Text(
                  '${DateFormat('MMM d, h:mm a').format(meet.scheduledAt)} · ${meet.location}',
                  style: subtitleStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            orElse: () => const Text('Meet'),
          ),
          actions: [
            meetAsync.maybeWhen(
              data: (meet) => IconButton(
                icon: const Icon(Icons.edit_outlined),
                tooltip: 'Edit meet',
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MeetFormScreen(meet: meet)),
                ),
              ),
              orElse: () => const SizedBox.shrink(),
            ),
          ],
          bottom: const TabBar(tabs: [
            Tab(text: 'Participants'),
            Tab(text: 'Matches'),
            Tab(text: 'Stats'),
          ]),
        ),
        body: meetAsync.when(
          data: (meet) => TabBarView(
            children: [
              ParticipantsTab(meetId: meetId),
              MatchesTab(meetId: meetId, courtCount: meet.courtCount),
              StatsTab(meetId: meetId),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}
