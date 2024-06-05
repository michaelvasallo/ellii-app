import '../../tasks/models/task.dart';

class Lesson {
  Lesson(
    this.id,
    this.title,
    this.description,
    this.levels,
    this.focus,
    this.vocabulary,
    this.imageUrl,
    this.tasks,
  );

  final int id;
  final String title;
  final String description;
  final List<String> levels;
  final List<String> focus;
  final List<String> vocabulary;
  final String imageUrl;
  final List<Task> tasks;
}
