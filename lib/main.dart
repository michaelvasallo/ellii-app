import 'package:flutter/material.dart';

import 'constants/light_theme.dart';
import 'features/lessons/screens/lesson_list_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ellii',
      theme: lightTheme,
      home: const LessonListScreen(),
    );
  }
}
