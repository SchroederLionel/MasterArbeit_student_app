import 'package:crayon/datamodels/failure.dart';
import 'package:crayon/datamodels/user/user_credentials.dart';
import 'package:crayon/service/auth_service.dart';
import 'package:crayon/state/enum.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crayon/route/route.dart' as route;

class LoginProvider extends ChangeNotifier {
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

  late Either<Failure, UserCredential> _userCredential;
  Either<Failure, UserCredential> get userCredential => _userCredential;

  setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  Future<Either<Failure, bool>> resetPassword(String email) async {
    return await Task(() => AuthService().resetPassword(email))
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
  }

  Future<Either<Failure, UserCredential>> createAccount(
      UserBasics user, String verificationPassword) async {
    return await Task(() =>
            AuthService().registerWithEmailPassword(user, verificationPassword))
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
  }

  void signUserIn(UserBasics user) async {
    setState(NotifierState.loading);
    AuthService service = AuthService();
    _userCredential = await Task(
            () => service.signInWithEmailPassword(user.email, user.password))
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
    setState(NotifierState.loaded);
  }

  Future<void> signOut(BuildContext context) async {
    _state = NotifierState.initial;
    await Navigator.of(context)
        .pushNamedAndRemoveUntil(route.login, (Route<dynamic> route) => false);
    AuthService().signOut();
  }
}
