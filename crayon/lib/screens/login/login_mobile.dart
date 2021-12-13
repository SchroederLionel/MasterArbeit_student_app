import 'package:crayon/screens/login/components/body/body.dart';
import 'package:crayon/screens/login/components/body/components/options_row.dart';
import 'package:crayon/screens/login/components/title/app_title.dart';
import 'package:flutter/material.dart';

class LoginMobile extends StatelessWidget {
  const LoginMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        OptionsRow(),
        SizedBox(height: 30),
        AppTitle(),
        SizedBox(height: 30),
        Expanded(child: Body()),
      ],
    );
  }
}
