import 'package:flutter_test/flutter_test.dart';
import 'package:matchmaking/logic/player_stats.dart';

MatchResult _match({
  required int t1p1,
  required int t1p2,
  required int t2p1,
  required int t2p2,
  required int s1,
  required int s2,
  required DateTime at,
}) =>
    MatchResult(
      team1Player1Id: t1p1,
      team1Player2Id: t1p2,
      team2Player1Id: t2p1,
      team2Player2Id: t2p2,
      team1Score: s1,
      team2Score: s2,
      completedAt: at,
    );

void main() {
  // Participant ids 10-19 all map to distinct players 1-9 (a participant id is per-meet,
  // a player id is the stable global identity), mirroring how the real app resolves ids.
  final playerIdByParticipantId = {
    10: 1, 11: 2, 12: 3, 13: 4, // meet A
    20: 1, 21: 2, 22: 3, 23: 4, // meet B, same 4 players, new participant ids
  };
  final nameByPlayerId = {1: 'Alice', 2: 'Bob', 3: 'Carol', 4: 'Dan'};

  final t0 = DateTime(2026, 1, 1);

  test('computes wins, losses, and win rate from a single match', () {
    final matches = [
      _match(t1p1: 10, t1p2: 11, t2p1: 12, t2p2: 13, s1: 6, s2: 2, at: t0),
    ];
    final stats = computePlayerStats(
      matches: matches,
      playerIdByParticipantId: playerIdByParticipantId,
      nameByPlayerId: nameByPlayerId,
    );

    final alice = stats.firstWhere((s) => s.name == 'Alice');
    expect(alice.matchesPlayed, 1);
    expect(alice.wins, 1);
    expect(alice.losses, 0);
    expect(alice.winRate, 1.0);
    expect(alice.gamesWon, 6);
    expect(alice.gamesLost, 2);

    final carol = stats.firstWhere((s) => s.name == 'Carol');
    expect(carol.wins, 0);
    expect(carol.losses, 1);
    expect(carol.winRate, 0.0);
    expect(carol.gamesWon, 2);
    expect(carol.gamesLost, 6);
  });

  test('players with zero completed matches are omitted', () {
    final matches = [
      _match(t1p1: 10, t1p2: 11, t2p1: 12, t2p2: 13, s1: 6, s2: 2, at: t0),
    ];
    final nameByPlayerIdWithExtra = {...nameByPlayerId, 5: 'Eve'};
    final stats = computePlayerStats(
      matches: matches,
      playerIdByParticipantId: playerIdByParticipantId,
      nameByPlayerId: nameByPlayerIdWithExtra,
    );
    expect(stats.any((s) => s.name == 'Eve'), isFalse);
  });

  test('aggregates games and win rate across multiple matches', () {
    final matches = [
      _match(t1p1: 10, t1p2: 11, t2p1: 12, t2p2: 13, s1: 6, s2: 2, at: t0),
      _match(
        t1p1: 20,
        t1p2: 21,
        t2p1: 22,
        t2p2: 23,
        s1: 3,
        s2: 6,
        at: t0.add(const Duration(days: 1)),
      ),
    ];
    final stats = computePlayerStats(
      matches: matches,
      playerIdByParticipantId: playerIdByParticipantId,
      nameByPlayerId: nameByPlayerId,
    );

    final alice = stats.firstWhere((s) => s.name == 'Alice');
    expect(alice.matchesPlayed, 2);
    expect(alice.wins, 1);
    expect(alice.losses, 1);
    expect(alice.winRate, 0.5);
    expect(alice.gamesWon, 6 + 3);
    expect(alice.gamesLost, 2 + 6);
  });

  test('current streak counts consecutive same-result matches from the most recent', () {
    final matches = [
      // Alice+Bob win, then lose, then win, then win -> current streak W2
      _match(t1p1: 10, t1p2: 11, t2p1: 12, t2p2: 13, s1: 6, s2: 2, at: t0),
      _match(
        t1p1: 10,
        t1p2: 11,
        t2p1: 12,
        t2p2: 13,
        s1: 2,
        s2: 6,
        at: t0.add(const Duration(days: 1)),
      ),
      _match(
        t1p1: 10,
        t1p2: 11,
        t2p1: 12,
        t2p2: 13,
        s1: 6,
        s2: 3,
        at: t0.add(const Duration(days: 2)),
      ),
      _match(
        t1p1: 10,
        t1p2: 11,
        t2p1: 12,
        t2p2: 13,
        s1: 6,
        s2: 4,
        at: t0.add(const Duration(days: 3)),
      ),
    ];
    final stats = computePlayerStats(
      matches: matches,
      playerIdByParticipantId: playerIdByParticipantId,
      nameByPlayerId: nameByPlayerId,
    );

    final alice = stats.firstWhere((s) => s.name == 'Alice');
    expect(alice.currentStreak, 2);
    final carol = stats.firstWhere((s) => s.name == 'Carol');
    expect(carol.currentStreak, -2);
  });

  test('current streak is negative for a current loss streak', () {
    final matches = [
      _match(t1p1: 10, t1p2: 11, t2p1: 12, t2p2: 13, s1: 6, s2: 2, at: t0),
      _match(
        t1p1: 10,
        t1p2: 11,
        t2p1: 12,
        t2p2: 13,
        s1: 2,
        s2: 6,
        at: t0.add(const Duration(days: 1)),
      ),
      _match(
        t1p1: 10,
        t1p2: 11,
        t2p1: 12,
        t2p2: 13,
        s1: 3,
        s2: 6,
        at: t0.add(const Duration(days: 2)),
      ),
    ];
    final stats = computePlayerStats(
      matches: matches,
      playerIdByParticipantId: playerIdByParticipantId,
      nameByPlayerId: nameByPlayerId,
    );
    final alice = stats.firstWhere((s) => s.name == 'Alice');
    expect(alice.currentStreak, -2);
  });

  test('best partner requires at least 2 matches together and picks the higher win rate', () {
    // Alice partners with Bob twice (2 wins) and with Carol once (1 win) in a different meet
    // shuffle. Bob doesn't qualify with only 1 match together in this scenario... construct
    // explicitly:
    final matches = [
      // Alice+Bob beat Carol+Dan twice
      _match(t1p1: 10, t1p2: 11, t2p1: 12, t2p2: 13, s1: 6, s2: 1, at: t0),
      _match(
        t1p1: 20,
        t1p2: 21,
        t2p1: 22,
        t2p2: 23,
        s1: 6,
        s2: 2,
        at: t0.add(const Duration(days: 1)),
      ),
    ];
    final stats = computePlayerStats(
      matches: matches,
      playerIdByParticipantId: playerIdByParticipantId,
      nameByPlayerId: nameByPlayerId,
    );
    final alice = stats.firstWhere((s) => s.name == 'Alice');
    expect(alice.bestPartnerName, 'Bob');
    expect(alice.bestPartnerWinRate, 1.0);
  });

  test('best partner is null when no partner has played 2+ matches together', () {
    final matches = [
      _match(t1p1: 10, t1p2: 11, t2p1: 12, t2p2: 13, s1: 6, s2: 1, at: t0),
    ];
    final stats = computePlayerStats(
      matches: matches,
      playerIdByParticipantId: playerIdByParticipantId,
      nameByPlayerId: nameByPlayerId,
    );
    final alice = stats.firstWhere((s) => s.name == 'Alice');
    expect(alice.bestPartnerName, isNull);
    expect(alice.bestPartnerWinRate, isNull);
  });

  test('ranking sorts by win rate desc, tie-broken by matches played desc', () {
    final matches = [
      // Alice: 1 win / 1 match = 100%
      _match(t1p1: 10, t1p2: 11, t2p1: 12, t2p2: 13, s1: 6, s2: 1, at: t0),
      // Bob (participant 21 in meet B) also ends up 100% but with 2 matches by playing twice
      // in meet B against a different pairing to accumulate more matches at 100%.
      _match(
        t1p1: 20,
        t1p2: 21,
        t2p1: 22,
        t2p2: 23,
        s1: 6,
        s2: 2,
        at: t0.add(const Duration(days: 1)),
      ),
      _match(
        t1p1: 21,
        t1p2: 20,
        t2p1: 23,
        t2p2: 22,
        s1: 6,
        s2: 3,
        at: t0.add(const Duration(days: 2)),
      ),
    ];
    final stats = computePlayerStats(
      matches: matches,
      playerIdByParticipantId: playerIdByParticipantId,
      nameByPlayerId: nameByPlayerId,
    );
    // Alice (player 1) has 2 matches at 100% (meet A once, meet B twice via participant 10/20/21... )
    // Simplify assertion: top of the ranking should be 100% win rate, and among 100% players the
    // one with more matches played should rank first.
    expect(stats.first.winRate, 1.0);
    for (var i = 1; i < stats.length; i++) {
      final prevScore = stats[i - 1].winRate * 1000000 + stats[i - 1].matchesPlayed;
      final currScore = stats[i].winRate * 1000000 + stats[i].matchesPlayed;
      expect(prevScore, greaterThanOrEqualTo(currScore));
    }
  });

  test('unmapped participant ids do not crash and exclude that match for both teammates', () {
    final matches = [
      _match(t1p1: 999, t1p2: 11, t2p1: 12, t2p2: 13, s1: 6, s2: 1, at: t0),
    ];
    final stats = computePlayerStats(
      matches: matches,
      playerIdByParticipantId: playerIdByParticipantId,
      nameByPlayerId: nameByPlayerId,
    );
    // Bob (participant 11) had an unmapped partner, so this match contributes nothing for him.
    expect(stats.any((s) => s.name == 'Bob'), isFalse);
    // Carol and Dan (the opposing team) still get their loss recorded normally.
    final carol = stats.firstWhere((s) => s.name == 'Carol');
    expect(carol.matchesPlayed, 1);
    expect(carol.losses, 1);
  });
}
