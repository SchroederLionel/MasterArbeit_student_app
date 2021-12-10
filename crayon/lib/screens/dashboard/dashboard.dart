import 'package:crayon/providers/user/user_provider.dart';
import 'package:crayon/screens/dashboard/components/body/body.dart';
import 'package:crayon/screens/dashboard/components/day_quiz_indicator/day_quiz_indicator.dart';
import 'package:crayon/screens/dashboard/components/navigation/navigation.dart';
import 'package:crayon/screens/dashboard/components/title/title_dash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      var provider = Provider.of<UserProvider>(context, listen: false);
      await provider.getUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  DayQuizIndicator(),
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
