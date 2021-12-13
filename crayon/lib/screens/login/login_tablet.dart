import 'package:crayon/screens/login/components/body/body.dart';
import 'package:crayon/screens/login/components/body/components/options_row.dart';
import 'package:crayon/screens/login/components/title/app_title.dart';
import 'package:flutter/material.dart';

class LoginTablet extends StatelessWidget {
  const LoginTablet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OptionsRow(),
        const SizedBox(height: 30),
        const Spacer(),
        Card(
          elevation: 16,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: SizedBox(
            width: 720,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 45.0),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: const [
                  AppTitle(),
                  SizedBox(height: 30),
                  Body(),
                ],
              ),
            ),
          ),
        ),
        const Spacer()
      ],
    );
  }
}
