import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../models/task.dart';
import '../models/task_result.dart';

enum TaskViewState { start, task, result }

abstract class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key, required this.task});

  final Task task;

  @override
  TaskScreenState createState();
}

abstract class TaskScreenState extends State<TaskScreen> {
  TaskViewState currentView = TaskViewState.start;
  TaskResult result = TaskResult();

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
            MarkdownBody(
              data: widget.task.instructions,
              styleSheet: MarkdownStyleSheet(
                textAlign: WrapAlignment.center,
              ),
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
    return Container(
      color:
          result.isPositive ? const Color(0xFF7CD1A7) : const Color(0xFFF9D549),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                result.headline,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 16),
              Text(
                result.body,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: restartTask,
                icon: const Icon(Icons.refresh),
                label: const Text('Try again'),
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all(Colors.black),
                  iconColor: WidgetStateProperty.all(Colors.black),
                ),
              ),
              const SizedBox(height: 8),
              FilledButton.icon(
                label: const Text('Back to Tasks'),
                icon: const Icon(Icons.arrow_back, size: 16),
                onPressed: () {
                  Navigator.pop(context);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
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
