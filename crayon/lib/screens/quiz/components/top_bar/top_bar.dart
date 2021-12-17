import 'package:crayon/datamodels/quiz/quiz_result.dart';
import 'package:crayon/providers/quiz/quiz_indicator.dart';
import 'package:crayon/providers/quiz/time_provider.dart';
import 'package:crayon/screens/quiz/components/top_bar/components/timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crayon/route/route.dart' as route;

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var quizIndicator = Provider.of<QuizIndicator>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                Provider.of<TimeProvider>(context, listen: false).stop();
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.redAccent,
              )),
          const Timer(),
          InkWell(
            onTap: () {
              quizIndicator.increament();
              if (quizIndicator.isQuizFinished) {
                var time = Provider.of<TimeProvider>(context, listen: false);
                time.stop();
                Navigator.popAndPushNamed(context, route.score,
                    arguments: QuizResult(
                        responses: time.responses,
                        userName: time.quizOptions.userName,
                        lectureId: time.quizOptions.lectureId,
                        totalAvailableScore: time.getMaximumScoreForQuiz(),
                        score: time.getUserScrore()));
              }
            },
            child: const Icon(Icons.arrow_right),
          )
        ],
      ),
    );
  }
}
