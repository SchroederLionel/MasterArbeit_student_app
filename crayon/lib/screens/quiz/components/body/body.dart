import 'package:crayon/providers/quiz/question_right.dart';
import 'package:crayon/providers/quiz/quiz_indicator.dart';
import 'package:crayon/providers/quiz/time_provider.dart';
import 'package:crayon/screens/quiz/components/body/components/question_card/question_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
    var time = Provider.of<TimeProvider>(context, listen: false);
    return Flexible(
        child: PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: time.quizOptions.quiz.questions.length,
            itemBuilder: (BuildContext context, int index) {
              return MultiProvider(providers: [
                ChangeNotifierProvider<QuestionRight>(
                    create: (BuildContext context) => QuestionRight(
                        question: time.quizOptions.quiz.questions[index])),
              ], child: const QuestionCard());
            }));
  }
}
