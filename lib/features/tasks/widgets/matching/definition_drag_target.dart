import 'package:flutter/material.dart';

import 'word_chip.dart';

class DefinitionDragTarget extends StatelessWidget {
  const DefinitionDragTarget({
    super.key,
    required this.word,
    required this.index,
    required this.onAccept,
  });

  final String? word;
  final int index;
  final Function(int, DragTargetDetails<String>) onAccept;

  @override
  Widget build(BuildContext context) {
    const Icon questionMark = Icon(
      Icons.question_mark,
      color: Colors.white,
      size: 24,
    );

    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 120,
          constraints: const BoxConstraints(minHeight: 56),
          decoration: BoxDecoration(
            color: candidateData.isEmpty
                ? Theme.of(context).colorScheme.surfaceContainer
                : Theme.of(context).colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: word != null
                ? Draggable<String>(
                    data: word,
                    feedback: Material(
                      color: Colors.transparent,
                      child: WordChip.expanded(word!),
                    ),
                    childWhenDragging: questionMark,
                    child: WordChip.expanded(word!),
                  )
                : questionMark,
          ),
        );
      },
      onAcceptWithDetails: (details) => onAccept(index, details),
    );
  }
}
