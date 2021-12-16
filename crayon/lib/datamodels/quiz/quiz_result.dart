import 'package:crayon/datamodels/quiz/quiz_response.dart';

/// QuizResult from the user.
/// Has the ability to transform the object into json. (without the totalScore)
class QuizResult {
  /// Answers of the user containing the question and the response.
  final List<QuizResponse> responses;

  /// the maximum avilable score for a specific quiz.
  final int totalAvailableScore;

  /// The score the user achived in the quiz.
  final int score;

  /// Username selected by the user.
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
