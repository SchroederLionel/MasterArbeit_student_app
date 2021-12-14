import 'package:crayon/datamodels/quiz/quiz_result.dart';
import 'package:crayon/datamodels/quiz/response.dart';
import 'package:crayon/route/route.dart' as route;
import 'package:crayon/providers/quiz/question_right.dart';
import 'package:crayon/providers/quiz/quiz_indicator.dart';
import 'package:crayon/providers/quiz/time_provider.dart';
import 'package:crayon/state/enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Option extends StatelessWidget {
  final Response response;
  final int index;
  final String question;

  const Option({
    Key? key,
    required this.index,
    required this.response,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var quizIndicator = Provider.of<QuizIndicator>(context, listen: false);

    var time = Provider.of<TimeProvider>(context, listen: false);
    return Consumer<QuestionRight>(
        builder: (_, questionRight, __) => InkWell(
              onTap: () {
                questionRight.setNotifierState(NotifierState.loaded, response);
                quizIndicator.increament();
                if (response.isResponseRight) {
                  time.increment();
                }

                time.addResponse(question, response.isResponseRight);

                if (quizIndicator.isQuizFinished) {
                  time.stop();
                  Navigator.popAndPushNamed(context, route.score,
                      arguments: QuizResult(
                          userName: time.quizOptions.userName,
                          lectureId: time.quizOptions.lectureId,
                          totalAvailableScore: time.getMaximumScoreForQuiz(),
                          score: time.getUserScrore()));
                }
              },
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: questionRight.getColor(response)),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "${index + 1}. ${response.response}",
                  style: TextStyle(
                      color: questionRight.getColor(response), fontSize: 16),
                ),
              ),
            ));
  }
}
