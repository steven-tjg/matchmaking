import '../data/database.dart';

enum MeetStatus { upcoming, live, completed }

/// A meet is `live` from its scheduled start until start + duration, `completed` once that
/// window has passed, and `upcoming` before it starts.
MeetStatus meetStatusOf(Meet meet, {DateTime? now}) {
  final current = now ?? DateTime.now();
  final start = meet.scheduledAt;
  final end = start.add(Duration(minutes: meet.durationMinutes));
  if (current.isBefore(start)) return MeetStatus.upcoming;
  if (current.isBefore(end)) return MeetStatus.live;
  return MeetStatus.completed;
}

bool isMeetPast(Meet meet, {DateTime? now}) =>
    meetStatusOf(meet, now: now) == MeetStatus.completed;
