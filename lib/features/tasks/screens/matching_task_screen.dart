import 'package:flutter/material.dart';

import '../models/matching/matching_item.dart';
import '../models/matching_task.dart';
import '../models/task_result.dart';
import '../widgets/matching/definition_drag_target.dart';
import '../widgets/matching/word_bank_drag_target.dart';
import 'task_screen.dart';

class MatchingTaskScreen extends TaskScreen {
  const MatchingTaskScreen({super.key, required super.task});

  @override
  MatchingTaskScreenState createState() => MatchingTaskScreenState();
}

class MatchingTaskScreenState extends TaskScreenState {
  late List<String> _wordBank;
  late List<MatchingItem> _items;

  @override
  void initState() {
    super.initState();
    resetTask();
  }

  @override
  void resetTask() {
    final pairs = (widget.task as MatchingTask).pairs;
    _items = pairs.map((pair) => MatchingItem(pair)).toList();
    _wordBank = pairs.map((pair) => pair.word).toList();
    _items.shuffle();
    _wordBank.shuffle();
  }

  @override
  void submitTask() {
    int correctMatches =
        _items.where((item) => item.matchedWord == item.pair.word).length;
    result = TaskResult(
      body: 'You got $correctMatches out of ${_items.length} correct.',
      score: correctMatches / _items.length,
    );
    super.submitTask();
  }

  void _onAcceptToMatchPair(int index, DragTargetDetails<String> details) {
    setState(() {
      final newWord = details.data;

      // Find the current position of the new word
      int currentIndex =
          _items.indexWhere((pair) => pair.matchedWord == newWord);

      // Remove from current position
      if (currentIndex != -1) {
        _items[currentIndex].matchedWord = null;
      }

      // Swap the words if the target already has a word
      if (_items[index].matchedWord != null) {
        final oldWord = _items[index].matchedWord!;
        if (currentIndex == -1) {
          _wordBank.add(oldWord);
        } else {
          _items[currentIndex].matchedWord = oldWord;
        }
      }

      _wordBank.remove(newWord);
      _items[index].matchedWord = newWord;
    });
  }

  void _onAcceptToWordBank(DragTargetDetails<String> details) {
    setState(() {
      final word = details.data;

      // Find the current position of the word
      int currentIndex = _items.indexWhere((pair) => pair.matchedWord == word);

      // Remove from current position and add back to available words
      if (currentIndex != -1) {
        _items[currentIndex].matchedWord = null;
        _wordBank.add(word);
      }
    });
  }

  @override
  Widget buildTaskView() {
    return Column(
      children: [
        WordBankDragTarget(
          wordBank: _wordBank,
          onAccept: _onAcceptToWordBank,
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              for (int index = 0; index < _items.length; index++)
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
                      DefinitionDragTarget(
                        word: _items[index].matchedWord,
                        index: index,
                        onAccept: _onAcceptToMatchPair,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(_items[index].pair.definition),
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
                    onPressed: _wordBank.isEmpty ? submitTask : null,
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
