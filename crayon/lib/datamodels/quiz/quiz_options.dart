import 'package:crayon/datamodels/quiz/quiz.dart';

class QuizOptions {
  String userName;
  String lectureId;
  Quiz quiz;
  QuizOptions({
    required this.userName,
    required this.lectureId,
    required this.quiz,
  });
}
