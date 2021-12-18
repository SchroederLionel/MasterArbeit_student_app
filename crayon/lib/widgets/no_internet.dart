import 'package:crayon/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Column(
        children: [
          const Icon(Icons.wifi_off, color: Colors.red, size: 24),
          CustomText(
            safetyText: 'No internet',
            textCode: 'no-internet',
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14),
          )
        ],
      ),
    );
  }
}
