import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/meets_list_screen.dart';

void main() {
  runApp(const ProviderScope(child: MatchmakingApp()));
}

class MatchmakingApp extends StatelessWidget {
  const MatchmakingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matchmaking',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MeetsListScreen(),
    );
  }
}
