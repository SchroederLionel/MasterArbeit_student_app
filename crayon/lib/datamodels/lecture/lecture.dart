import 'package:crayon/datamodels/lecture/lecture_date.dart';

import 'package:crayon/datamodels/lecture/slide.dart';

class Lecture {
  final bool isLobbyOpen;
  final String id;
  final String title;
  final String tid;
  List<LectureDate> lectureDates;

  List<Slide> slides;

  Lecture(this.lectureDates, this.slides,
      {required this.tid,
      required this.title,
      required this.id,
      required this.isLobbyOpen});

  factory Lecture.fromJson(Map<String, dynamic>? json) {
    final tid = json!['uid'] as String;
    final id = json['id'] as String;
    final title = json['title'] as String;
    final isLobbyOpen = json['isLobbyOpen'] ?? false;
    print(tid);
    print(id);
    /* final slidesData = json['slides'] as List<dynamic>?;
    final slides = slidesData != null
        ? slidesData.map((slide) => Slide.fromJson(slide)).toList()
        : <Slide>[];*/

    final lectureData = json['lectureDates'] as List<dynamic>?;
    print(lectureData);
    final lecturesDates = lectureData != null
        ? lectureData
            .map((lectureDate) => LectureDate.fromJson(lectureDate))
            .toList()
        : <LectureDate>[];

    print(lecturesDates.first.endingTime);
    Lecture lecture = Lecture(lecturesDates, [],
        tid: tid, title: title, id: id, isLobbyOpen: isLobbyOpen);

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
