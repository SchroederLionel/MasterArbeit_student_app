import 'package:crayon/providers/quiz/quiz_indicator.dart';
import 'package:crayon/screens/quiz/quiz_screen_components.dart/timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OptionsRow extends StatelessWidget {
  const OptionsRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.close,
              color: Colors.redAccent,
            )),
        const Timer(),
        InkWell(
          onTap: () {
            Provider.of<QuizIndicator>(context, listen: false).increament();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), border: Border.all()),
            child: Text(
              'Skip',
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12),
            ),
          ),
        )
      ],
    );
  }
}
