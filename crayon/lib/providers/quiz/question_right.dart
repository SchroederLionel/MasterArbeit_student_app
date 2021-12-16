import 'package:crayon/datamodels/quiz/questions.dart';
import 'package:crayon/datamodels/quiz/response.dart';
import 'package:crayon/state/enum.dart';
import 'package:flutter/material.dart';

/// Allows to check if a question was clicked rightFully.
class QuestionRight extends ChangeNotifier {
  NotifierState _state = NotifierState.initial;
  Response? _responsePressed;
  setNotifierState(NotifierState state, Response response) {
    _state = state;
    _responsePressed = response;
    notifyListeners();
  }

  Question question;

  QuestionRight({required this.question});

  /// Right color is green
  final Color _right = Colors.greenAccent;

  /// Wrong color is red.
  final Color _wrong = Colors.redAccent;

  /// Initial color is black.
  final Color _default = Colors.black;

  void showAnswers(Response response) {}

  /// Function which returns the color of the question respones options.
  /// returns (black) default at the initial state
  /// if the user presses an option the color changes and allows him to see if the answer clicked was responded correctly.
  /// Red if _wrong and green if _right.
  /// The correct answer will always be schown in green after each option click.
  Color getColor(Response response) {
    if (_state == NotifierState.initial) {
      return _default;
    } else {
      if (response != _responsePressed) {
        if (response.isResponseRight) {
          return _right;
        } else {
          return _default;
        }
      } else {
        if (response.isResponseRight) {
          return _right;
        } else {
          return _wrong;
        }
      }
    }
  }
}
