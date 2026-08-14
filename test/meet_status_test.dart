import 'package:flutter_test/flutter_test.dart';
import 'package:matchmaking/data/database.dart';
import 'package:matchmaking/utils/meet_status.dart';

Meet _meet({required DateTime scheduledAt, required int durationMinutes}) => Meet(
      id: 1,
      name: 'Test meet',
      scheduledAt: scheduledAt,
      durationMinutes: durationMinutes,
      location: 'Court 1',
      courtCount: 1,
      createdAt: DateTime(2026, 1, 1),
    );

void main() {
  final reference = DateTime(2026, 8, 14, 12, 0);

  test('meet starting in the future is upcoming', () {
    final meet = _meet(
      scheduledAt: reference.add(const Duration(hours: 1)),
      durationMinutes: 60,
    );
    expect(meetStatusOf(meet, now: reference), MeetStatus.upcoming);
    expect(isMeetPast(meet, now: reference), isFalse);
  });

  test('meet currently within its duration window is live', () {
    final meet = _meet(
      scheduledAt: reference.subtract(const Duration(minutes: 30)),
      durationMinutes: 90,
    );
    expect(meetStatusOf(meet, now: reference), MeetStatus.live);
    expect(isMeetPast(meet, now: reference), isFalse);
  });

  test('meet whose start + duration is before now is completed', () {
    final meet = _meet(
      scheduledAt: reference.subtract(const Duration(hours: 3)),
      durationMinutes: 60,
    );
    expect(meetStatusOf(meet, now: reference), MeetStatus.completed);
    expect(isMeetPast(meet, now: reference), isTrue);
  });

  test('meet ending exactly now is completed (end boundary is exclusive)', () {
    final meet = _meet(
      scheduledAt: reference.subtract(const Duration(minutes: 60)),
      durationMinutes: 60,
    );
    expect(meetStatusOf(meet, now: reference), MeetStatus.completed);
  });

  test('meet starting exactly now is live, not upcoming', () {
    final meet = _meet(scheduledAt: reference, durationMinutes: 60);
    expect(meetStatusOf(meet, now: reference), MeetStatus.live);
  });
}
