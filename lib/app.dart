import 'package:flutter/material.dart';
import 'package:flutter_course_navigator/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: m3Theme(),
      darkTheme: m3Theme(brightness: Brightness.dark),
      home: const HomePage(),
    );
  }
}

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
