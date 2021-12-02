import 'package:crayon/datamodels/lecture/lecture.dart';
import 'package:crayon/datamodels/lecture/lecture_date.dart';
import 'package:crayon/datamodels/lecture/lecture_schedule.dart';
import 'package:crayon/providers/navigation/navigation_provider.dart';
import 'package:crayon/providers/user/user_provider.dart';
import 'package:crayon/screens/dashboard/components/schedule.dart';
import 'package:crayon/state/enum.dart';
import 'package:crayon/widgets/error_text.dart';
import 'package:crayon/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Stream<List<String>> _lectureIdStream;

  final PageController _controller = PageController(
      initialPage:
          DateTime.now().weekday == 0 ? 6 : DateTime.now().weekday - 1);

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      var provider = Provider.of<UserProvider>(context, listen: false);
      await provider.getUser();
      _lectureIdStream = provider.getEnrolledLectureIds();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (_, provider, __) {
      if (provider.state == NotifierState.initial) {
        return const SizedBox();
      } else if (provider.state == NotifierState.loading) {
        return const LoadingWidget();
      } else {
        return provider.user.fold((failure) => ErrorText(error: failure.code),
            (user) {
          return StreamBuilder<List<String>>(
            stream: _lectureIdStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return ErrorText(error: snapshot.error.toString());
              } else if (!snapshot.hasData) {
                return const LoadingWidget();
              } else {
                if (snapshot.data!.isEmpty) {
                  return Container();
                } else {
                  return StreamBuilder<List<Lecture>>(
                    stream:
                        provider.lecturesStream(snapshot.data as List<String>),
                    builder: (context, snap) {
                      if (snap.hasError) {
                        return ErrorText(error: snapshot.error.toString());
                      } else if (snapshot.data == null) {
                        return const LoadingWidget();
                      } else {
                        Provider.of<NavigationProvider>(context, listen: false)
                            .setPageController(_controller);
                        return Expanded(
                          child: PageView.builder(
                              controller: _controller,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 7,
                              itemBuilder: (_, index) {
                                List<LectureSchedule> schedules =
                                    getSchedules(snap.data ?? [], index);
                                if (schedules.isEmpty) {
                                  return const Center(
                                      child: Text('A day free!',
                                          style:
                                              TextStyle(color: Colors.black)));
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
                    },
                  );
                }
              }
            },
          );
        });
      }
    });
  }

  List<LectureSchedule> getSchedules(List<Lecture> lectures, int day) {
    List<LectureSchedule> lectureSchedules = [];

    for (int i = 0; i < lectures.length; i++) {
      List<LectureDate> dates = lectures[i].lectureDates;
      for (int j = 0; j < dates.length; j++) {
        if (getDayIndex(dates[j].day) == day) {
          LectureSchedule schedule = LectureSchedule(
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
