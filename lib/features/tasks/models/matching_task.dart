import 'task.dart';

class MatchingTask extends Task {
  MatchingTask(super.title);

  @override
  String taskType() {
    return 'Matching';
  }
}
