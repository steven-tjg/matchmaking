/// Minimal view of a completed match needed to compute lifetime player statistics.
class MatchResult {
  final int team1Player1Id;
  final int team1Player2Id;
  final int team2Player1Id;
  final int team2Player2Id;
  final int team1Score;
  final int team2Score;
  final DateTime completedAt;

  const MatchResult({
    required this.team1Player1Id,
    required this.team1Player2Id,
    required this.team2Player1Id,
    required this.team2Player2Id,
    required this.team1Score,
    required this.team2Score,
    required this.completedAt,
  });
}

class PlayerStats {
  final int playerId;
  final String name;
  final int matchesPlayed;
  final int wins;
  final int losses;
  final int gamesWon;
  final int gamesLost;

  /// Positive = current win streak of this length, negative = current loss streak,
  /// 0 = no matches played.
  final int currentStreak;

  /// Name of the partner this player has the best win rate with (min. 2 matches together),
  /// or null if no partner qualifies.
  final String? bestPartnerName;
  final double? bestPartnerWinRate;

  const PlayerStats({
    required this.playerId,
    required this.name,
    required this.matchesPlayed,
    required this.wins,
    required this.losses,
    required this.gamesWon,
    required this.gamesLost,
    required this.currentStreak,
    this.bestPartnerName,
    this.bestPartnerWinRate,
  });

  double get winRate => matchesPlayed == 0 ? 0 : wins / matchesPlayed;
}

/// Aggregates completed matches into per-player lifetime statistics: matches/wins/losses,
/// win rate, total games won/lost, current form streak, and best regular partner.
///
/// [playerIdByParticipantId] resolves the per-meet participant ids stored on each match to a
/// stable player id, since the same player has a different participant id in every meet.
/// [nameByPlayerId] supplies display names. Players with zero completed matches are omitted.
List<PlayerStats> computePlayerStats({
  required List<MatchResult> matches,
  required Map<int, int> playerIdByParticipantId,
  required Map<int, String> nameByPlayerId,
}) {
  final sortedMatches = [...matches]..sort((a, b) => a.completedAt.compareTo(b.completedAt));

  final wins = <int, int>{};
  final losses = <int, int>{};
  final gamesWon = <int, int>{};
  final gamesLost = <int, int>{};
  final resultHistory = <int, List<bool>>{};
  final partnerMatches = <int, Map<int, int>>{};
  final partnerWins = <int, Map<int, int>>{};

  void record(int? playerId, int? partnerId, int gamesFor, int gamesAgainst, bool won) {
    if (playerId == null || partnerId == null) return;
    if (won) {
      wins.update(playerId, (v) => v + 1, ifAbsent: () => 1);
    } else {
      losses.update(playerId, (v) => v + 1, ifAbsent: () => 1);
    }
    gamesWon.update(playerId, (v) => v + gamesFor, ifAbsent: () => gamesFor);
    gamesLost.update(playerId, (v) => v + gamesAgainst, ifAbsent: () => gamesAgainst);
    resultHistory.putIfAbsent(playerId, () => []).add(won);

    final partners = partnerMatches.putIfAbsent(playerId, () => {});
    partners.update(partnerId, (v) => v + 1, ifAbsent: () => 1);
    if (won) {
      final partnerWinMap = partnerWins.putIfAbsent(playerId, () => {});
      partnerWinMap.update(partnerId, (v) => v + 1, ifAbsent: () => 1);
    }
  }

  for (final match in sortedMatches) {
    final t1p1 = playerIdByParticipantId[match.team1Player1Id];
    final t1p2 = playerIdByParticipantId[match.team1Player2Id];
    final t2p1 = playerIdByParticipantId[match.team2Player1Id];
    final t2p2 = playerIdByParticipantId[match.team2Player2Id];
    final team1Won = match.team1Score > match.team2Score;
    final team2Won = match.team2Score > match.team1Score;

    record(t1p1, t1p2, match.team1Score, match.team2Score, team1Won);
    record(t1p2, t1p1, match.team1Score, match.team2Score, team1Won);
    record(t2p1, t2p2, match.team2Score, match.team1Score, team2Won);
    record(t2p2, t2p1, match.team2Score, match.team1Score, team2Won);
  }

  final stats = <PlayerStats>[];
  for (final playerId in nameByPlayerId.keys) {
    final matchesPlayed = (wins[playerId] ?? 0) + (losses[playerId] ?? 0);
    if (matchesPlayed == 0) continue;

    final history = resultHistory[playerId] ?? const [];
    var streak = 0;
    if (history.isNotEmpty) {
      final last = history.last;
      for (var i = history.length - 1; i >= 0 && history[i] == last; i--) {
        streak++;
      }
      if (!last) streak = -streak;
    }

    String? bestPartnerName;
    double? bestPartnerRate;
    for (final entry in (partnerMatches[playerId] ?? const {}).entries) {
      if (entry.value < 2) continue;
      final winsWithPartner = partnerWins[playerId]?[entry.key] ?? 0;
      final rate = winsWithPartner / entry.value;
      if (bestPartnerRate == null || rate > bestPartnerRate) {
        bestPartnerRate = rate;
        bestPartnerName = nameByPlayerId[entry.key];
      }
    }

    stats.add(PlayerStats(
      playerId: playerId,
      name: nameByPlayerId[playerId]!,
      matchesPlayed: matchesPlayed,
      wins: wins[playerId] ?? 0,
      losses: losses[playerId] ?? 0,
      gamesWon: gamesWon[playerId] ?? 0,
      gamesLost: gamesLost[playerId] ?? 0,
      currentStreak: streak,
      bestPartnerName: bestPartnerName,
      bestPartnerWinRate: bestPartnerRate,
    ));
  }

  stats.sort((a, b) {
    final byRate = b.winRate.compareTo(a.winRate);
    if (byRate != 0) return byRate;
    return b.matchesPlayed.compareTo(a.matchesPlayed);
  });

  return stats;
}
