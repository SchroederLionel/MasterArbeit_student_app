import 'package:crayon/datamodels/quiz/quiz.dart';

class LectureSchedule {
  final Quiz? quiz;
  final String lectureId;
  final String title;
  final String day;
  final String startingTime;
  final String endingTime;
  final String room;
  final bool isLobbyOpen;

  LectureSchedule(
      {required this.quiz,
      required this.lectureId,
      required this.title,
      required this.day,
      required this.isLobbyOpen,
      required this.room,
      required this.startingTime,
      required this.endingTime});
}
