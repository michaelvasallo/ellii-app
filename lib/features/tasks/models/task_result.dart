class TaskResult {
  TaskResult({this.body = '', this.score}) : isPositive = true {
    initHeadline();
  }

  late String headline;
  final String body;
  final double? score;
  bool isPositive;

  initHeadline() {
    if (score == null) {
      headline = 'Thanks!';
    } else if (score == 1) {
      headline = 'Perfect!';
    } else if (score! >= 0.5) {
      headline = 'Good!';
    } else {
      headline = 'Keep going!';
      isPositive = false;
    }
  }
}
