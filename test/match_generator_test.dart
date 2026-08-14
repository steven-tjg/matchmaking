import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:matchmaking/logic/match_generator.dart';

ParticipantForMatching _p(int id, int arrivalOrder, {int gamesPlayed = 0}) =>
    ParticipantForMatching(id: id, arrivalOrder: arrivalOrder, gamesPlayed: gamesPlayed);

void main() {
  group('generateMatchDrafts - bootstrap phase (nobody has played yet)', () {
    test('first 4 arrivals form the first match on the first free court', () {
      final available = [for (var i = 1; i <= 8; i++) _p(i, i)];
      final drafts = generateMatchDrafts(
        available: available,
        freeCourts: [1, 2],
        random: Random(1),
      );

      expect(drafts, hasLength(2));
      final match1Players = {...drafts[0].team1, ...drafts[0].team2};
      final match2Players = {...drafts[1].team1, ...drafts[1].team2};
      expect(match1Players, {1, 2, 3, 4});
      expect(match2Players, {5, 6, 7, 8});
      expect(drafts[0].courtNumber, 1);
      expect(drafts[1].courtNumber, 2);
    });

    test('arrival order is respected regardless of list order', () {
      // Ids intentionally shuffled and decoupled from arrivalOrder to prove sorting drives
      // selection, not input order or id value.
      final available = [
        ParticipantForMatching(id: 80, arrivalOrder: 8, gamesPlayed: 0),
        ParticipantForMatching(id: 30, arrivalOrder: 3, gamesPlayed: 0),
        ParticipantForMatching(id: 10, arrivalOrder: 1, gamesPlayed: 0),
        ParticipantForMatching(id: 20, arrivalOrder: 2, gamesPlayed: 0),
        ParticipantForMatching(id: 40, arrivalOrder: 4, gamesPlayed: 0),
      ];
      final drafts = generateMatchDrafts(
        available: available,
        freeCourts: [1],
        random: Random(1),
      );

      expect(drafts, hasLength(1));
      final playersUsed = {...drafts[0].team1, ...drafts[0].team2};
      // Lowest 4 arrivalOrder values (1,2,3,4) -> ids 10,20,30,40. Id 80 (arrivalOrder 8) left out.
      expect(playersUsed, {10, 20, 30, 40});
    });

    test('leftover players who did not fit stay unassigned', () {
      final available = [for (var i = 1; i <= 5; i++) _p(i, i)];
      final drafts = generateMatchDrafts(
        available: available,
        freeCourts: [1],
        random: Random(1),
      );

      expect(drafts, hasLength(1));
      final playersUsed = {...drafts[0].team1, ...drafts[0].team2};
      expect(playersUsed, {1, 2, 3, 4});
      expect(playersUsed.contains(5), isFalse);
    });

    test('not enough courts filled when player pool runs short partway through', () {
      final available = [for (var i = 1; i <= 6; i++) _p(i, i)];
      final drafts = generateMatchDrafts(
        available: available,
        freeCourts: [1, 2, 3],
        random: Random(1),
      );

      // Only 6 players -> exactly one court's worth (4) can be filled; 2 remain leftover.
      expect(drafts, hasLength(1));
      expect(drafts[0].courtNumber, 1);
    });
  });

  group('generateMatchDrafts - fairness priority', () {
    test('players with fewer games played are prioritized over arrival order', () {
      // Players 1-4 arrived first but already played once; players 5-8 arrived later but
      // have zero games played, so they must be selected first.
      final available = [
        for (var i = 1; i <= 4; i++) _p(i, i, gamesPlayed: 1),
        for (var i = 5; i <= 8; i++) _p(i, i, gamesPlayed: 0),
      ];
      final drafts = generateMatchDrafts(
        available: available,
        freeCourts: [1],
        random: Random(1),
      );

      expect(drafts, hasLength(1));
      final playersUsed = {...drafts[0].team1, ...drafts[0].team2};
      expect(playersUsed, {5, 6, 7, 8});
    });

    test('once everyone has played, the least-played tier is selected first', () {
      final available = [
        for (var i = 1; i <= 4; i++) _p(i, i, gamesPlayed: 2),
        for (var i = 5; i <= 8; i++) _p(i, i, gamesPlayed: 1),
      ];
      final drafts = generateMatchDrafts(
        available: available,
        freeCourts: [1],
        random: Random(1),
      );

      expect(drafts, hasLength(1));
      final playersUsed = {...drafts[0].team1, ...drafts[0].team2};
      expect(playersUsed, {5, 6, 7, 8});
    });
  });

  group('generateMatchDrafts - random round robin once everyone has played', () {
    test('selection within an equal-games tier varies across random seeds', () {
      final available = [for (var i = 1; i <= 8; i++) _p(i, i, gamesPlayed: 1)];

      final resultsBySeed = <int, Set<int>>{};
      for (final seed in [1, 2, 3, 4, 5, 6, 7, 8]) {
        final drafts = generateMatchDrafts(
          available: available,
          freeCourts: [1],
          random: Random(seed),
        );
        resultsBySeed[seed] = {...drafts[0].team1, ...drafts[0].team2};
      }

      // With 8 equally-tied candidates and only 4 slots, different seeds should not always
      // pick the exact same group of 4.
      final distinctGroups = resultsBySeed.values.map((s) => s.toList()..sort()).toSet();
      expect(distinctGroups.length, greaterThan(1));
    });

    test('team pairing within a chosen group of 4 varies across random seeds', () {
      final available = [for (var i = 1; i <= 4; i++) _p(i, i, gamesPlayed: 0)];

      final teamPairings = <String>{};
      for (final seed in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) {
        final drafts = generateMatchDrafts(
          available: available,
          freeCourts: [1],
          random: Random(seed),
        );
        final team1Sorted = [...drafts[0].team1]..sort();
        teamPairings.add(team1Sorted.join(','));
      }

      expect(teamPairings.length, greaterThan(1));
    });

    test('every eligible player is still included somewhere across many draws', () {
      final available = [for (var i = 1; i <= 8; i++) _p(i, i, gamesPlayed: 3)];
      final everSelected = <int>{};
      for (var seed = 0; seed < 30; seed++) {
        final drafts = generateMatchDrafts(
          available: available,
          freeCourts: [1],
          random: Random(seed),
        );
        everSelected.addAll({...drafts[0].team1, ...drafts[0].team2});
      }
      expect(everSelected, {1, 2, 3, 4, 5, 6, 7, 8});
    });
  });

  group('generateMatchDrafts - multi-court', () {
    test('fills all free courts when enough players are available', () {
      final available = [for (var i = 1; i <= 12; i++) _p(i, i)];
      final drafts = generateMatchDrafts(
        available: available,
        freeCourts: [2, 3, 5],
        random: Random(1),
      );

      expect(drafts, hasLength(3));
      expect(drafts.map((d) => d.courtNumber).toList(), [2, 3, 5]);

      final allPlayers = drafts.expand((d) => [...d.team1, ...d.team2]).toSet();
      expect(allPlayers.length, 12);
    });

    test('no free courts means no matches are generated', () {
      final available = [for (var i = 1; i <= 8; i++) _p(i, i)];
      final drafts = generateMatchDrafts(
        available: available,
        freeCourts: [],
        random: Random(1),
      );
      expect(drafts, isEmpty);
    });

    test('fewer than 4 available players means no matches are generated', () {
      final available = [_p(1, 1), _p(2, 2), _p(3, 3)];
      final drafts = generateMatchDrafts(
        available: available,
        freeCourts: [1],
        random: Random(1),
      );
      expect(drafts, isEmpty);
    });
  });
}
