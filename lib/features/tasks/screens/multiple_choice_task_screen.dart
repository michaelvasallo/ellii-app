import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../models/multiple_choice/multiple_choice_item.dart';
import '../models/multiple_choice_task.dart';
import '../models/task_result.dart';
import 'paginated_task_screen_state.dart';
import 'task_screen.dart';

class MultipleChoiceTaskScreen extends TaskScreen {
  const MultipleChoiceTaskScreen({super.key, required super.task});

  @override
  MultipleChoiceTaskScreenState createState() =>
      MultipleChoiceTaskScreenState();
}

class MultipleChoiceTaskScreenState extends PaginatedTaskScreenState {
  late List<MultipleChoiceItem> _items;

  @override
  void initState() {
    super.initState();
    resetTask();
  }

  @override
  void resetTask() {
    final questions = (widget.task as MultipleChoiceTask).questions;
    _items = questions.map((question) => MultipleChoiceItem(question)).toList();
    super.resetTask();
  }

  @override
  List getItems() {
    return _items;
  }

  @override
  bool get canSubmit => _items.every((item) => item.answer != null);

  @override
  void submit() {
    int correctAnswers = _items
        .where((item) => item.answer == item.question.correctOption)
        .length;

    result = TaskResult(
      body: 'You got $correctAnswers out of ${_items.length} correct.',
      score: correctAnswers / _items.length,
    );
    super.submitTask();
  }

  void _onAnswerSelected(int questionIndex, String answer) {
    setState(() {
      _items[questionIndex].answer = answer;
    });
  }

  @override
  Widget buildItem(BuildContext context, int index) {
    final item = _items[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MarkdownBody(
          data: item.question.body,
          styleSheet: MarkdownStyleSheet(
            p: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: 16),
        for (var option in item.question.options)
          RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: item.answer,
            onChanged: (value) {
              if (value != null) {
                _onAnswerSelected(index, value);
              }
            },
          ),
      ],
    );
  }
}
