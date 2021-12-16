import 'package:crayon/datamodels/quiz/response.dart';

/// A quiz contains questions and the corresponding responses.
/// Has the ability to be transformed into json and json into object of type question.
class Question {
  String question;
  List<Response> responses;
  Question({required this.question, required this.responses});

  factory Question.fromJson(Map<String, dynamic> json) {
    final question = json['question'] as String;
    final responseData = json['responses'] as List<dynamic>?;

    final responses = responseData != null
        ? responseData.map((response) => Response.fromJson(response)).toList()
        : <Response>[];

    return Question(question: question, responses: responses);
  }

  Map<String, dynamic> toJson() => {
        'question': question,
        'responses': responses.map((response) => response.toJson()).toList(),
      };
}
