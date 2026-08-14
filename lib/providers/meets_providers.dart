import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import 'database_provider.dart';

final meetsListProvider = StreamProvider<List<Meet>>((ref) {
  return ref.watch(databaseProvider).watchMeets();
});

final meetProvider = StreamProvider.family<Meet, int>((ref, meetId) {
  return ref.watch(databaseProvider).watchMeet(meetId);
});

final rosterProvider = StreamProvider<List<Player>>((ref) {
  return ref.watch(databaseProvider).watchRoster();
});
