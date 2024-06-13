import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../models/multiple_choice/multiple_choice_question.dart';
import '../models/multiple_choice_task.dart';
import '../models/task_result.dart';
import 'task_screen.dart';

class MultipleChoiceTaskScreen extends TaskScreen {
  const MultipleChoiceTaskScreen({super.key, required super.task});

  @override
  MultipleChoiceTaskScreenState createState() =>
      MultipleChoiceTaskScreenState();
}

class MultipleChoiceTaskScreenState extends TaskScreenState {
  late List<MultipleChoiceQuestion> questions;
  late Map<int, String> answers;
  int currentIndex = 0;
  int previousIndex = 0;

  @override
  void initState() {
    super.initState();
    resetTask();
  }

  @override
  void resetTask() {
    questions = (widget.task as MultipleChoiceTask).questions;
    answers = {};
    currentIndex = 0;
  }

  bool get allQuestionsAnswered => answers.length == questions.length;

  void onAnswerSelected(int questionIndex, String answer) {
    setState(() {
      answers[questionIndex] = answer;
    });
  }

  void nextQuestion() {
    setState(() {
      previousIndex = currentIndex;
      currentIndex++;
    });
  }

  void previousQuestion() {
    setState(() {
      previousIndex = currentIndex;
      currentIndex--;
    });
  }

  @override
  void submitTask() {
    int correctAnswers = answers.entries
        .where((entry) => questions[entry.key].correctOption == entry.value)
        .length;

    result = TaskResult(
      body: 'You got $correctAnswers out of ${questions.length} correct.',
      score: correctAnswers / questions.length,
    );
    super.submitTask();
  }

  @override
  Widget buildTaskView() {
    final question = questions[currentIndex];
    final selectedAnswer = answers[currentIndex];

    return Stack(
      children: [
        Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 440,
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                final curvedAnimation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOutCubic,
                );
                final isForward = previousIndex < currentIndex;
                final offset = child.key == ValueKey<int>(currentIndex)
                    ? Offset(isForward ? 1 : -1, 0)
                    : Offset(isForward ? -1 : 1, 0);

                return SlideTransition(
                  position: Tween<Offset>(
                    begin: offset,
                    end: Offset.zero,
                  ).animate(curvedAnimation),
                  child: FadeTransition(
                    opacity: curvedAnimation,
                    child: child,
                  ),
                );
              },
              child: SingleChildScrollView(
                key: ValueKey<int>(currentIndex),
                padding: const EdgeInsets.all(16),
                child: Column(
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
                            onAnswerSelected(currentIndex, value);
                          }
                        },
                      ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                    )
                  ],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton.filled(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: currentIndex > 0 ? previousQuestion : null,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '${currentIndex + 1} of ${questions.length}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(width: 16),
                    currentIndex + 1 == questions.length
                        ? IconButton.filled(
                            icon: const Icon(Icons.check),
                            onPressed: allQuestionsAnswered ? submitTask : null,
                          )
                        : IconButton.filled(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: nextQuestion,
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
