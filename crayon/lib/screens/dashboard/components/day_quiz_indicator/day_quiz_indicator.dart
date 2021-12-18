import 'package:crayon/screens/dashboard/components/day_quiz_indicator/components/day_time.dart';
import 'package:crayon/screens/dashboard/components/day_quiz_indicator/components/quiz_indicator.dart';
import 'package:crayon/widgets/network_sensitive.dart';
import 'package:flutter/material.dart';

class DayQuizIndicator extends StatelessWidget {
  const DayQuizIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: const [
        QuizLobbyIndicator(),
        Spacer(),
        NetworkSensitive(child: DayTime())
      ],
    );
  }
}
