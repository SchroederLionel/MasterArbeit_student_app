import 'package:crayon/datamodels/quiz/quiz_result.dart';
import 'package:crayon/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  final QuizResult quizResult;

  const Score({Key? key, required this.quizResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Text(
                '${quizResult.score}/${quizResult.totalAvailableScore}',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontFamily: 'Comforter',
                    ),
              ),
              CustomButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Theme.of(context).primaryColor,
                text: 'Back to Dashboard',
                icon: Icons.dashboard,
              )
            ],
          ),
        ),
      ),
    );
  }
}
