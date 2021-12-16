import 'package:flutter/material.dart';

/// QuizIndicator shows how many questions and at which question the user currently is.
/// Requires how many question the quiz contains.
class QuizIndicator extends ChangeNotifier {
  QuizIndicator({required this.numberOfQuestions});
  final int numberOfQuestions;

  /// At which state the current user is. (Start is 0)
  int _currentNumber = 0;
  bool _isQuizFinished = false;
  bool get isQuizFinished => _isQuizFinished;

  /// Pagecontoller if the user presses an answer the controller will go to the next page;
  PageController? _controller;

  /// Get the current question state. (User on question 1 or other.) / (Total number of questions)
  String getIndicator() => '${_currentNumber + 1} / $numberOfQuestions';

  setController(PageController controller) {
    _controller = controller;
  }

  /// Funciton which allows to go to the next quiz page. (Question page)
  increament() {
    if (_currentNumber < numberOfQuestions - 1) {
      _currentNumber++;
      _controller!.animateToPage(_currentNumber,
          duration: const Duration(milliseconds: 750),
          curve: Curves.easeInCirc);
      notifyListeners();
    } else {
      _isQuizFinished = true;
    }
  }

  /// Function which allows to go back one page.
  decrement() {
    if (_currentNumber > 0) {
      _currentNumber--;
      _controller!.jumpToPage(_currentNumber);
      notifyListeners();
    }
  }
}
