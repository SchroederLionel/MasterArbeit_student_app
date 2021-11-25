import 'package:crayon/screens/dashboard/components/body.dart';
import 'package:crayon/screens/dashboard/components/day_time.dart';
import 'package:crayon/screens/dashboard/components/navigation.dart';
import 'package:crayon/screens/dashboard/components/title_dash.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Navigation(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  DayTime(),
                  SizedBox(height: 20),
                  TitleDash(),
                  Divider(color: Colors.grey),
                  Body()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
