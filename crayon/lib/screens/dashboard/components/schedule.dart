import 'package:crayon/datamodels/confirmation_dialog_data.dart';
import 'package:crayon/datamodels/lecture/lecture_schedule.dart';
import 'package:crayon/providers/quiz/quiz_lobby_provider.dart';
import 'package:crayon/providers/user/user_provider.dart';
import 'package:crayon/screens/dashboard/components/course_times.dart';
import 'package:crayon/screens/dashboard/components/question/question_dialog.dart';
import 'package:crayon/screens/dashboard/components/quiz/quiz_login.dart';
import 'package:crayon/state/enum.dart';
import 'package:crayon/widgets/confirmation_dialog.dart';
import 'package:crayon/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Schedule extends StatelessWidget {
  final LectureSchedule schedule;
  const Schedule({Key? key, required this.schedule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuizLobbyProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
      child: GestureDetector(
        onLongPress: () {
          showDialog(
              context: context,
              builder: (context) {
                return ConfirmationDialog(
                    confirmationDialogData:
                        ConfirmationDialogData(itemTitle: schedule.title));
              }).then((value) {
            if (value == true) {
              Provider.of<UserProvider>(context, listen: false)
                  .removeLecture(schedule.lectureId, context);
            }
          });
        },
        onTap: () {
          if (provider.state == NotifierState.loaded) {
            provider.showSnackBar(
                'You must leave your current quiz lobby to execute this operation',
                true);
          } else {
            if (schedule.isLobbyOpen) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return const QuizLogin();
                  }).then((value) {
                if (value is String) {
                  provider.set(schedule.lectureId, value, schedule.title);
                }
              });
            } else {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return const QuestionDialog();
                  }).then((value) {
                if (value is String) {
                  Provider.of<UserProvider>(context, listen: false)
                      .postQuestion(value, schedule.lectureId);
                }
              });
            }
          }
        },
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CourseTimes(
                startingTime: schedule.startingTime,
                endingTime: schedule.endingTime,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Card(
                  color: schedule.isLobbyOpen
                      ? Colors.greenAccent
                      : Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 7.0, bottom: 7.0, left: 7.0),
                      child: ListTile(
                          title: CustomText(
                            safetyText: schedule.title,
                            style: const TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          subtitle: CustomText(
                              additional: schedule.room,
                              textCode: 'room',
                              safetyText: 'Room',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Poppins')))),
                ),
              ),
            ]),
      ),
    );
  }
}
