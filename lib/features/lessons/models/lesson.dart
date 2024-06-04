import '../../tasks/models/task.dart';

class Lesson {
  Lesson(this.id, this.title, this.overview, this.imageUrl, this.tasks);

  final int id;
  final String title;
  final String overview;
  final String imageUrl;
  final List<Task> tasks;
}
