import 'package:crayon/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class TitleDash extends StatelessWidget {
  const TitleDash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: CustomText(
          textCode: 'myLectures',
          safetyText: 'My Lectures',
          style: Theme.of(context).textTheme.headline2,
          textAlign: TextAlign.right,
          overflow: TextOverflow.fade,
        ))
      ],
    );
  }
}
