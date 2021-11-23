import 'dart:async';
import 'package:crayon/datamodels/timerscore.dart';
import 'package:flutter/material.dart';

class TimeProvider extends ChangeNotifier {
  final Stopwatch _watch;
  late Timer _timer;
  int maxDuration = 100;
  int remainingDuration = 100;
  int _previousTime = 0;
  TimeProvider() : _watch = Stopwatch();

  List<TimerScore> _timePerQuestionTaken = [];

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

  void addTimeTakenForQuestion(bool wasRight) {
    int current = _watch.elapsed.inSeconds;
    if (_previousTime == 0) {
      _timePerQuestionTaken
          .add(TimerScore(wasRight: wasRight, timeTaken: current));
      _previousTime = current;
    } else {
      var saver = current - _previousTime;
      _timePerQuestionTaken
          .add(TimerScore(wasRight: wasRight, timeTaken: saver));
      _previousTime = current;
    }
  }

  int getMaxTimeTakenForQuestion() {
    return _timePerQuestionTaken.fold(_timePerQuestionTaken.first.timeTaken,
        (max, cur) => cur.timeTaken >= max ? cur.timeTaken : max);
  }

  int getMinTimeTakenForQuestion() {
    return _timePerQuestionTaken.fold(_timePerQuestionTaken.first.timeTaken,
        (min, cur) => cur.timeTaken <= min ? cur.timeTaken : min);
  }

  int getCompleteTimeTakenForQuiz() {
    return _timePerQuestionTaken.fold(
        0, (previousValue, current) => current.timeTaken + previousValue);
  }

  double getAverageTimeTakenForQuiz() {
    var sum = 0;
    for (int i = 0; i < _timePerQuestionTaken.length; i++) {
      sum += _timePerQuestionTaken[i].timeTaken;
    }
    return sum / _timePerQuestionTaken.length;
  }
}
