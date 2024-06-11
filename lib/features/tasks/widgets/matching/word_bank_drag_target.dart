import 'package:flutter/material.dart';

import 'word_chip.dart';

class WordBankDragTarget extends StatelessWidget {
  const WordBankDragTarget({
    super.key,
    required this.wordBank,
    required this.onAccept,
  });

  final List<String> wordBank;
  final Function(DragTargetDetails<String>) onAccept;

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: candidateData.isEmpty
              ? Theme.of(context).colorScheme.surfaceContainer
              : Theme.of(context).colorScheme.tertiaryContainer,
          constraints: const BoxConstraints(minHeight: 80),
          child: Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: wordBank.map((word) {
              return Draggable<String>(
                data: word,
                feedback: Material(
                  color: Colors.transparent,
                  child: WordChip(word),
                ),
                childWhenDragging: Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    word,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.transparent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                child: WordChip(word),
              );
            }).toList(),
          ),
        );
      },
      onAcceptWithDetails: onAccept,
    );
  }
}
