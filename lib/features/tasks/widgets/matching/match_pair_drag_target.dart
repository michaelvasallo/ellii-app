import 'package:flutter/material.dart';

import '../../models/matching/match_pair.dart';
import 'word_chip.dart';

class MatchPairDragTarget extends StatelessWidget {
  const MatchPairDragTarget({
    super.key,
    required this.pair,
    required this.index,
    required this.onAccept,
  });

  final MatchPair pair;
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
            child: pair.matchedWord != null
                ? Draggable<String>(
                    data: pair.matchedWord!,
                    feedback: Material(
                      color: Colors.transparent,
                      child: WordChip.expanded(pair.matchedWord!),
                    ),
                    childWhenDragging: questionMark,
                    child: WordChip.expanded(pair.matchedWord!),
                  )
                : questionMark,
          ),
        );
      },
      onAcceptWithDetails: (details) => onAccept(index, details),
    );
  }
}
