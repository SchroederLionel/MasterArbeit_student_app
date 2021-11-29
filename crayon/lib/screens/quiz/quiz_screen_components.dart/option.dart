import 'package:crayon/datamodels/question.dart';

import 'package:crayon/providers/quiz/question_right.dart';
import 'package:crayon/providers/quiz/quiz_indicator.dart';

import 'package:crayon/providers/quiz/time_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Option extends StatelessWidget {
  final Response response;
  final int index;

  const Option({
    Key? key,
    required this.index,
    required this.response,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var quizIndicator = Provider.of<QuizIndicator>(context, listen: false);

    var time = Provider.of<TimeProvider>(context, listen: false);
    return Consumer<QuestionRight>(
        builder: (_, questionRight, __) => InkWell(
              onTap: () {
                /* questionRight.setNotifierState(
                    NotifierState.buttonPressed, response);*/
                quizIndicator.increament();
                time.addTimeTakenForQuestion(response.isResponseRight);

                if (quizIndicator.isQuizFinished) {
                  Navigator.pushNamed(context, 'score',
                      arguments: time.getAverageTimeTakenForQuiz());
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${index + 1}. ${response.response}",
                      style: TextStyle(
                          color: questionRight.getColor(response),
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
            ));
  }
}
