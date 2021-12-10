import 'package:crayon/providers/quiz/question_right.dart';
import 'package:crayon/screens/quiz/quiz_screen_components.dart/option.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var questionP = Provider.of<QuestionRight>(context, listen: false);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: Colors.white10.withAlpha(80)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            questionP.question.question,
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontSize: 18, color: Colors.black),
          ),
          const SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: questionP.question.responses.length,
                  itemBuilder: (context, index) {
                    return Option(
                        index: index,
                        response: questionP.question.responses[index]);
                  }))
        ],
      ),
    );
  }
}
