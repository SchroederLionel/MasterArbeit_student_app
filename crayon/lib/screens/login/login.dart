import 'package:crayon/screens/login/app_title.dart';
import 'package:crayon/screens/login/body.dart';
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
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 14.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  OptionsRow(),
                  SizedBox(height: 30),
                  AppTitle(),
                  SizedBox(height: 30),
                  Body(),
                ])),
      ),
    );
  }
}
