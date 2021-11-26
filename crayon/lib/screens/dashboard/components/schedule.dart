import 'package:crayon/datamodels/lecture/lecture_schedule.dart';
import 'package:crayon/l10n/app_localizations.dart';
import 'package:crayon/providers/quiz/quiz_lobby_provider.dart';
import 'package:crayon/screens/dashboard/components/course_times.dart';
import 'package:crayon/screens/dashboard/components/question/question_dialog.dart';
import 'package:crayon/screens/dashboard/components/quiz/quiz_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Schedule extends StatelessWidget {
  final LectureSchedule schedule;
  const Schedule({Key? key, required this.schedule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTranslation = AppLocalizations.of(context);
    final provider = Provider.of<QuizLobbyProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
      child: InkWell(
        onTap: () {
          if (provider.isWaiting) {
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
                  provider.set(schedule.lectureId, true, value, schedule.title);
                }
              });
            } else {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return const QuestionDialog();
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
                    padding:
                        const EdgeInsets.only(top: 7.0, bottom: 7.0, left: 7.0),
                    child: ListTile(
                        title: Text(
                          schedule.title,
                          style: const TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(
                          '${appTranslation!.translate('room') ?? "Room"}: ${schedule.room}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Poppins'),
                        )),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
