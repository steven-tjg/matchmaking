import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../logic/match_generator.dart';

part 'database.g.dart';

class Players extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Meets extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get scheduledAt => dateTime()();
  IntColumn get durationMinutes => integer()();
  TextColumn get location => text()();
  IntColumn get courtCount => integer().withDefault(const Constant(1))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class MeetParticipants extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get meetId =>
      integer().references(Meets, #id, onDelete: KeyAction.cascade)();
  IntColumn get playerId =>
      integer().references(Players, #id, onDelete: KeyAction.cascade)();
  IntColumn get arrivalOrder => integer().nullable()();
  DateTimeColumn get checkedInAt => dateTime().nullable()();
  IntColumn get gamesPlayed => integer().withDefault(const Constant(0))();

  @override
  List<Set<Column>> get uniqueKeys => [
        {meetId, playerId},
      ];
}

/// Named `MatchRecords` (not `Matches`/`Match`) to avoid colliding with dart:core's `Match`
/// (regex match result) that Drift's singularized data class name would otherwise clash with.
class MatchRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get meetId =>
      integer().references(Meets, #id, onDelete: KeyAction.cascade)();
  IntColumn get courtNumber => integer()();
  @ReferenceName("asTeam1Player1")
  IntColumn get team1Player1Id => integer().references(MeetParticipants, #id)();
  @ReferenceName("asTeam1Player2")
  IntColumn get team1Player2Id => integer().references(MeetParticipants, #id)();
  @ReferenceName("asTeam2Player1")
  IntColumn get team2Player1Id => integer().references(MeetParticipants, #id)();
  @ReferenceName("asTeam2Player2")
  IntColumn get team2Player2Id => integer().references(MeetParticipants, #id)();
  IntColumn get team1Score => integer().nullable()();
  IntColumn get team2Score => integer().nullable()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get completedAt => dateTime().nullable()();
}

class ParticipantWithPlayer {
  final MeetParticipant participant;
  final Player player;

  const ParticipantWithPlayer({required this.participant, required this.player});
}

@DriftDatabase(tables: [Players, Meets, MeetParticipants, MatchRecords])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'matchmaking',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  // ---- Roster ----

  Stream<List<Player>> watchRoster() =>
      (select(players)..orderBy([(t) => OrderingTerm(expression: t.name)])).watch();

  Future<int> addPlayer(String name) =>
      into(players).insert(PlayersCompanion.insert(name: name));

  // ---- Meets ----

  Stream<List<Meet>> watchMeets() => (select(meets)
        ..orderBy([(t) => OrderingTerm(expression: t.scheduledAt, mode: OrderingMode.desc)]))
      .watch();

  Stream<Meet> watchMeet(int meetId) =>
      (select(meets)..where((t) => t.id.equals(meetId))).watchSingle();

  Future<int> createMeet({
    required String name,
    required DateTime scheduledAt,
    required int durationMinutes,
    required String location,
    required int courtCount,
  }) =>
      into(meets).insert(MeetsCompanion.insert(
        name: name,
        scheduledAt: scheduledAt,
        durationMinutes: durationMinutes,
        location: location,
        courtCount: Value(courtCount),
      ));

  Future<bool> updateMeet(Meet meet) => update(meets).replace(meet);

  Future<void> deleteMeet(int meetId) =>
      (delete(meets)..where((t) => t.id.equals(meetId))).go();

  // ---- Participants ----

  Stream<List<ParticipantWithPlayer>> watchParticipants(int meetId) {
    final query = select(meetParticipants).join([
      innerJoin(players, players.id.equalsExp(meetParticipants.playerId)),
    ])
      ..where(meetParticipants.meetId.equals(meetId));
    return query.watch().map((rows) => rows
        .map((row) => ParticipantWithPlayer(
              participant: row.readTable(meetParticipants),
              player: row.readTable(players),
            ))
        .toList());
  }

  Future<void> addParticipant(int meetId, int playerId) => into(meetParticipants).insert(
        MeetParticipantsCompanion.insert(meetId: meetId, playerId: playerId),
        mode: InsertMode.insertOrIgnore,
      );

  Future<void> removeParticipant(int participantId) =>
      (delete(meetParticipants)..where((t) => t.id.equals(participantId))).go();

  Future<void> checkInParticipant(int meetId, int participantId) async {
    final maxOrderRow = await (selectOnly(meetParticipants)
          ..addColumns([meetParticipants.arrivalOrder.max()])
          ..where(meetParticipants.meetId.equals(meetId)))
        .getSingle();
    final nextOrder = (maxOrderRow.read(meetParticipants.arrivalOrder.max()) ?? 0) + 1;
    await (update(meetParticipants)..where((t) => t.id.equals(participantId))).write(
      MeetParticipantsCompanion(
        arrivalOrder: Value(nextOrder),
        checkedInAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> undoCheckIn(int participantId) =>
      (update(meetParticipants)..where((t) => t.id.equals(participantId))).write(
        const MeetParticipantsCompanion(
          arrivalOrder: Value(null),
          checkedInAt: Value(null),
        ),
      );

  /// Swaps this participant's arrival order with the neighbor immediately before/after them,
  /// letting the admin fix a mis-tapped check-in order.
  Future<void> moveParticipant(int meetId, int participantId, {required bool up}) {
    return transaction(() async {
      final checkedIn = await (select(meetParticipants)
            ..where((t) => t.meetId.equals(meetId) & t.arrivalOrder.isNotNull()))
          .get();
      checkedIn.sort((a, b) => a.arrivalOrder!.compareTo(b.arrivalOrder!));
      final index = checkedIn.indexWhere((p) => p.id == participantId);
      if (index == -1) return;
      final swapIndex = up ? index - 1 : index + 1;
      if (swapIndex < 0 || swapIndex >= checkedIn.length) return;

      final current = checkedIn[index];
      final neighbor = checkedIn[swapIndex];
      await (update(meetParticipants)..where((t) => t.id.equals(current.id)))
          .write(MeetParticipantsCompanion(arrivalOrder: Value(neighbor.arrivalOrder)));
      await (update(meetParticipants)..where((t) => t.id.equals(neighbor.id)))
          .write(MeetParticipantsCompanion(arrivalOrder: Value(current.arrivalOrder)));
    });
  }

  // ---- Matches ----

  Stream<List<MatchRecord>> watchMatches(int meetId) => (select(matchRecords)
        ..where((t) => t.meetId.equals(meetId))
        ..orderBy([(t) => OrderingTerm(expression: t.createdAt)]))
      .watch();

  /// Fills every currently-free court with a new match, drawn fairly from checked-in
  /// participants who aren't already in a pending match. Returns how many matches were made.
  Future<int> generateMatches(int meetId, int courtCount) {
    return transaction(() async {
      final participantRows = await (select(meetParticipants)
            ..where((t) => t.meetId.equals(meetId) & t.arrivalOrder.isNotNull()))
          .get();
      final pendingMatches = await (select(matchRecords)
            ..where((t) => t.meetId.equals(meetId) & t.status.equals('pending')))
          .get();

      final busyIds = <int>{};
      final occupiedCourts = <int>{};
      for (final match in pendingMatches) {
        busyIds.addAll([
          match.team1Player1Id,
          match.team1Player2Id,
          match.team2Player1Id,
          match.team2Player2Id,
        ]);
        occupiedCourts.add(match.courtNumber);
      }

      final candidates = participantRows
          .where((p) => !busyIds.contains(p.id))
          .map((p) => ParticipantForMatching(
                id: p.id,
                arrivalOrder: p.arrivalOrder!,
                gamesPlayed: p.gamesPlayed,
              ))
          .toList();
      final freeCourts = [
        for (var court = 1; court <= courtCount; court++)
          if (!occupiedCourts.contains(court)) court,
      ];

      final drafts = generateMatchDrafts(available: candidates, freeCourts: freeCourts);

      final gamesPlayedById = {for (final p in participantRows) p.id: p.gamesPlayed};
      for (final draft in drafts) {
        await into(matchRecords).insert(MatchRecordsCompanion.insert(
          meetId: meetId,
          courtNumber: draft.courtNumber,
          team1Player1Id: draft.team1[0],
          team1Player2Id: draft.team1[1],
          team2Player1Id: draft.team2[0],
          team2Player2Id: draft.team2[1],
        ));
        for (final participantId in [...draft.team1, ...draft.team2]) {
          final newCount = (gamesPlayedById[participantId] ?? 0) + 1;
          await (update(meetParticipants)..where((t) => t.id.equals(participantId)))
              .write(MeetParticipantsCompanion(gamesPlayed: Value(newCount)));
        }
      }
      return drafts.length;
    });
  }

  Future<void> enterScore(int matchId, int team1Score, int team2Score) =>
      (update(matchRecords)..where((t) => t.id.equals(matchId))).write(
        MatchRecordsCompanion(
          team1Score: Value(team1Score),
          team2Score: Value(team2Score),
          status: const Value('completed'),
          completedAt: Value(DateTime.now()),
        ),
      );
}
