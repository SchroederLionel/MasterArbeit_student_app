import 'package:crayon/datamodels/lecture/lecture_schedule.dart';
import 'package:crayon/screens/dashboard/components/course_times.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Schedule extends StatelessWidget {
  final LectureSchedule schedule;
  const Schedule({Key? key, required this.schedule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                color: Colors.orangeAccent,
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
                            fontSize: 21,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                        'Room: ${schedule.room}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Poppins'),
                      )),
                ),
              ),
            )
          ]),
    );
  }
}