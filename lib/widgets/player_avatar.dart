import 'package:flutter/material.dart';

const List<Color> _avatarPalette = [
  Color(0xFF2E7D5B),
  Color(0xFF1565C0),
  Color(0xFFC62828),
  Color(0xFF6A1B9A),
  Color(0xFFEF6C00),
  Color(0xFF00838F),
  Color(0xFFAD1457),
  Color(0xFF4E342E),
  Color(0xFF283593),
  Color(0xFF558B2F),
];

/// Deterministic color per player name, so the same person looks the same everywhere in
/// the app without needing to store a color on the Player record.
Color colorForName(String name) {
  final hash = name.trim().toLowerCase().codeUnits.fold<int>(0, (sum, unit) => sum + unit);
  return _avatarPalette[hash % _avatarPalette.length];
}

class PlayerAvatar extends StatelessWidget {
  final String name;
  final double radius;

  const PlayerAvatar({super.key, required this.name, this.radius = 20});

  @override
  Widget build(BuildContext context) {
    final trimmed = name.trim();
    final initial = trimmed.isNotEmpty ? trimmed.substring(0, 1).toUpperCase() : '?';
    return CircleAvatar(
      radius: radius,
      backgroundColor: colorForName(trimmed),
      foregroundColor: Colors.white,
      child: Text(
        initial,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: radius * 0.8),
      ),
    );
  }
}
