import 'package:flutter/material.dart';

/// Error provider is used to display errors.
class ErrorProvider extends ChangeNotifier {
  String _errorText = '';

  String get errorText => _errorText;

  void setError(String text) {
    _errorText = text;
    notifyListeners();
  }
}
