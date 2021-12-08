import 'package:flutter/cupertino.dart';

/*class Question {
  final String question;
  final List<Response> responses;
  Question({required this.question, required this.responses});

  factory Question.fromJson(Map<String, dynamic> json) {
    final question = json['question'] as String;
    final responseData = json['responses'] as List<dynamic>?;

    final responses = responseData != null
        ? responseData.map((response) => Response.fromJson(response)).toList()
        : <Response>[];

    return Question(question: question, responses: responses);
  }
}

class Response {
  final String response;
  final bool isResponseRight;

  Response({required this.response, required this.isResponseRight});
  factory Response.fromJson(Map<String, dynamic> json) {
    final response = json['response'] as String;
    final isResponseRight = json['isResponseRight'] as bool;
    return Response(response: response, isResponseRight: isResponseRight);
  }

  Map<String, dynamic> toJson() =>
      {'response': response, 'isResponseRight': isResponseRight};

  @override
  bool operator ==(other) {
    return (other is Response) &&
        other.response == response &&
        other.isResponseRight == isResponseRight;
  }

  @override
  int get hashCode => hashValues(response, isResponseRight);
}*/
