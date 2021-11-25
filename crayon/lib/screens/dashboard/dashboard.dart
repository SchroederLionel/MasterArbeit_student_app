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
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const Navigation(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 10.0),
                  child: Column(
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
        ),
      ),
    );
  }
}
