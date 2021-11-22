class Question {
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
}

const List sample_data = [
  {
    "id": 1,
    "question":
        "Flutter is an open-source UI software development kit created by _____",
    "responses": [
      {"isResponseRight": false, "response": "Apple"},
      {"isResponseRight": true, "response": "Google"},
      {"isResponseRight": false, "response": "Facebook"},
      {"isResponseRight": false, "response": "Microsoft"},
      {"isResponseRight": false, "response": "Aldi"},
      {"isResponseRight": false, "response": "Zoom"}
    ],
  },
  {
    "id": 2,
    "question": "When did google release Flutter?",
    "responses": [
      {"isResponseRight": false, "response": "Jun 2017"},
      {"isResponseRight": true, "response": "Jun 2017"},
      {"isResponseRight": false, "response": "May 2017"},
      {"isResponseRight": false, "response": "May 2018"}
    ],
  },
  {
    "id": 3,
    "question": "A memory location that holds a single letter or number.",
    "responses": [
      {"isResponseRight": false, "response": "Double"},
      {"isResponseRight": false, "response": "Int"},
      {"isResponseRight": true, "response": "Char"},
      {"isResponseRight": false, "response": "Word"}
    ],
  },
  {
    "id": 4,
    "question": "What command do you use to output data to the screen?",
    "responses": [
      {"isResponseRight": false, "response": "Cin"},
      {"isResponseRight": false, "response": "Count>>"},
      {"isResponseRight": true, "response": "Cout>>"},
      {"isResponseRight": false, "response": "Output>>"}
    ],
  }
];

List<Question> questions =
    sample_data.map((question) => Question.fromJson(question)).toList();
