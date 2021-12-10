import 'package:crayon/screens/quiz/components/body/body.dart';
import 'package:crayon/screens/quiz/components/body/components/top_bar/top_bar.dart';

import 'package:crayon/screens/quiz/quiz_screen_components.dart/quiz_length_indicator.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          TopBar(),
          SizedBox(height: 5),
          QuizLengthIndicator(),
          Divider(
            color: Colors.orangeAccent,
            thickness: 1.5,
            indent: 50,
            endIndent: 50,
          ),
          Body()
        ],
      )),
    );
  }
}
