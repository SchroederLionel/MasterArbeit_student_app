import 'package:crayon/screens/dashboard/components/body.dart';
import 'package:crayon/screens/dashboard/components/day_time.dart';
import 'package:crayon/screens/dashboard/components/navigation.dart';
import 'package:crayon/screens/dashboard/components/quiz/quiz_indicator.dart';
import 'package:crayon/screens/dashboard/components/title_dash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Row(
        children: [
          Navigation(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: const [
                      QuizLobbyIndicator(),
                      Spacer(),
                      DayTime(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const TitleDash(),
                  const Divider(color: Colors.grey),
                  const Body()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
