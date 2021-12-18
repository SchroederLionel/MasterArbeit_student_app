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

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userEnrolledLectures = Provider.of<UserProvider>(context, listen: false)
        .user!
        .enrolledLectures;
    return StreamBuilder<List<LectureSchedule>>(
        stream: ApiService().getMyLectures(userEnrolledLectures),
        initialData: null,
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return const LoadingWidget();
          } else if (snapshot.hasError) {
            return const ErrorText(
              error: 'Failure',
            );
          } else if (snapshot.data == null) {
            return const Center(
                child: CustomText(
                    safetyText: "You aren't enrolled in any course",
                    textCode: 'no-courses-enrolled'));
          } else {
            List<LectureSchedule> schedules = snapshot.data ?? [];
            WidgetsBinding.instance!.addPostFrameCallback((_) async {
              Provider.of<UserProvider>(context, listen: false)
                  .autoRemove(schedules)
                  .then((value) {
                Provider.of<NavigationProvider>(context, listen: false)
                    .setPageController(_controller);
                Provider.of<QuizLobbyProvider>(context, listen: false)
                    .canJoin(snapshot.data ?? []);
              });
            });

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

  List<LectureSchedule> getSchedules(List<LectureSchedule> schedules, int day) {
    List<LectureSchedule> lectureSchedules = [];
    for (LectureSchedule schedule in schedules) {
      if (getDayIndex(schedule.day) == day) {
        LectureSchedule nSchedule = LectureSchedule(
            type: schedule.type,
            quiz: schedule.quiz,
            lectureId: schedule.lectureId,
            title: schedule.title,
            isLobbyOpen: schedule.isLobbyOpen,
            day: schedule.day,
            room: schedule.room,
            startingTime: schedule.startingTime,
            endingTime: schedule.endingTime);
        lectureSchedules.add(nSchedule);
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
