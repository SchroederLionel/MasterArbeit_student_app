import 'package:crayon/datamodels/lecture/lecture.dart';
import 'package:crayon/datamodels/lecture/lecture_date.dart';
import 'package:crayon/datamodels/lecture/lecture_schedule.dart';
import 'package:crayon/providers/navigation/navigation_provider.dart';
import 'package:crayon/screens/dashboard/components/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final PageController _controller = PageController(
      initialPage:
          DateTime.now().weekday == 0 ? 6 : DateTime.now().weekday - 1);

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) =>
        Provider.of<NavigationProvider>(context, listen: false)
            .setPageController(_controller));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Lecture> lectures = lecture_data;

    return Expanded(
      child: PageView.builder(
          controller: _controller,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 7,
          itemBuilder: (_, index) {
            List<LectureSchedule> schedules = getSchedules(lectures, index);
            if (schedules.isEmpty) {
              return const Center(
                  child: Text('A day free!',
                      style: TextStyle(color: Colors.black)));
            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: schedules.length,
                itemBuilder: (context, i) {
                  return Schedule(schedule: schedules[i]);
                });
          }),
    );
  }

  List<LectureSchedule> getSchedules(List<Lecture> lectures, int day) {
    List<LectureSchedule> lectureSchedules = [];

    for (int i = 0; i < lectures.length; i++) {
      List<LectureDate> dates = lectures[i].lectureDates;
      for (int j = 0; j < dates.length; j++) {
        if (getDayIndex(dates[j].day) == day) {
          LectureSchedule schedule = LectureSchedule(
              title: lectures[i].title,
              day: dates[j].day,
              room: dates[j].room,
              startingTime: dates[j].startingTime,
              endingTime: dates[j].endingTime);
          lectureSchedules.add(schedule);
        }
      }
    }
    lectureSchedules.sort((a, b) => a.startingTime.compareTo(b.startingTime));
    return lectureSchedules;
  }

  int getDayIndex(String day) {
    switch (day) {
      case 'monday':
        return 0;
      case 'tuesday':
        return 1;
      case 'wednesday':
        return 2;
      case 'thursday':
        return 3;
      case 'friday':
        return 4;
      case 'saturday':
        return 5;
      default:
        return 6;
    }
  }
}
