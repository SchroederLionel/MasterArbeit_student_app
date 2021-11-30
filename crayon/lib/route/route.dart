// Route Names
import 'package:crayon/providers/login/login_provider.dart';
import 'package:crayon/providers/navigation/navigation_provider.dart';
import 'package:crayon/providers/quiz/quiz_indicator.dart';
import 'package:crayon/providers/quiz/quiz_lobby_provider.dart';
import 'package:crayon/providers/quiz/scrore.dart' as provider_score;
import 'package:crayon/providers/quiz/time_provider.dart';
import 'package:crayon/providers/user/user_provider.dart';
import 'package:crayon/providers/util/error_provider.dart';
import 'package:crayon/screens/dashboard/dashboard.dart';
import 'package:crayon/screens/login/login.dart';
import 'package:crayon/screens/quiz/quiz_screen.dart';
import 'package:crayon/screens/quiz/quiz_screen_components.dart/score.dart';
import 'package:crayon/screens/splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String splash = 'splash';
const String login = 'login';
const String dashboard = 'dashboard';
const String score = 'score';
const String quiz = 'quiz';
Route<dynamic> controller(RouteSettings routerSettings) {
  switch (routerSettings.name) {
    case splash:
      return MaterialPageRoute(builder: (context) => const Splashscreen());
    case login:
      return MaterialPageRoute(
          builder: (context) => MultiProvider(providers: [
                ChangeNotifierProvider<ErrorProvider>(
                    create: (_) => ErrorProvider()),
                ChangeNotifierProvider<LoginProvider>(
                    create: (_) => LoginProvider())
              ], child: const Login()));
    case quiz:
      return MaterialPageRoute(
          builder: (context) => MultiProvider(
                providers: [
                  Provider<provider_score.Score>(
                      create: (_) => provider_score.Score()),
                  ChangeNotifierProvider<TimeProvider>(
                      create: (_) => TimeProvider()),
                  ChangeNotifierProvider<QuizIndicator>(
                      create: (context) => QuizIndicator()),
                ],
                child: const QuizScreen(),
              ));
    case dashboard:
      return MaterialPageRoute(
          builder: (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider<UserProvider>(
                      create: (_) => UserProvider(context: context)),
                  ChangeNotifierProvider<NavigationProvider>(
                      create: (_) => NavigationProvider()),
                  ChangeNotifierProvider<QuizLobbyProvider>(
                      create: (_) => QuizLobbyProvider(context: context))
                ],
                child: const Dashboard(),
              ));
    case score:
      var arg = routerSettings.arguments as double;
      return MaterialPageRoute(builder: (context) => Score(score: arg));
  }

  return MaterialPageRoute(builder: (context) => const Login());
}
