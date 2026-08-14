import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import 'database_provider.dart';

final participantsProvider =
    StreamProvider.family<List<ParticipantWithPlayer>, int>((ref, meetId) {
  return ref.watch(databaseProvider).watchParticipants(meetId);
});

final matchesProvider = StreamProvider.family<List<MatchRecord>, int>((ref, meetId) {
  return ref.watch(databaseProvider).watchMatches(meetId);
});

/// A match with participant ids resolved to display names, so match cards don't need to
/// re-join against the participants list themselves.
class MatchPlayerView {
  final int participantId;
  final String name;

  const MatchPlayerView({required this.participantId, required this.name});
}

class MatchView {
  final MatchRecord match;
  final MatchPlayerView team1Player1;
  final MatchPlayerView team1Player2;
  final MatchPlayerView team2Player1;
  final MatchPlayerView team2Player2;

  const MatchView({
    required this.match,
    required this.team1Player1,
    required this.team1Player2,
    required this.team2Player1,
    required this.team2Player2,
  });
}

final matchViewsProvider = Provider.family<AsyncValue<List<MatchView>>, int>((ref, meetId) {
  final participantsAsync = ref.watch(participantsProvider(meetId));
  final matchesAsync = ref.watch(matchesProvider(meetId));

  if (participantsAsync.isLoading || matchesAsync.isLoading) {
    return const AsyncValue.loading();
  }
  final error = participantsAsync.error ?? matchesAsync.error;
  if (error != null) {
    return AsyncValue.error(error, StackTrace.current);
  }

  final participants = participantsAsync.requireValue;
  final matches = matchesAsync.requireValue;
  final nameById = {for (final p in participants) p.participant.id: p.player.name};

  MatchPlayerView lookup(int id) =>
      MatchPlayerView(participantId: id, name: nameById[id] ?? '?');

  return AsyncValue.data([
    for (final match in matches)
      MatchView(
        match: match,
        team1Player1: lookup(match.team1Player1Id),
        team1Player2: lookup(match.team1Player2Id),
        team2Player1: lookup(match.team2Player1Id),
        team2Player2: lookup(match.team2Player2Id),
      ),
  ]);
});
