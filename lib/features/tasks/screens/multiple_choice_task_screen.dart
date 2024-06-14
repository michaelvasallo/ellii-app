import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../models/multiple_choice/multiple_choice_question.dart';
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
  late List<MultipleChoiceQuestion> questions;
  late Map<int, String> answers;

  @override
  void initState() {
    super.initState();
    resetTask();
  }

  @override
  void resetTask() {
    questions = (widget.task as MultipleChoiceTask).questions;
    answers = {};
    super.resetTask();
  }

  @override
  List getItems() {
    return questions;
  }

  @override
  bool get canSubmit => answers.length == questions.length;

  @override
  void submit() {
    int correctAnswers = answers.entries
        .where((entry) => questions[entry.key].correctOption == entry.value)
        .length;

    result = TaskResult(
      body: 'You got $correctAnswers out of ${questions.length} correct.',
      score: correctAnswers / questions.length,
    );
    super.submitTask();
  }

  void onAnswerSelected(int questionIndex, String answer) {
    setState(() {
      answers[questionIndex] = answer;
    });
  }

  @override
  Widget buildItem(BuildContext context, int index) {
    final question = questions[index];
    final selectedAnswer = answers[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MarkdownBody(
          data: question.question,
          styleSheet: MarkdownStyleSheet(
            p: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: 16),
        for (var option in question.options)
          RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: selectedAnswer,
            onChanged: (value) {
              if (value != null) {
                onAnswerSelected(index, value);
              }
            },
          ),
      ],
    );
  }
}
