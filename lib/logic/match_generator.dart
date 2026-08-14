import 'dart:math';

/// Minimal view of a checked-in meet participant needed to decide who plays next.
class ParticipantForMatching {
  final int id;
  final int arrivalOrder;
  final int gamesPlayed;

  const ParticipantForMatching({
    required this.id,
    required this.arrivalOrder,
    required this.gamesPlayed,
  });
}

/// A doubles match proposal: two teams of two participant ids, assigned to a court.
class MatchDraft {
  final int courtNumber;
  final List<int> team1;
  final List<int> team2;

  const MatchDraft({
    required this.courtNumber,
    required this.team1,
    required this.team2,
  });
}

/// Fills each of [freeCourts] with a doubles match drawn from [available] participants.
///
/// Priority order is "fewest games played first". Within a tier of players who share the
/// same games-played count: if that count is zero (nobody in the tier has played yet this
/// meet) ties are broken by arrival order, which guarantees the first 4 arrivals form the
/// first match, the next 4 the second, and so on. Once every candidate has played at least
/// one game, ties within a tier are broken randomly, giving the "random round robin" phase
/// while still prioritizing whoever has played the fewest games.
///
/// Courts are filled in the order given by [freeCourts]. If there aren't enough players left
/// to fill a court, that court (and any after it) is left unfilled for this call — the
/// leftover players simply wait for the next generation.
List<MatchDraft> generateMatchDrafts({
  required List<ParticipantForMatching> available,
  required List<int> freeCourts,
  Random? random,
}) {
  final rng = random ?? Random();

  final byGames = <int, List<ParticipantForMatching>>{};
  for (final participant in available) {
    byGames.putIfAbsent(participant.gamesPlayed, () => []).add(participant);
  }

  final queue = <ParticipantForMatching>[];
  final gameCounts = byGames.keys.toList()..sort();
  for (final gamesPlayed in gameCounts) {
    final tier = byGames[gamesPlayed]!;
    if (gamesPlayed == 0) {
      tier.sort((a, b) => a.arrivalOrder.compareTo(b.arrivalOrder));
    } else {
      tier.shuffle(rng);
    }
    queue.addAll(tier);
  }

  final drafts = <MatchDraft>[];
  var index = 0;
  for (final court in freeCourts) {
    if (index + 4 > queue.length) break;
    final group = queue.sublist(index, index + 4);
    index += 4;
    group.shuffle(rng);
    drafts.add(MatchDraft(
      courtNumber: court,
      team1: [group[0].id, group[1].id],
      team2: [group[2].id, group[3].id],
    ));
  }
  return drafts;
}
