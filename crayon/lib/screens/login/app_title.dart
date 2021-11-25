import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Crayon',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: 'Comforter',
          fontSize: 48,
          color: Colors.yellow,
          fontWeight: FontWeight.bold),
    );
  }
}
