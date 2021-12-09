import 'package:crayon/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CourseTimes extends StatelessWidget {
  final String startingTime, endingTime;
  const CourseTimes(
      {Key? key, required this.startingTime, required this.endingTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
              textCode: '',
              safetyText: startingTime,
              style: Theme.of(context).textTheme.bodyText2),
          const SizedBox(height: 10),
          Text(endingTime,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w700))
        ],
      ),
    );
  }
}
