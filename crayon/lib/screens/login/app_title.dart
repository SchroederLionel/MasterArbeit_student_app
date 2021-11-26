import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text('Hello',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 70.0,
              fontWeight: FontWeight.bold,
              height: 0.80,
            )),
        Row(
          children: const [
            Text('There',
                style: TextStyle(
                  fontSize: 70.0,
                  fontWeight: FontWeight.w700,
                  height: 0.80,
                )),
            Text('.',
                style: TextStyle(
                    fontSize: 70.0,
                    height: 0.80,
                    fontWeight: FontWeight.w700,
                    color: Colors.orangeAccent))
          ],
        )
      ],
    );
  }
}
