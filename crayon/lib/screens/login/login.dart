import 'package:crayon/screens/login/login_mobile.dart';
import 'package:crayon/screens/login/login_small_mobile.dart';
import 'package:crayon/screens/login/login_tablet.dart';
import 'package:crayon/widgets/responsive.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 14.0),
            child: Responsive(
              smallMobile: LoginSmallMobile(),
              mobile: LoginMobile(),
              tablet: LoginTablet(),
            )),
      ),
    );
  }
}
