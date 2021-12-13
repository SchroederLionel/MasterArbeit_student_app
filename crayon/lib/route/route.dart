// Route Names
import 'package:crayon/constants/constants.dart';
import 'package:crayon/datamodels/quiz/quiz_options.dart';
import 'package:crayon/datamodels/quiz/quiz_result.dart';

import 'package:crayon/providers/navigation/navigation_provider.dart';
import 'package:crayon/providers/quiz/quiz_indicator.dart';
import 'package:crayon/providers/quiz/quiz_lobby_provider.dart';
import 'package:crayon/providers/quiz/time_provider.dart';

import 'package:crayon/providers/user/user_provider.dart';
import 'package:crayon/providers/util/error_provider.dart';
import 'package:crayon/screens/dashboard/dashboard.dart';
import 'package:crayon/screens/login/login.dart';
import 'package:crayon/screens/quiz/quiz_screen.dart';
import 'package:crayon/screens/score/score.dart';
import 'package:crayon/screens/splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String splash = '';
const String login = '/login';
const String dashboard = '/dashboard';
const String score = '/score';
const String quiz = '/quiz';
Route<dynamic> controller(RouteSettings routerSettings) {
  resetView();
  switch (routerSettings.name) {
    case splash:
      return MaterialPageRoute(builder: (context) => const Splashscreen());
    case login:
      return MaterialPageRoute(
          builder: (context) => MultiProvider(providers: [
                ChangeNotifierProvider<ErrorProvider>(
                    create: (_) => ErrorProvider()),
              ], child: const Login()));
    case quiz:
      var arg = routerSettings.arguments as QuizOptions;
      return MaterialPageRoute(
          builder: (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider<TimeProvider>(
                      create: (context) =>
                          TimeProvider(context: context, quizOptions: arg)),
                  ChangeNotifierProvider<QuizIndicator>(
                      create: (context) => QuizIndicator(
                          numberOfQuestions: arg.quiz.questions.length)),
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
                      create: (_) => QuizLobbyProvider(context: context)),
                ],
                child: const Dashboard(),
              ));
    case score:
      var arg = routerSettings.arguments as QuizResult;
      return MaterialPageRoute(builder: (context) => Score(quizResult: arg));
  }

  return MaterialPageRoute(
      builder: (context) => MultiProvider(providers: [
            ChangeNotifierProvider<ErrorProvider>(
                create: (_) => ErrorProvider()),
          ], child: const Login()));
  ;
}
