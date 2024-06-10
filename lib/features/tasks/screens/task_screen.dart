import 'package:flutter/material.dart';

import '../models/task.dart';

enum TaskViewState { start, task, result }

abstract class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key, required this.task});

  final Task task;

  @override
  TaskScreenState createState();
}

abstract class TaskScreenState extends State<TaskScreen> {
  TaskViewState currentView = TaskViewState.start;
  String resultText = '';

  void startTask() {
    setState(() {
      currentView = TaskViewState.task;
    });
  }

  void submitTask() {
    setState(() {
      currentView = TaskViewState.result;
    });
  }

  void restartTask() {
    setState(() {
      currentView = TaskViewState.start;
      resetTask();
    });
  }

  Widget buildStartView() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(
              widget.task.taskIconPath(),
              width: 80,
              height: 80,
            ),
            const SizedBox(height: 16),
            Text(
              widget.task.taskType(),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            Text(
              widget.task.instructions,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              label: const Text('Start'),
              icon: const Icon(Icons.arrow_forward, size: 16),
              onPressed: startTask,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResultView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(resultText),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: restartTask,
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title),
      ),
      body: buildCurrentView(),
    );
  }

  Widget buildCurrentView() {
    switch (currentView) {
      case TaskViewState.start:
        return buildStartView();
      case TaskViewState.task:
        return buildTaskView();
      case TaskViewState.result:
        return buildResultView();
      default:
        return buildStartView();
    }
  }

  Widget buildTaskView();

  void resetTask();
}
