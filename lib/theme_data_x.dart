import 'package:flutter/material.dart';

extension ThemeDataX on ThemeData {
  ThemeData m3Theme({
    Brightness brightness = Brightness.light,
    Color color = Colors.yellow,
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: color,
        brightness: brightness,
      ),
    );
  }
}
