import 'package:crayon/service/auth_service.dart';
import 'package:crayon/widgets/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crayon/route/route.dart' as route;

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      User? user = AuthService().currentUser;
      if (user == null) {
        Navigator.of(context).pushReplacementNamed(route.login);
      } else {
        Navigator.of(context).pushReplacementNamed(route.dashboard);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/crayon.png'),
            const LoadingWidget()
          ],
        ),
      ),
    );
  }
}
