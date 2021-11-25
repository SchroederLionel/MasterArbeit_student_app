import 'package:crayon/datamodels/lecture/lecture_date.dart';
import 'package:crayon/datamodels/lecture/lecture_schedule.dart';
import 'package:crayon/datamodels/lecture/slide.dart';

class Lecture {
  final String id;
  final String title;
  final String tid;
  List<LectureDate> lectureDates;

  List<Slide> slides;

  Lecture(this.lectureDates, this.slides,
      {required this.tid, required this.title, required this.id});

  factory Lecture.fromJson(Map<String, dynamic>? json) {
    final tid = json!['uid'] as String;
    final id = json['id'] as String;
    final title = json['title'] as String;

    final slidesData = json['slides'] as List<dynamic>?;
    final slides = slidesData != null
        ? slidesData.map((slide) => Slide.fromJson(slide)).toList()
        : <Slide>[];

    final lectureData = json['lectureDates'] as List<dynamic>?;
    final lecturesDates = lectureData != null
        ? lectureData
            .map((lectureDate) => LectureDate.fromJson(lectureDate))
            .toList()
        : <LectureDate>[];

    Lecture lecture =
        Lecture(lecturesDates, slides, tid: tid, title: title, id: id);

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

LectureDate monday_morning = LectureDate(
    room: 'A12',
    day: 'monday',
    startingTime: '08:00',
    endingTime: '10:00',
    type: 'lecture');

LectureDate thuesday_night = LectureDate(
    room: 'A12',
    day: 'tuesday',
    startingTime: '18:00',
    endingTime: '21:00',
    type: 'exercise');

LectureDate thuesday_midnight = LectureDate(
    room: 'A12',
    day: 'tuesday',
    startingTime: '22:00',
    endingTime: '24:00',
    type: 'exercise');

LectureDate date3 = LectureDate(
    room: 'B3',
    day: 'friday',
    startingTime: '09:30',
    endingTime: '10:30',
    type: 'exercise');

LectureDate friday_mit = LectureDate(
    room: 'B1',
    day: 'friday',
    startingTime: '12:00',
    endingTime: '14:00',
    type: 'lecture');

Lecture l1 = Lecture([thuesday_night, monday_morning], [],
    tid: '1', title: 'Webdevelopemnt', id: '1');

Lecture l2 = Lecture([date3], [], tid: '1', title: 'App Development', id: '2');

Lecture l3 = Lecture([thuesday_night, monday_morning, friday_mit], [],
    tid: '1', title: 'Advanced Operating Systems', id: '3');

Lecture l4 =
    Lecture([date3], [], tid: '1', title: 'Operating Systems', id: '4');

Lecture l5 = Lecture([friday_mit, thuesday_midnight], [],
    tid: '1', title: 'Testing Systems', id: '5');

List<Lecture> lecture_data = [l1, l2, l3, l4, l5];
