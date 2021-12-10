import 'package:crayon/providers/quiz/quiz_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizLengthIndicator extends StatelessWidget {
  const QuizLengthIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizIndicator>(
      builder: (_, quizIndicator, __) {
        return Center(
          child: Text(
            quizIndicator.getIndicator(),
            style: TextStyle(
                fontFamily: 'Comforter',
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                fontSize: 42),
          ),
        );
      },
    );
  }
}
