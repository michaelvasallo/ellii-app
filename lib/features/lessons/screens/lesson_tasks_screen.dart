import 'package:flutter/material.dart';
import '../../tasks/models/task.dart';
import '../../tasks/widgets/task_list_tile.dart';

class LessonTasksScreen extends StatelessWidget {
  const LessonTasksScreen({super.key, required this.tasks});

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskListTile(task: tasks[index]);
      },
    );
  }
}
