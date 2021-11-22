import 'package:crayon/datamodels/question.dart';
import 'package:crayon/state/enum.dart';
import 'package:flutter/material.dart';

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
  final Color _right = Colors.greenAccent;
  final Color _wrong = Colors.redAccent;
  final Color _default = Colors.black;

  void showAnswers(Response response) {}

  Color getColor(Response response) {
    if (_state == NotifierState.initial) {
      return _default;
    } else {
      if (response != _responsePressed) {
        if (response.isResponseRight)
          return _right;
        else
          return _default;
      } else {
        if (response.isResponseRight)
          return _right;
        else
          return _wrong;
      }
    }
  }
}
