import 'package:flutter/material.dart';

import '../models/matching/match_pair.dart';
import '../models/matching_task.dart';
import '../models/task_result.dart';
import '../widgets/matching/match_pair_drag_target.dart';
import '../widgets/matching/word_bank_drag_target.dart';
import 'task_screen.dart';

class MatchingTaskScreen extends TaskScreen {
  const MatchingTaskScreen({super.key, required super.task});

  @override
  MatchingTaskScreenState createState() => MatchingTaskScreenState();
}

class MatchingTaskScreenState extends TaskScreenState {
  late List<String> wordBank;
  late List<MatchPair> matchPairs;

  @override
  void initState() {
    super.initState();
    resetTask();
  }

  @override
  void resetTask() {
    matchPairs = (widget.task as MatchingTask).cloneMatchPairs();
    wordBank = List.from(matchPairs.map((pair) => pair.word));
    matchPairs.shuffle();
    wordBank.shuffle();
  }

  @override
  void submitTask() {
    int correctMatches =
        matchPairs.where((pair) => pair.matchedWord == pair.word).length;
    result = TaskResult(
      body: 'You got $correctMatches out of ${matchPairs.length} correct.',
      score: correctMatches / matchPairs.length,
    );
    super.submitTask();
  }

  void onAcceptToMatchPair(int index, DragTargetDetails<String> details) {
    setState(() {
      final newWord = details.data;

      // Find the current position of the new word
      int currentIndex =
          matchPairs.indexWhere((pair) => pair.matchedWord == newWord);

      // Remove from current position
      if (currentIndex != -1) {
        matchPairs[currentIndex].matchedWord = null;
      }

      // Swap the words if the target already has a word
      if (matchPairs[index].matchedWord != null) {
        final oldWord = matchPairs[index].matchedWord!;
        if (currentIndex == -1) {
          wordBank.add(oldWord);
        } else {
          matchPairs[currentIndex].matchedWord = oldWord;
        }
      }

      wordBank.remove(newWord);
      matchPairs[index].matchedWord = newWord;
    });
  }

  void onAcceptToWordBank(DragTargetDetails<String> details) {
    setState(() {
      final word = details.data;

      // Find the current position of the word
      int currentIndex =
          matchPairs.indexWhere((pair) => pair.matchedWord == word);

      // Remove from current position and add back to available words
      if (currentIndex != -1) {
        matchPairs[currentIndex].matchedWord = null;
        wordBank.add(word);
      }
    });
  }

  @override
  Widget buildTaskView() {
    return Column(
      children: [
        WordBankDragTarget(
          wordBank: wordBank,
          onAccept: onAcceptToWordBank,
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              for (int index = 0; index < matchPairs.length; index++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.tertiary,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          (index + 1).toString(),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 8),
                      MatchPairDragTarget(
                        pair: matchPairs[index],
                        index: index,
                        onAccept: onAcceptToMatchPair,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(matchPairs[index].definition),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton.icon(
                    icon: const Icon(Icons.auto_fix_high, size: 16),
                    label: const Text("I'm finished"),
                    onPressed: wordBank.isEmpty ? submitTask : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
