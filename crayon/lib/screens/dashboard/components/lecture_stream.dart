import 'package:crayon/datamodels/lecture/lecture.dart';
import 'package:crayon/datamodels/lecture/lecture_date.dart';
import 'package:crayon/datamodels/lecture/lecture_schedule.dart';
import 'package:crayon/datamodels/user/user.dart';
import 'package:crayon/providers/navigation/navigation_provider.dart';
import 'package:crayon/providers/quiz/quiz_lobby_provider.dart';
import 'package:crayon/screens/dashboard/components/schedule.dart';
import 'package:crayon/service/api_service.dart';
import 'package:crayon/widgets/custom_text.dart';
import 'package:crayon/widgets/error_text.dart';
import 'package:crayon/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LectureStream extends StatefulWidget {
  final User user;
  const LectureStream({Key? key, required this.user}) : super(key: key);

  @override
  _LectureStreamState createState() => _LectureStreamState();
}

class _LectureStreamState extends State<LectureStream> {
  late Stream<List<Lecture>> _stream;
  final PageController _controller = PageController(
      initialPage:
          DateTime.now().weekday == 0 ? 6 : DateTime.now().weekday - 1);
  @override
  initState() {
    _stream = ApiService().getMyLectures(widget.user.enrolledLectures);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      Provider.of<NavigationProvider>(context, listen: false)
          .setPageController(_controller);
    });
    return StreamBuilder<List<Lecture>>(
        stream: _stream,
        initialData: const [],
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return const LoadingWidget();
          } else if (snapshot.hasError) {
            return const ErrorText(
              error: 'Failure',
            );
          } else {
            return Expanded(
              child: PageView.builder(
                  controller: _controller,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 7,
                  itemBuilder: (_, index) {
                    List<LectureSchedule> schedules =
                        getSchedules(snapshot.data ?? [], index);
                    if (schedules.isEmpty) {
                      return Center(
                          child: CustomText(
                              style: Theme.of(context).textTheme.headline5,
                              textCode: 'a-day-free',
                              safetyText: 'A day free!'));
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: schedules.length,
                        itemBuilder: (_, i) {
                          return Schedule(schedule: schedules[i]);
                        });
                  }),
            );
          }
        });
  }

  List<LectureSchedule> getSchedules(List<Lecture> lectures, int day) {
    List<LectureSchedule> lectureSchedules = [];
    List<String> containsQuiz = [];
    for (int i = 0; i < lectures.length; i++) {
      List<LectureDate> dates = lectures[i].lectureDates;
      if (lectures[i].quiz != null) {
        containsQuiz.add(lectures[i].id);
      }
      for (int j = 0; j < dates.length; j++) {
        if (getDayIndex(dates[j].day) == day) {
          LectureSchedule schedule = LectureSchedule(
              quiz: lectures[i].quiz,
              lectureId: lectures[i].id,
              title: lectures[i].title,
              isLobbyOpen: lectures[i].isLobbyOpen,
              day: dates[j].day,
              room: dates[j].room,
              startingTime: dates[j].startingTime.toString(),
              endingTime: dates[j].endingTime.toString());
          lectureSchedules.add(schedule);
        }
      }
    }

    lectureSchedules.sort((a, b) => a.startingTime.compareTo(b.startingTime));
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      Provider.of<QuizLobbyProvider>(context, listen: false)
          .canJoin(lectureSchedules);
    });
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
