class QuizResponse {
  String question;
  bool wasResponseRight;

  QuizResponse({required this.question, required this.wasResponseRight});

  Map<String, dynamic> toJson() => {
        'question': question,
        'wasResponseRight': wasResponseRight,
      };
}
