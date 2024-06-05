import 'package:flutter/material.dart';

import '../models/lesson.dart';
import '../widgets/tag_list.dart';

class LessonOverviewScreen extends StatelessWidget {
  const LessonOverviewScreen({
    super.key,
    required this.lesson,
    required this.launchTasks,
  });

  final Lesson lesson;
  final VoidCallback launchTasks;

  @override
  Widget build(BuildContext context) {
    bool isScreenWide = MediaQuery.sizeOf(context).width > 450;

    return ListView(
      children: [
        Hero(
          tag: 'lesson_image_${lesson.id}',
          child: Image.asset(
            lesson.imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 160,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: Column(
            children: [
              Flex(
                direction: isScreenWide ? Axis.horizontal : Axis.vertical,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.lightbulb_outline, size: 16),
                      const SizedBox(width: 8),
                      Text(lesson.levels[0]),
                    ],
                  ),
                  const SizedBox(width: 16, height: 4),
                  Row(
                    children: [
                      const Icon(Icons.school_outlined, size: 16),
                      const SizedBox(width: 8),
                      Text(lesson.levels[1]),
                    ],
                  ),
                  const SizedBox(width: 16, height: 4),
                  Row(
                    children: [
                      const Icon(Icons.directions_bus_outlined, size: 16),
                      const SizedBox(width: 8),
                      Text(lesson.levels[2]),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(lesson.description),
              const SizedBox(height: 8),
              ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  FilledButton.icon(
                    onPressed: launchTasks,
                    icon: const Icon(Icons.devices),
                    label: const Text('Launch Tasks'),
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          color: Theme.of(context).colorScheme.surfaceContainer,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TagList(title: 'Focus', tags: lesson.focus),
              const SizedBox(height: 16),
              TagList(title: 'Vocabulary', tags: lesson.vocabulary),
            ],
          ),
        ),
      ],
    );
  }
}
