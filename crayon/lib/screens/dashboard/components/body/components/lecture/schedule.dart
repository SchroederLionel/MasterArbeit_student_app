import 'package:crayon/datamodels/confirmation_dialog_data.dart';
import 'package:crayon/datamodels/custom_snackbar.dart';
import 'package:crayon/datamodels/lecture/lecture_schedule.dart';
import 'package:crayon/providers/quiz/quiz_lobby_provider.dart';
import 'package:crayon/providers/user/user_provider.dart';
import 'package:crayon/screens/dashboard/components/body/components/lecture/course_times.dart';
import 'package:crayon/screens/dashboard/dialogs/question_dialog.dart';
import 'package:crayon/screens/dashboard/dialogs/quiz_login.dart';
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

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
          child: GestureDetector(
              onLongPress: () {
                showDialog(
                    barrierColor: Colors.black87,
                    context: context,
                    builder: (BuildContext context) {
                      return ConfirmationDialog(
                          confirmationDialogData: ConfirmationDialogData(
                              itemTitle: schedule.title,
                              textCode: 'delete-lecture',
                              safetyText:
                                  'Do you want to delete the lecture:'));
                    }).then((value) {
                  if (value == true) {
                    Provider.of<UserProvider>(context, listen: false)
                        .removeLecture(schedule.lectureId);
                  }
                });
              },
              onTap: () {
                if (provider.state == NotifierState.loaded) {
                  CustomSnackbar(
                          text: 'requires-leaving-lobby',
                          saftyString:
                              'You must leave your current quiz lobby to execute this operation',
                          isError: true,
                          context: context)
                      .showSnackBar();
                } else {
                  if (schedule.isLobbyOpen) {
                    showDialog(
                        barrierColor: Colors.black87,
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return const QuizLogin();
                        }).then((value) {
                      if (value is String) {
                        provider.joinLobby(
                            schedule.lectureId, value, schedule.title);
                      }
                    });
                  } else {
                    showDialog(
                        barrierColor: Colors.black87,
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
                        elevation: 4,
                        color: schedule.isLobbyOpen
                            ? Colors.greenAccent
                            : Theme.of(context).scaffoldBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5.0, bottom: 5.0, left: 3.0),
                            child: ListTile(
                                title: CustomText(
                                  overflow: TextOverflow.ellipsis,
                                  safetyText: schedule.title,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                subtitle: CustomText(
                                    additional: schedule.room,
                                    textCode: 'room',
                                    safetyText: 'Room',
                                    style: const TextStyle(
                                        fontSize: 12, fontFamily: 'Poppins')))),
                      ),
                    ),
                  ])),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 4, top: 2),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: CustomText(
                safetyText: schedule.type,
                textCode: schedule.type,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
