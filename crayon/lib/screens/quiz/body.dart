import 'package:crayon/screens/quiz/quiz_screen_components.dart/options_row.dart';
import 'package:crayon/screens/quiz/quiz_screen_components.dart/quiz.dart';
import 'package:crayon/screens/quiz/quiz_screen_components.dart/quiz_length_indicator.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 2),
              child: OptionsRow(),
            ),
            SizedBox(height: 5),
            QuizLengthIndicator(),
            Divider(
              color: Colors.orangeAccent,
              thickness: 1.5,
              indent: 50,
              endIndent: 50,
            ),
            Expanded(child: Quiz())
          ],
        ))
      ],
    );
  }
}
