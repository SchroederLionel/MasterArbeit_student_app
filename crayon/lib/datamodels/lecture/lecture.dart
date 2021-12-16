import 'package:crayon/datamodels/lecture/lecture_date.dart';
import 'package:crayon/datamodels/lecture/slide.dart';
import 'package:crayon/datamodels/quiz/quiz.dart';

class Lecture {
  final Quiz? quiz;
  final bool isLobbyOpen;
  final String id;
  final String title;
  final String tid;
  List<LectureDate> lectureDates;

  List<Slide> slides;

  Lecture(this.lectureDates, this.slides,
      {required this.quiz,
      required this.tid,
      required this.title,
      required this.id,
      required this.isLobbyOpen});

  factory Lecture.fromJson(Map<String, dynamic>? json) {
    final tid = json!['uid'] as String;
    final id = json['id'] as String;
    final title = json['title'] as String;
    final isLobbyOpen = json['isLobbyOpen'] ?? false;

    /* final slidesData = json['slides'] as List<dynamic>?;
    final slides = slidesData != null
        ? slidesData.map((slide) => Slide.fromJson(slide)).toList()
        : <Slide>[];*/

    final currentQuizData = json['currentQuiz'];
    final currentQuiz =
        json['currentQuiz'] != null ? Quiz.fromJson(currentQuizData) : null;

    final lectureData = json['lectureDates'] as List<dynamic>?;

    final lecturesDates = lectureData != null
        ? lectureData
            .map((lectureDate) => LectureDate.fromJson(lectureDate))
            .toList()
        : <LectureDate>[];

    Lecture lecture = Lecture(lecturesDates, [],
        quiz: currentQuiz,
        tid: tid,
        title: title,
        id: id,
        isLobbyOpen: isLobbyOpen);

    return lecture;
  }

  bool getLectureForDay(String day) {
    for (int i = 0; i < lectureDates.length; i++) {
      if (lectureDates[i].day == day) {
        return true;
      }
    }
    return false;
  }
}
