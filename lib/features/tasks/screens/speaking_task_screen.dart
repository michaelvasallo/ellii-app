import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../services/pronunciation_service.dart';
import '../../../utils/show_snack_bar.dart';
import '../models/speaking/speaking_item.dart';
import '../models/speaking_task.dart';
import '../models/task_result.dart';
import '../widgets/speaking/audio_handler.dart';
import 'paginated_task_screen_state.dart';
import 'task_screen.dart';

class SpeakingTaskScreen extends TaskScreen {
  const SpeakingTaskScreen({super.key, required super.task});

  @override
  SpeakingTaskScreenState createState() => SpeakingTaskScreenState();
}

class SpeakingTaskScreenState extends PaginatedTaskScreenState {
  late List<SpeakingItem> _items;
  late PronunciationService _pronunciationService;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _pronunciationService = PronunciationService();
    resetTask();
  }

  @override
  void resetTask() {
    final phrases = (widget.task as SpeakingTask).phrases;
    _items = phrases.map((phrase) => SpeakingItem(phrase)).toList();
    super.resetTask();
  }

  @override
  List getItems() {
    return _items;
  }

  @override
  bool get canSubmit => _items.every((item) => item.rating != null);

  @override
  void submit() {
    final totalScore =
        _items.fold<int>(0, (sum, item) => sum + (item.rating ?? 0));
    final maxScore = _items.length * 5;

    result = TaskResult(
      body: 'You got a score of ${(totalScore / maxScore * 100).round()}%.',
      score: totalScore / maxScore,
    );
    super.submitTask();
  }

  void _assessPronunciation(String path, int index) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final score =
          await _pronunciationService.call(path, _items[index].phrase);
      setState(() {
        _items[index].rating = score;
      });
    } catch (e) {
      if (mounted) {
        showSnackBar(context, 'Error assessing pronunciation: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget buildRating(int? rating) {
    if (_isLoading) {
      return SizedBox(
        height: 24,
        width: 120,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: LinearProgressIndicator(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      );
    }
    if (rating == null) return const SizedBox(height: 24);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Theme.of(context).colorScheme.tertiary,
        );
      })
          .animate(interval: 50.ms)
          .fadeIn(duration: 300.ms)
          .slide(begin: const Offset(0, 0.5), end: const Offset(0, 0)),
    );
  }

  @override
  Widget buildItem(BuildContext context, int index) {
    final item = _items[index];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          item.phrase,
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        AudioHandler(
          item: item,
          onRecordComplete: (filePath) {
            if (filePath != null) {
              _assessPronunciation(filePath, index);
            }
          },
        ),
        const SizedBox(height: 16),
        buildRating(item.rating),
      ],
    );
  }
}
