import 'dart:async';

import 'package:crayon/datamodels/custom_snackbar.dart';
import 'package:crayon/datamodels/failure.dart';
import 'package:crayon/datamodels/lecture/lecture.dart';
import 'package:crayon/datamodels/user/user.dart';

import 'package:crayon/service/api_service.dart';
import 'package:crayon/state/enum.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';

/// Class which allows to get the user data espacially his lectures.
class UserProvider extends ChangeNotifier {
  ApiService api = ApiService();

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
  User? _user;

  /// Get if  user data or failure.
  User? get user => _user;

  /// Sets the state in which the data fetching is in.
  /// Notifies the Consumers to make the visual changes.
  setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  /// Function which allows to retrieve the user data from the database.
  Future<void> getUser() async {
    setState(NotifierState.loading);

    dartz.Either<Failure, User> _result =
        await dartz.Task(() => api.getUserData())
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

    _result.fold(
        (failure) => CustomSnackbar(
              text: failure.code,
              isError: true,
              context: context,
              saftyString: 'Failed to retrieve user data',
            ).showSnackBar(), (user) {
      _user = user;
    });

    setState(NotifierState.loaded);
  }

  /// Funciton which allows to add a lecture to the user data.
  void addLecture(String lectureId) async {
    /// Change visual my showing loading indicator.

    if (user!.enrolledLectures.contains(lectureId)) {
      CustomSnackbar(
        text: 'lecture-already-enrolled',
        isError: true,
        context: context,
        saftyString: 'You are already enrolled in this lecture.',
      ).showSnackBar();
    } else {
      setState(NotifierState.loading);

      /// Create a task which allows to add a lecture to the user.
      /// (Map) required since the left Type is object thus changing it to failure in case of a failure.
      /// If successfull type String returned which will then be added to the user.
      var result = await dartz.Task(() => api.addLecture(lectureId))
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

      result.fold(
          (failure) => CustomSnackbar(
                text: failure.code,
                isError: true,
                context: context,
                saftyString: 'Failed to add lecture',
              ).showSnackBar(), (lectureId) {
        CustomSnackbar(
          text: 'lecture-added-sucess',
          isError: false,
          context: context,
          saftyString: 'Lecture added successfully',
        ).showSnackBar();
        _user!.enrolledLectures.add(lectureId);
      });

      /// Change state to loaded to make the failure or the updated user list available to the view.
      setState(NotifierState.loaded);
    }
  }

  /// Funciton which allows to add a lecture to the user data.
  void removeLecture(String lectureId) async {
    /// Change visual my showing loading indicator.
    setState(NotifierState.loading);

    var result = await dartz.Task(() => api.removeLecture(lectureId))
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

    result.fold(
        (failure) => CustomSnackbar(
              text: failure.code,
              isError: true,
              context: context,
              saftyString: 'Failed to remove lecture',
            ).showSnackBar(), (lectureId) {
      CustomSnackbar(
        text: 'lecture-removed-sucess',
        isError: false,
        context: context,
        saftyString: 'Successfully removed lecture',
      ).showSnackBar();
      _user!.enrolledLectures.remove(lectureId);
    });

    /// Change state to loaded to make the failure or the updated user list available to the view.
    setState(NotifierState.loaded);
  }

  void postQuestion(String question, String lectureId) async {
    var result = await dartz.Task(() => api.postQuestion(question, lectureId))
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
    result.fold(
        (failure) => ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
              text: failure.code,
              isError: true,
              context: context,
              saftyString: 'Failed to ask question',
            )),
        (sucess) => CustomSnackbar(
              text: 'quesiton-asked-sucess',
              isError: false,
              context: context,
              saftyString: 'Successfully asked question',
            ).showSnackBar());
  }

  void joinLobby(String lectureId, String userName) async {
    var result = await dartz.Task(() => api.joinLobby(lectureId, userName))
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

    result.fold(
        (failure) => CustomSnackbar(
              text: failure.code,
              isError: true,
              context: context,
              saftyString: 'Failed to join lobby',
            ).showSnackBar(),
        (sucess) => CustomSnackbar(
              text: 'join-lobby-success',
              isError: false,
              context: context,
              saftyString: 'Successfully joined lobby',
            ).showSnackBar());
  }
}
