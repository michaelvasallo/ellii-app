import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'constants/light_theme.dart';
import 'features/lessons/screens/lesson_list_screen.dart';

Future main() async {
  await dotenv.load();
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
