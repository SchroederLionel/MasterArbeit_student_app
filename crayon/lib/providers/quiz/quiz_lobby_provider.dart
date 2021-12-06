import 'package:crayon/service/api_service.dart';
import 'package:crayon/state/enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizLobbyProvider extends ChangeNotifier {
  final BuildContext context;
  LoadingState _state = LoadingState.no;
  LoadingState get state => _state;
  QuizLobbyProvider({required this.context});
  late String _userName;
  String get userName => _userName;
  late String _lectureId;
  String get lectureId => _lectureId;
  late String _lectureName;
  String get lectureName => _lectureName;
  bool _isWaiting = false;
  bool get isWaiting => _isWaiting;

  set(String lectureId, bool isWaiting, String userName, String lectureName) {
    /// Todo
    ApiService api = ApiService();
    api.joinLobby(lectureId, userName);
    _lectureName = lectureName;
    _isWaiting = isWaiting;
    _lectureId = lectureId;
    _userName = userName;
    showSnackBar('You entered the waiting room', false);
    setState(LoadingState.yes);
  }

  void setState(LoadingState state) {
    _state = state;
    notifyListeners();
  }

  void reset() {
    ApiService api = ApiService();
    api.leaveLobby(lectureId, userName);
    _isWaiting = false;
    _userName = '';
    _lectureId = '';
    _lectureName = '';
    setState(LoadingState.no);
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
