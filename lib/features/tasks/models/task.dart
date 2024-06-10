abstract class Task {
  Task(this.id, this.title, this.instructions);

  final int id;
  final String title;
  final String instructions;

  String taskType();
  String taskIconPath();
}
