import 'package:flutter/material.dart';

import '../models/matching_task.dart';
import '../models/multiple_choice_task.dart';
import '../models/speaking_task.dart';
import '../models/task.dart';
import '../screens/matching_task_screen.dart';
import '../screens/multiple_choice_task_screen.dart';
import '../screens/speaking_task_screen.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (task.runtimeType) {
      case const (MatchingTask):
        page = MatchingTaskScreen(task: task as MatchingTask);
        break;
      case const (MultipleChoiceTask):
        page = MultipleChoiceTaskScreen(task: task as MultipleChoiceTask);
        break;
      case const (SpeakingTask):
        page = SpeakingTaskScreen(task: task as SpeakingTask);
        break;
      default:
        page = const Center(child: Text('Unknown task type'));
    }

    return ListTile(
      leading: Image.asset(
        task.taskIconPath(),
        width: 40,
        height: 40,
      ),
      title: Text(task.title, style: Theme.of(context).textTheme.titleMedium),
      subtitle:
          Text(task.taskType(), style: Theme.of(context).textTheme.labelMedium),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },
    );
  }
}
