import 'task.dart';

class SpeakingTask extends Task {
  SpeakingTask(super.title);

  @override
  String taskType() {
    return 'Speaking';
  }
}
