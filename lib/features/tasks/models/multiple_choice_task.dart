import 'task.dart';

class MultipleChoiceTask extends Task {
  MultipleChoiceTask(super.id, super.title, super.instructions);

  @override
  String taskType() {
    return 'Multiple Choice';
  }

  @override
  String taskIconPath() {
    return 'assets/images/Task-Icon_Multiple-Choice.png';
  }
}
