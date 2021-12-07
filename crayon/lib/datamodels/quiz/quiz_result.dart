class QuizResult {
  final int totalAvailableScore;
  final int score;
  final String userName;
  final String lectureId;
  QuizResult(
      {required this.totalAvailableScore,
      required this.score,
      required this.lectureId,
      required this.userName});
}
