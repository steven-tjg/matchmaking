import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../logic/player_stats.dart';
import 'database_provider.dart';

final allCompletedMatchesProvider = StreamProvider<List<MatchRecord>>((ref) {
  return ref.watch(databaseProvider).watchAllCompletedMatches();
});

final allParticipantsProvider = StreamProvider<List<ParticipantWithPlayer>>((ref) {
  return ref.watch(databaseProvider).watchAllParticipantsWithPlayers();
});

final playerStatsProvider = Provider<AsyncValue<List<PlayerStats>>>((ref) {
  final matchesAsync = ref.watch(allCompletedMatchesProvider);
  final participantsAsync = ref.watch(allParticipantsProvider);

  if (matchesAsync.isLoading || participantsAsync.isLoading) {
    return const AsyncValue.loading();
  }
  final error = matchesAsync.error ?? participantsAsync.error;
  if (error != null) {
    return AsyncValue.error(error, StackTrace.current);
  }

  final participants = participantsAsync.requireValue;
  final playerIdByParticipantId = {
    for (final p in participants) p.participant.id: p.player.id,
  };
  final nameByPlayerId = {
    for (final p in participants) p.player.id: p.player.name,
  };

  final matchResults = matchesAsync.requireValue
      .map((match) => MatchResult(
            team1Player1Id: match.team1Player1Id,
            team1Player2Id: match.team1Player2Id,
            team2Player1Id: match.team2Player1Id,
            team2Player2Id: match.team2Player2Id,
            team1Score: match.team1Score ?? 0,
            team2Score: match.team2Score ?? 0,
            completedAt: match.completedAt ?? match.createdAt,
          ))
      .toList();

  return AsyncValue.data(computePlayerStats(
    matches: matchResults,
    playerIdByParticipantId: playerIdByParticipantId,
    nameByPlayerId: nameByPlayerId,
  ));
});
