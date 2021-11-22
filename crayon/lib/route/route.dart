// Route Names
import 'package:crayon/providers/quiz/quiz_indicator.dart';
import 'package:crayon/providers/quiz/time_provider.dart';
import 'package:crayon/screens/quiz/quiz_screen.dart';
import 'package:crayon/screens/quiz/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String login = 'login';
const String quizWelcome = 'welcomeQuiz';
const String quiz = 'quiz';
Route<dynamic> controller(RouteSettings routerSettings) {
  switch (routerSettings.name) {
    case quizWelcome:
      return MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      );
    case quiz:
      return MaterialPageRoute(
          builder: (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider<TimeProvider>(
                      create: (BuildContext context) => TimeProvider()),
                  ChangeNotifierProvider<QuizIndicator>(
                      create: (BuildContext context) => QuizIndicator()),
                ],
                child: const QuizScreen(),
              ));
  }

  return MaterialPageRoute(builder: (context) => const WelcomeScreen());
}
