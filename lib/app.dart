import 'package:flutter/material.dart';
import 'package:flutter_course_navigator/home_page.dart';
import 'package:flutter_course_navigator/theme_data_x.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context).m3Theme(),
      darkTheme: Theme.of(context).m3Theme(brightness: Brightness.dark),
      home: const HomePage(),
    );
  }
}
