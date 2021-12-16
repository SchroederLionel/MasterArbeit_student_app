import 'dart:async';
import 'package:crayon/datamodels/quiz/quiz_options.dart';
import 'package:crayon/datamodels/quiz/quiz_response.dart';
import 'package:crayon/datamodels/quiz/quiz_result.dart';
import 'package:crayon/route/route.dart' as route;
import 'package:flutter/material.dart';

/// TimeProvider is in charge of the process of the quiz.
/// Takes care of the time elapsed and maximum time available for a quiz.
/// Stores the results of the user if the question was responed right or wrong.
/// Finally calculates also the total score of the user.
class TimeProvider extends ChangeNotifier {
  final QuizOptions quizOptions;

  BuildContext context;

  /// Variable which stores the responses of the user to a quesiton. (if the question was responded right or wrong).
  final List<QuizResponse> _responses = [];
  List<QuizResponse> get responses => _responses;
  final Stopwatch _watch;
  late Timer _timer;

  /// Describes the maximal duration of a quiz.
  final int _maxDuration;

  /// remaining time for the quiz.
  int _remainingDuration;
  int get remainingDuration => _remainingDuration;

  /// How many questions where answered right by the user.
  int _questionsAnsweredRight = 0;

  /// Function which allows to compute what the maximum amount of points a user can gain on correct answering all the questions.
  /// Each correct response awards the user with 20 points.
  int getTotalAmountOfPointForEachQuestion() {
    return quizOptions.quiz.questions.length * 20;
  }

  /// Function which allows to get the remaining time for the quiz (seconds).
  int getRemainingTimeFromQuiz() {
    return _remainingDuration;
  }

  /// Each available second rewards the player with 20 points.
  int getPointsFromRemainingTime() {
    return _remainingDuration * 2;
  }

  /// Function which allows to compute the maximum score of a quiz.
  /// Uses Function getTotalAmountOf points for each question.
  /// In addition,  the due to the screen animations 1second to each screen the maximum score gets decreased for each second to allow an user to achieve the max score.
  int getMaximumScoreForQuiz() {
    return (getTotalAmountOfPointForEachQuestion() +
            (_maxDuration - quizOptions.quiz.questions.length) * 2) *
        quizOptions.quiz.questions.length;
  }

  /// Function which allows to get the user score.
  /// For each question answered right the user gets 20 points.
  /// For each time remaining the user gets an additional 2 points per remaining second of the quiz.
  /// Finally, the value gets multiplied with the amount of questions answered right.
  /// Which results in if the user has no questions answered right he gets 0 points and if only two are right the multiplier is 2.
  int getUserScrore() {
    int score = (_questionsAnsweredRight * 20 + _remainingDuration * 2) *
        _questionsAnsweredRight;
    int maxScore = getMaximumScoreForQuiz();
    if (score > maxScore) {
      return maxScore;
    }
    return score;
  }

  /// Function which increments each time a question is answered right.
  void increment() {
    _questionsAnsweredRight++;
  }

  /// Function which allows to store the user response to the question.
  void addResponse(String question, bool wasTrue) {
    _responses.add(QuizResponse(question: question, wasResponseRight: wasTrue));
  }

  /// Function which allows to stop the timer.
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

  /// Function which allows to start the timer. The timer gets every second notified since the remaining time changes every second.
  /// If time is elapsed and the quiz is not finished the user will automatically be moved to the scroing screen with his current score.
  void start() {
    _watch.start();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_watch.elapsed.inSeconds <= _maxDuration) {
        _remainingDuration = _maxDuration - _watch.elapsed.inSeconds;

        notifyListeners();
      } else {
        // If the time is elapsed.
        _watch.stop();
        _timer.cancel();
        notifyListeners();

        /// Push result to the score screen.
        Navigator.of(context).pushNamed(route.score,
            arguments: QuizResult(
                responses: _responses,
                totalAvailableScore: getMaximumScoreForQuiz(),
                score: getUserScrore(),
                lectureId: quizOptions.lectureId,
                userName: quizOptions.userName));
      }
    });
  }
}
