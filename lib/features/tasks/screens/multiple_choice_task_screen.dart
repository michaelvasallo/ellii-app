import 'package:flutter/material.dart';
import '../models/multiple_choice_task.dart';

class MultipleChoiceTaskScreen extends StatelessWidget {
  const MultipleChoiceTaskScreen({super.key, required this.task});

  final MultipleChoiceTask task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
      ),
      body: const Center(
        child: Text('Work on Multiple Choice task here'),
      ),
    );
  }
}
