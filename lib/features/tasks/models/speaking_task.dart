import 'task.dart';

class SpeakingTask extends Task {
  SpeakingTask(super.id, super.title, super.instructions, this.phrases);

  final List<String> phrases;

  @override
  String taskType() {
    return 'Speaking';
  }

  @override
  String taskIconPath() {
    return 'assets/images/Task-Icon_Speaking.png';
  }
}
