import 'package:flutter/material.dart';

class WordChip extends StatelessWidget {
  const WordChip(this.word, {super.key}) : _expanded = false;
  const WordChip.expanded(this.word, {super.key}) : _expanded = true;

  final String word;
  final bool _expanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _expanded ? 120 : null,
      constraints: _expanded ? const BoxConstraints(minHeight: 56) : null,
      alignment: _expanded ? Alignment.center : null,
      padding: _expanded ? null : const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        word,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onTertiary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
