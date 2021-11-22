import 'package:crayon/datamodels/question.dart';
import 'package:crayon/providers/quiz/question_right.dart';
import 'package:crayon/providers/quiz/quiz_indicator.dart';
import 'package:crayon/screens/quiz/quiz_screen_components.dart/question_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<QuizIndicator>(context, listen: false)
        .setController(_pageController);
    return PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: questions.length,
        itemBuilder: (BuildContext context, int index) {
          return MultiProvider(providers: [
            ChangeNotifierProvider<QuestionRight>(
                create: (BuildContext context) =>
                    QuestionRight(question: questions[index])),
          ], child: const QuestionCard());
        });
  }
}
