import 'multiple_choice/multiple_choice_question.dart';
import 'task.dart';

class MultipleChoiceTask extends Task {
  MultipleChoiceTask(super.id, super.title, super.instructions, this.questions);

  final List<MultipleChoiceQuestion> questions;

  @override
  String taskType() {
    return 'Multiple Choice';
  }

  @override
  String taskIconPath() {
    return 'assets/images/Task-Icon_Multiple-Choice.png';
  }
}
