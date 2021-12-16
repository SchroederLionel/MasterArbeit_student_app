import 'package:crayon/datamodels/quiz/quiz.dart';

/// Lecture schedule is used by the dashboard.
class LectureSchedule {
  /// Lecture type (Lecture,Exercise or other)
  final String type;
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
      required this.type,
      required this.lectureId,
      required this.title,
      required this.day,
      required this.isLobbyOpen,
      required this.room,
      required this.startingTime,
      required this.endingTime});
}
