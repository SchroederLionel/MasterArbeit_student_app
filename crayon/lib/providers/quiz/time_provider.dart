import 'dart:async';
import 'package:flutter/material.dart';

class TimeProvider extends ChangeNotifier {
  final Stopwatch _watch;
  late Timer _timer;
  int maxDuration = 100;
  int remainingDuration = 100;

  TimeProvider() : _watch = Stopwatch();

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
