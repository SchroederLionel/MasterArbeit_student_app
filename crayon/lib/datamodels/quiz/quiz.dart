import 'package:crayon/datamodels/quiz/questions.dart';

class Quiz {
  int? seconds;
  String id;
  String title;
  List<Question> questions;

  Quiz(
      {required this.id,
      required this.title,
      required this.questions,
      this.seconds});

  setId(String id) => this.id = id;

  factory Quiz.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final title = json['title'] as String;
    final seconds = json['seconds'] as int?;
    final questionData = json['questions'] as List<dynamic>?;
    final questions = questionData != null
        ? questionData.map((questions) => Question.fromJson(questions)).toList()
        : <Question>[];
    Quiz quiz =
        Quiz(id: id, title: title, questions: questions, seconds: seconds);
    quiz.setId(id);
    return quiz;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'questions': questions.map((question) => question.toJson()).toList()
      };
}
