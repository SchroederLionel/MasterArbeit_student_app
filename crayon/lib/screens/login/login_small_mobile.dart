import 'package:crayon/screens/login/components/body/body.dart';
import 'package:crayon/screens/login/components/body/components/options_row.dart';
import 'package:flutter/material.dart';

class LoginSmallMobile extends StatelessWidget {
  const LoginSmallMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        OptionsRow(),
        SizedBox(height: 5),
        Expanded(child: Center(child: Body())),
      ],
    );
  }
}
