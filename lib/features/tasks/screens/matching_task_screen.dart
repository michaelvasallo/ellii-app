import 'package:flutter/material.dart';
import '../models/matching_task.dart';

class MatchingTaskScreen extends StatelessWidget {
  const MatchingTaskScreen({super.key, required this.task});

  final MatchingTask task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
      ),
      body: const Center(
        child: Text('Work on Matching task here'),
      ),
    );
  }
}
