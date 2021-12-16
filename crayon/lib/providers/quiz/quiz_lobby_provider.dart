import 'dart:convert';
import 'package:crayon/datamodels/custom_snackbar.dart';
import 'package:crayon/datamodels/failure.dart';
import 'package:crayon/datamodels/lecture/lecture_schedule.dart';
import 'package:crayon/datamodels/quiz/quiz_options.dart';
import 'package:crayon/service/api_service.dart';
import 'package:crayon/state/enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The quiz lobby provider is in charge of showing if a user is in a quiz lobby or not.
class QuizLobbyProvider extends ChangeNotifier {
  final BuildContext context;
  late NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;
  QuizLobbyProvider({required this.context});
  String _userName = '';
  String get userName => _userName;
  String _lectureId = '';
  String get lectureId => _lectureId;
  String _lectureName = '';
  String get lectureName => _lectureName;

  /// Function which sets up the quiz lobby, by making a post request with the username.
  /// username the lecture id and name.
  /// Stores in shared preferences if the user leaves app and goes back to it.
  ///
  void set(String lectureId, String userName, String lectureName) async {
    ApiService api = ApiService();

    var result = await Task(() => api.joinLobby(lectureId, userName))
        .attempt()
        .map(
          (either) => either.leftMap((obj) {
            try {
              return obj as Failure;
            } catch (e) {
              throw obj;
            }
          }),
        )
        .run();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> lobby = {
      'username': userName,
      'lectureId': lectureId,
      'lectureName': lectureName
    };
    prefs.setString('currentlyInLobby', jsonEncode(lobby));
    _lectureName = lectureName;
    _lectureId = lectureId;
    _userName = userName;
    CustomSnackbar(
            text: 'entered-waiting-room',
            saftyString: 'You entered the waiting room',
            isError: false,
            context: context)
        .showSnackBar();

    setState(NotifierState.loading);
  }

  /// Function which initializes the quiz lobby.
  /// The user joins the lobby and sets the notifier state to loading.
  /// Stores the lobby session in shared preferences .
  void initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lobby = prefs.getString('currentlyInLobby');
    if (lobby != null) {
      Map<String, dynamic> lobbyMap = jsonDecode(lobby) as Map<String, dynamic>;
      _userName = lobbyMap['username'] ?? '';
      _lectureId = lobbyMap['lectureId'] ?? '';
      _lectureName = lobbyMap['lectureName'] ?? '';
      setState(NotifierState.loading);
    }
  }

  /// Function which allows to change the state of the quizLobby.
  /// param NotifierState initial or loading.
  /// (loaded state not used since at the loaded level the user will be on the quiz screen.)
  void setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  /// Function which allows to reset the game lobby.
  /// Removes the values in shared preferences that the user is in a lobby.
  /// And sets the state to initial (User isn't waiting for the start of a quiz).
  void reset() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('currentlyInLobby');
    if (_lectureId != '' && _lectureName != '') {
      ApiService api = ApiService();
      api.leaveLobby(_lectureId, _lectureName);
    }
    _userName = '';
    _lectureId = '';
    _lectureName = '';
    setState(NotifierState.initial);
  }

  void canJoin(List<LectureSchedule> schedules) {
    for (int i = 0; i < schedules.length; i++) {
      if (schedules[i].lectureId == _lectureId) {
        var userName = _userName;
        var lectureId = _lectureId;
        reset();
        Navigator.pushNamed(context, '/quiz',
            arguments: QuizOptions(
                userName: userName,
                lectureId: lectureId,
                quiz: schedules[i].quiz!));
      }
    }
  }
}
