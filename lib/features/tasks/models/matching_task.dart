import 'matching/match_pair.dart';
import 'task.dart';

class MatchingTask extends Task {
  MatchingTask(super.id, super.title, super.instructions, this.matchPairs);

  final List<MatchPair> matchPairs;

  List<MatchPair> cloneMatchPairs() {
    return matchPairs
        .map((pair) => MatchPair(pair.word, pair.definition))
        .toList();
  }

  @override
  String taskType() {
    return 'Matching';
  }

  @override
  String taskIconPath() {
    return 'assets/images/Task-Icon_Matching.png';
  }
}
