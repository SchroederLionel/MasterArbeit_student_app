/// User selected response to question.
/// Has the abilitiy to be transformed into json
class QuizResponse {
  /// Which question the user did.
  String question;

  /// Did the user answered the question right.
  bool wasResponseRight;

  QuizResponse({required this.question, required this.wasResponseRight});

  Map<String, dynamic> toJson() => {
        'question': question,
        'wasResponseRight': wasResponseRight,
      };
}
