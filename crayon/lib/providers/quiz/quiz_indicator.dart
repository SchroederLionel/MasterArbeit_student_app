import 'package:flutter/material.dart';

class QuizIndicator extends ChangeNotifier {
  late int _numberOfQuestions = 4;
  int _currentNumber = 0;
  bool _isQuizFinished = false;
  bool get isQuizFinished => _isQuizFinished;
  PageController? _controller;

  String getIndicator() => '${_currentNumber + 1} / $_numberOfQuestions';

  setController(PageController controller) {
    _controller = controller;
  }

  set numberOfQuestions(int numberOfQuestions) =>
      _numberOfQuestions = numberOfQuestions;

  increament() {
    if (_currentNumber < _numberOfQuestions - 1) {
      _currentNumber++;
      _controller!.animateToPage(_currentNumber,
          duration: const Duration(milliseconds: 750),
          curve: Curves.easeInCirc);
      notifyListeners();
    } else {
      _isQuizFinished = true;
    }
  }

  decrement() {
    if (_currentNumber > 0) {
      _currentNumber--;
      _controller!.jumpToPage(_currentNumber);
      notifyListeners();
    }
  }
}
