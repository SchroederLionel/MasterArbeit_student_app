import 'package:crayon/datamodels/failure.dart';
import 'package:crayon/datamodels/user/user_credentials.dart';
import 'package:crayon/service/auth_service.dart';
import 'package:crayon/state/enum.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crayon/route/route.dart' as route;

/// The login provider class is in charge of authentification.
/// Contains the functions such as reset password & account creation and login.
class LoginProvider extends ChangeNotifier {
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

  /// Value can either be a failure(exception) or the usercredential from firebase.
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

  /// Function which allows to create an user account. (For firebase auth).
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

  /// Function which allows the user to sign in.
  /// Requires param userbasics containing the useremail and password.
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

  /// Function which allows the user to sign out and push the user back to the login rout.
  Future<void> signOut(BuildContext context) async {
    _state = NotifierState.initial;
    await AuthService().signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil(route.login, (Route<dynamic> route) => false);
  }
}
