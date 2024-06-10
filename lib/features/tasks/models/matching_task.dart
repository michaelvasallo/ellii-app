import 'task.dart';

class MatchingTask extends Task {
  MatchingTask(super.id, super.title, super.instructions);

  @override
  String taskType() {
    return 'Matching';
  }

  @override
  String taskIconPath() {
    return 'assets/images/Task-Icon_Matching.png';
  }
}
