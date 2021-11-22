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
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        const Timer(),
        TextButton(
          onPressed: () {
            Provider.of<QuizIndicator>(context, listen: false).increament();
          },
          child: const Text(
            'Skip',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: const BorderSide(color: Colors.white)))),
        )
      ],
    );
  }
}
