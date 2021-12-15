import 'package:crayon/datamodels/lecture/lecture.dart';
import 'package:crayon/datamodels/lecture/lecture_date.dart';
import 'package:crayon/datamodels/lecture/lecture_schedule.dart';
import 'package:crayon/providers/navigation/navigation_provider.dart';
import 'package:crayon/providers/quiz/quiz_lobby_provider.dart';
import 'package:crayon/providers/user/user_provider.dart';
import 'package:crayon/screens/dashboard/components/body/components/lecture/schedule.dart';

import 'package:crayon/service/api_service.dart';
import 'package:crayon/widgets/custom_text.dart';
import 'package:crayon/widgets/error_text.dart';
import 'package:crayon/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LectureStream extends StatefulWidget {
  const LectureStream({Key? key}) : super(key: key);

  @override
  _LectureStreamState createState() => _LectureStreamState();
}

class _LectureStreamState extends State<LectureStream> {
  //Stream<List<Lecture>>? _stream;
  late final PageController _controller;
  @override
  initState() {
    var day = Provider.of<NavigationProvider>(context, listen: false).day;
    _controller = PageController(initialPage: day);
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      Provider.of<NavigationProvider>(context, listen: false)
          .setPageController(_controller);
    });
    /*_stream = ApiService().getMyLectures(
        Provider.of<UserProvider>(context, listen: false)
            .user!
            .enrolledLectures);*/
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Lecture>>(
        stream: ApiService().getMyLectures(
            Provider.of<UserProvider>(context, listen: false)
                .user!
                .enrolledLectures),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(fontSize: 18),
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
              type: dates[j].type,
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
