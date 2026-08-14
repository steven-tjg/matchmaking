import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../data/database.dart';
import '../providers/meets_providers.dart';
import '../utils/meet_status.dart';
import 'leaderboard_screen.dart';
import 'meet_detail_screen.dart';
import 'meet_form_screen.dart';
import 'roster_screen.dart';

class MeetsListScreen extends ConsumerWidget {
  const MeetsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meetsAsync = ref.watch(meetsListProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Matchmaking'),
          actions: [
            IconButton(
              icon: const Icon(Icons.emoji_events_outlined),
              tooltip: 'Leaderboard',
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LeaderboardScreen()),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.people_outline),
              tooltip: 'Player roster',
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const RosterScreen()),
              ),
            ),
          ],
          bottom: const TabBar(tabs: [
            Tab(text: 'Upcoming'),
            Tab(text: 'History'),
          ]),
        ),
        body: meetsAsync.when(
          data: (meets) {
            final now = DateTime.now();
            final upcoming = meets
                .where((m) => meetStatusOf(m, now: now) != MeetStatus.completed)
                .toList()
              ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
            final history = meets
                .where((m) => meetStatusOf(m, now: now) == MeetStatus.completed)
                .toList()
              ..sort((a, b) => b.scheduledAt.compareTo(a.scheduledAt));

            return TabBarView(
              children: [
                _MeetList(
                  meets: upcoming,
                  emptyIcon: Icons.event_available_outlined,
                  emptyText: 'No upcoming meets.\nTap + to create one.',
                ),
                _MeetList(
                  meets: history,
                  emptyIcon: Icons.history,
                  emptyText: 'No past meets yet.',
                ),
              ],
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
      ),
    );
  }
}

class _MeetList extends StatelessWidget {
  final List<Meet> meets;
  final IconData emptyIcon;
  final String emptyText;

  const _MeetList({required this.meets, required this.emptyIcon, required this.emptyText});

  @override
  Widget build(BuildContext context) {
    if (meets.isEmpty) {
      final theme = Theme.of(context);
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(emptyIcon, size: 48, color: theme.colorScheme.outline),
              const SizedBox(height: 12),
              Text(
                emptyText,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
              ),
            ],
          ),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 96),
      itemCount: meets.length,
      itemBuilder: (context, index) => _MeetCard(meet: meets[index]),
    );
  }
}

class _MeetCard extends StatelessWidget {
  final Meet meet;

  const _MeetCard({required this.meet});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final status = meetStatusOf(meet);
    final monthFormat = DateFormat('MMM');
    final dayFormat = DateFormat('d');
    final timeFormat = DateFormat('h:mm a');

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MeetDetailScreen(meetId: meet.id)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: status == MeetStatus.completed
                        ? theme.colorScheme.surfaceContainerHighest
                        : theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        monthFormat.format(meet.scheduledAt).toUpperCase(),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: status == MeetStatus.completed
                              ? theme.colorScheme.onSurfaceVariant
                              : theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      Text(
                        dayFormat.format(meet.scheduledAt),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: status == MeetStatus.completed
                              ? theme.colorScheme.onSurfaceVariant
                              : theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meet.name,
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 14, color: theme.colorScheme.onSurfaceVariant),
                          const SizedBox(width: 4),
                          Text(timeFormat.format(meet.scheduledAt), style: theme.textTheme.bodySmall),
                          const SizedBox(width: 10),
                          Icon(Icons.place_outlined, size: 14, color: theme.colorScheme.onSurfaceVariant),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              meet.location,
                              style: theme.textTheme.bodySmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          _StatusChip(status: status),
                          Chip(
                            label: Text('${meet.courtCount} court${meet.courtCount > 1 ? 's' : ''}'),
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: theme.colorScheme.outline),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final MeetStatus status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color bg;
    final Color fg;
    final String label;
    switch (status) {
      case MeetStatus.upcoming:
        bg = theme.colorScheme.primaryContainer;
        fg = theme.colorScheme.onPrimaryContainer;
        label = 'Upcoming';
      case MeetStatus.live:
        bg = theme.colorScheme.tertiaryContainer;
        fg = theme.colorScheme.onTertiaryContainer;
        label = 'Live now';
      case MeetStatus.completed:
        bg = theme.colorScheme.surfaceContainerHighest;
        fg = theme.colorScheme.onSurfaceVariant;
        label = 'Completed';
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(color: fg, fontWeight: FontWeight.w600),
      ),
    );
  }
}
