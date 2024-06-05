import 'package:flutter/material.dart';
import '../models/speaking_task.dart';

class SpeakingTaskScreen extends StatelessWidget {
  const SpeakingTaskScreen({super.key, required this.task});

  final SpeakingTask task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
      ),
      body: const Center(
        child: Text('Work on Speaking task here'),
      ),
    );
  }
}
