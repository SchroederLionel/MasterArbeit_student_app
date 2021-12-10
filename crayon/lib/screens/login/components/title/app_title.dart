import 'package:crayon/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const CustomText(
            style: TextStyle(
              fontSize: 70.0,
              fontWeight: FontWeight.bold,
              height: 0.80,
            ),
            overflow: null,
            textAlign: null,
            textCode: 'hello',
            safetyText: 'Hello'),
        Row(
          children: const [
            CustomText(
                overflow: null,
                textAlign: null,
                style: TextStyle(
                  fontSize: 70.0,
                  fontWeight: FontWeight.w700,
                  height: 0.80,
                ),
                textCode: 'there',
                safetyText: 'There'),
            Text('.',
                style: TextStyle(
                    fontSize: 70.0,
                    height: 0.80,
                    fontWeight: FontWeight.w700,
                    color: Colors.orangeAccent))
          ],
        )
      ],
    );
  }
}
