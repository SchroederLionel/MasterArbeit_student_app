import 'package:crayon/datamodels/custom_snackbar.dart';
import 'package:crayon/datamodels/failure.dart';
import 'package:crayon/datamodels/user/user.dart';
import 'package:crayon/service/api_service.dart';
import 'package:crayon/state/enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

/// Class which allows to get the user data espacially his lectures.
class UserProvider extends ChangeNotifier {
  BuildContext context;
  UserProvider({required this.context});

  /// Notifierstate means the User can be in three different stages.
  /// Initial state is at the start before the user data is actually available.
  /// Loading state means the user data is will be fetched from the database.
  /// Loaded means the data from the user has been fetched. (Error/Data).
  NotifierState _state = NotifierState.initial;

  /// Get the current state of the user fetching process.
  NotifierState get state => _state;

  /// Variable which can be either a user or a failure.
  /// In case the data retrieval went wrong the variable will be a failure.
  /// In case of a success the user data will be available to the app.
  late Either<Failure, User> _user;

  /// Get if  user data or failure.
  Either<Failure, User> get user => _user;

  /// Sets the state in which the data fetching is in.
  /// Notifies the Consumers to make the visual changes.
  setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  /// Function which allows to retrieve the user data from the database.
  void getUser() async {
    setState(NotifierState.loading);
    /*ApiService api = ApiService();
    _user = await Task(() => api.getUserData())
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
        .run();*/
    setState(NotifierState.loaded);
  }

  /// Funciton which allows to add a lecture to the user data.
  void addLecture(String lectureId) async {
    /// Change visual my showing loading indicator.

    setState(NotifierState.loading);
    ApiService api = ApiService();

    /// Create a task which allows to add a lecture to the user.
    /// (Map) required since the left Type is object thus changing it to failure in case of a failure.
    /// If successfull type String returned which will then be added to the user.
    Either<Failure, String> add = await Task(() => api.addLecture(lectureId))
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

    /// Fold to check if it has an failure. If yes don't add the lecture to the user lectures list.
    /// No failure add lecture to the user.
    /// User is a either type thus unfolding it to allow adding lecture.
    /// In case the user is a failure don't add the lectureId to the users lecture list else add.
    add.fold(
        (failure) => ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackbar(text: failure.code, isError: true)),
        (lectureId) {
      user.fold((fail) => null, (r) => r.myLectures.add(lectureId));
    });

    /// Change state to loaded to make the failure or the updated user list available to the view.
    setState(NotifierState.loaded);
  }
}
