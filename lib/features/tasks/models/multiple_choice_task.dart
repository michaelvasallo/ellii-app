import 'task.dart';

class MultipleChoiceTask extends Task {
  MultipleChoiceTask(super.title);

  @override
  String taskType() {
    return 'Multiple Choice';
  }
}
