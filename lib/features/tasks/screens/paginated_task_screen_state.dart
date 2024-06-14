import 'package:flutter/material.dart';

import 'task_screen.dart';

abstract class PaginatedTaskScreenState extends TaskScreenState {
  int currentIndex = 0;
  int previousIndex = 0;

  @override
  @mustCallSuper
  void resetTask() {
    currentIndex = 0;
  }

  List getItems();

  void nextItem() {
    setState(() {
      previousIndex = currentIndex;
      currentIndex++;
    });
  }

  void previousItem() {
    setState(() {
      previousIndex = currentIndex;
      currentIndex--;
    });
  }

  bool get hasNext => currentIndex + 1 < getItems().length;
  bool get hasPrevious => currentIndex > 0;
  bool get canSubmit;

  void submit();

  Widget buildItem(BuildContext context, int index);

  @override
  Widget buildTaskView() {
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
                child: Container(
                  margin: const EdgeInsets.only(bottom: 80),
                  child: buildItem(context, currentIndex),
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
                      onPressed: hasPrevious ? previousItem : null,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '${currentIndex + 1} of ${getItems().length}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(width: 16),
                    hasNext
                        ? IconButton.filled(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: nextItem,
                          )
                        : IconButton.filled(
                            icon: const Icon(Icons.check),
                            onPressed: canSubmit ? submit : null,
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
