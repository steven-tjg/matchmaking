import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/meets_providers.dart';
import '../widgets/matches_tab.dart';
import '../widgets/participants_tab.dart';
import '../widgets/stats_tab.dart';

class MeetDetailScreen extends ConsumerWidget {
  final int meetId;

  const MeetDetailScreen({super.key, required this.meetId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meetAsync = ref.watch(meetProvider(meetId));

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(meetAsync.valueOrNull?.name ?? 'Meet'),
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
