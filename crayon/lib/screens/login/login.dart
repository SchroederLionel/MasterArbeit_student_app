import 'package:crayon/screens/login/app_title.dart';
import 'package:crayon/screens/login/login_card.dart';
import 'package:crayon/screens/login/options_row.dart';

import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: const [
                  OptionsRow(),
                  AppTitle(),
                  SizedBox(height: 20),
                  LoginCard(),

                  //
                ])),
      ),
    );
  }
}
