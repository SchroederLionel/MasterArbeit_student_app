/// Class which allows to store a user response from the user. (During the quiz process)
/// Has the ability to transform from json and into json.
class Response {
  /// Rresponse is the question
  String response;
  bool isResponseRight;
  Response({required this.response, required this.isResponseRight});

  String get getResponse => response;
  bool get getResponseRight => isResponseRight;

  factory Response.fromJson(Map<String, dynamic> json) {
    final response = json['response'] as String;
    final isResponseRight = json['isResponseRight'] as bool;
    return Response(response: response, isResponseRight: isResponseRight);
  }

  Map<String, dynamic> toJson() =>
      {'response': response, 'isResponseRight': isResponseRight};
}
