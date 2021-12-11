import 'dart:async';
import 'package:crayon/datamodels/quiz/quiz_options.dart';
import 'package:flutter/material.dart';

///
class TimeProvider extends ChangeNotifier {
  final QuizOptions quizOptions;

  BuildContext context;

  final Stopwatch _watch;
  late Timer _timer;
  int maxDuration = 100;
  int remainingDuration = 100;

  int _questionsAnsweredRight = 0;

  /// getTotalAmountOfPointsAvailableFor answering the right questions.
  /// Each correct response awards the user with 20 points.
  int getTotalAmountOfPointForEachQuestion() {
    return quizOptions.quiz.questions.length * 20;
  }

  int getRemainingTimeFromQuiz() {
    return remainingDuration;
  }

  /// Each available second rewards the player with 20 points.
  int getPointsFromRemainingTime() {
    return remainingDuration * 2;
  }

  int getMaximumScoreForQuiz() {
    return (getTotalAmountOfPointForEachQuestion() +
            (maxDuration - quizOptions.quiz.questions.length) * 2) *
        quizOptions.quiz.questions.length;
  }

  int getUserScrore() {
    int score = (_questionsAnsweredRight * 20 + remainingDuration * 2) *
        _questionsAnsweredRight;
    int maxScore = getMaximumScoreForQuiz();
    if (score > maxScore) {
      return maxScore;
    }
    return score;
  }

  void increment() {
    _questionsAnsweredRight++;
  }

  void stop() {
    _watch.stop();
    _timer.cancel();
  }

  TimeProvider({
    required this.context,
    required this.quizOptions,
  }) : _watch = Stopwatch();

  void start() {
    _watch.start();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_watch.elapsed.inSeconds <= maxDuration) {
        remainingDuration = maxDuration - _watch.elapsed.inSeconds;
        notifyListeners();
      } else {
        notifyListeners();
        _watch.stop();
        _timer.cancel();
      }
    });
  }
}
