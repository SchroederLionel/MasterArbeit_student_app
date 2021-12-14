import 'dart:async';
import 'package:crayon/datamodels/quiz/quiz_options.dart';
import 'package:crayon/datamodels/quiz/quiz_response.dart';
import 'package:crayon/datamodels/quiz/quiz_result.dart';
import 'package:crayon/route/route.dart' as route;
import 'package:flutter/material.dart';

///
class TimeProvider extends ChangeNotifier {
  final QuizOptions quizOptions;

  BuildContext context;
  final List<QuizResponse> _responses = [];

  final Stopwatch _watch;
  late Timer _timer;
  final int _maxDuration;
  int _remainingDuration;
  int get remainingDuration => _remainingDuration;

  int _questionsAnsweredRight = 0;

  /// getTotalAmountOfPointsAvailableFor answering the right questions.
  /// Each correct response awards the user with 20 points.
  int getTotalAmountOfPointForEachQuestion() {
    return quizOptions.quiz.questions.length * 20;
  }

  int getRemainingTimeFromQuiz() {
    return _remainingDuration;
  }

  /// Each available second rewards the player with 20 points.
  int getPointsFromRemainingTime() {
    return _remainingDuration * 2;
  }

  int getMaximumScoreForQuiz() {
    return (getTotalAmountOfPointForEachQuestion() +
            (_maxDuration - quizOptions.quiz.questions.length) * 2) *
        quizOptions.quiz.questions.length;
  }

  int getUserScrore() {
    int score = (_questionsAnsweredRight * 20 + _remainingDuration * 2) *
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

  void addResponse(String question, bool wasTrue) {
    _responses.add(QuizResponse(question: question, wasResponseRight: wasTrue));
  }

  void stop() {
    _watch.stop();
    _timer.cancel();
  }

  TimeProvider({
    required this.context,
    required this.quizOptions,
  })  : _watch = Stopwatch(),
        _maxDuration = quizOptions.quiz.seconds ?? 100,
        _remainingDuration = quizOptions.quiz.seconds ?? 100;

  void start() {
    _watch.start();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_watch.elapsed.inSeconds <= _maxDuration) {
        _remainingDuration = _maxDuration - _watch.elapsed.inSeconds;
        notifyListeners();
      } else {
        _watch.stop();
        _timer.cancel();
        notifyListeners();

        Navigator.of(context).pushNamed(route.score,
            arguments: QuizResult(
                totalAvailableScore: getMaximumScoreForQuiz(),
                score: getUserScrore(),
                lectureId: quizOptions.lectureId,
                userName: quizOptions.userName));
      }
    });
  }
}
