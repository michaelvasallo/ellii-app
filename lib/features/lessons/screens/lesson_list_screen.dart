import 'package:flutter/material.dart';

import '../../../constants/lessons.dart';
import '../widgets/lesson_card.dart';

class LessonListScreen extends StatelessWidget {
  const LessonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lessons')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 2;
            if (constraints.maxWidth >= 800) {
              crossAxisCount = 4;
            } else if (constraints.maxWidth >= 450) {
              crossAxisCount = 3;
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 4 / 3,
              ),
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                return LessonCard(lesson: lessons[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
