import 'package:flutter/material.dart';

class TagList extends StatelessWidget {
  const TagList({
    super.key,
    required this.title,
    required this.tags,
  });

  final String title;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (var str in tags)
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Text(
                    str,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              )
          ],
        )
      ],
    );
  }
}
