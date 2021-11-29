import 'package:flutter/material.dart';

class ErrorProvider extends ChangeNotifier {
  String _errorText = '';

  String get errorText => _errorText;

  void setError(String text) {
    _errorText = text;
    notifyListeners();
  }
}
