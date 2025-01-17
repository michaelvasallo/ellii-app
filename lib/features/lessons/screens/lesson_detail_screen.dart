import 'package:flutter/material.dart';

import '../models/lesson.dart';
import 'lesson_overview_screen.dart';
import 'lesson_tasks_screen.dart';

class LessonDetailScreen extends StatefulWidget {
  const LessonDetailScreen({super.key, required this.lesson});

  final Lesson lesson;

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  int _selectedIndex = 0;

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _launchTasks() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      LessonOverviewScreen(lesson: widget.lesson, launchTasks: _launchTasks),
      LessonTasksScreen(tasks: widget.lesson.tasks),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson.title),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 450) {
            return Row(
              textDirection: TextDirection.rtl,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: pages[_selectedIndex],
                ),
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _onDestinationSelected,
                  labelType: NavigationRailLabelType.selected,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.info_outline),
                      label: Text('Overview'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.devices),
                      label: Text('Tasks'),
                    ),
                  ],
                  elevation: 4,
                ),
              ],
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: pages[_selectedIndex],
                ),
                NavigationBar(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _onDestinationSelected,
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.info_outline),
                      label: 'Overview',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.devices),
                      label: 'Tasks',
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
