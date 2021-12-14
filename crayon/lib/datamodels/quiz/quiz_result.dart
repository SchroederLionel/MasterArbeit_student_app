import 'package:crayon/datamodels/quiz/quiz_response.dart';

class QuizResult {
  final List<QuizResponse> responses;
  final int totalAvailableScore;
  final int score;
  final String userName;
  final String lectureId;
  QuizResult(
      {required this.responses,
      required this.totalAvailableScore,
      required this.score,
      required this.lectureId,
      required this.userName});

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'score': score,
        'responses': responses.map((response) => response.toJson()).toList(),
      };
}
