// Route Names
import 'package:crayon/providers/quiz/quiz_indicator.dart';
import 'package:crayon/providers/quiz/scrore.dart' as provider_score;
import 'package:crayon/providers/quiz/time_provider.dart';
import 'package:crayon/providers/util/error_provider.dart';
import 'package:crayon/screens/dashboard/dashboard.dart';
import 'package:crayon/screens/login/login.dart';
import 'package:crayon/screens/quiz/quiz_screen.dart';
import 'package:crayon/screens/quiz/quiz_screen_components.dart/score.dart';
import 'package:crayon/screens/quiz/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String login = 'login';
const String dashboard = 'dashboard';
const String quizWelcome = 'welcomeQuiz';
const String score = 'score';
const String quiz = 'quiz';
Route<dynamic> controller(RouteSettings routerSettings) {
  switch (routerSettings.name) {
    case login:
      return MaterialPageRoute(
          builder: (context) => MultiProvider(providers: [
                ChangeNotifierProvider<ErrorProvider>(
                    create: (_) => ErrorProvider())
              ], child: const Login()));
    case quizWelcome:
      return MaterialPageRoute(builder: (context) => const WelcomeScreen());
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
      return MaterialPageRoute(builder: (context) => const Dashboard());
    case score:
      var arg = routerSettings.arguments as double;
      return MaterialPageRoute(builder: (context) => Score(score: arg));
  }

  return MaterialPageRoute(builder: (context) => const WelcomeScreen());
}
