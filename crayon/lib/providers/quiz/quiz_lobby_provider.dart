import 'package:crayon/state/enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizLobbyProvider extends ChangeNotifier {
  final BuildContext context;
  LoadingState _state = LoadingState.no;

  QuizLobbyProvider({required this.context});
  late String _userName;
  String get userName => _userName;
  late String _lectureId;
  late String _lectureName;
  String get lectureName => _lectureName;
  bool _isWaiting = false;
  bool get isWaiting => _isWaiting;
  set(String lectureId, bool isWaiting, String userName, String lectureName) {
    _lectureName = lectureName;
    _isWaiting = isWaiting;
    lectureId = lectureId;
    _userName = userName;
    showSnackBar('You entered the waiting room', false);
    notifyListeners();
  }

  showSnackBar(String text, bool isError) {
    final snackBar = SnackBar(
        backgroundColor: isError ? Colors.redAccent : Colors.greenAccent,
        content: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
