import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crayon/datamodels/failure.dart';
import 'package:crayon/datamodels/user/user.dart' as myuser;
import 'package:crayon/datamodels/user/user_credentials.dart';
import 'package:crayon/service/validator_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> registerWithEmailPassword(
      UserBasics user, String verificationPassword) async {
    String? isValid = ValidatorService.isValid(
        user.email, user.password, verificationPassword);

    try {
      if (isValid != null) {
        throw Failure(code: isValid);
      }
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      myuser.User newUser = myuser.User(
        email: user.email,
        uid: userCredential.user!.uid,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(newUser.toJson());

      return await signInWithEmailPassword(user.email, user.password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Failure(code: 'weak-password');
      } else if (e.code == 'email-already-in-use') {
        throw Failure(code: 'email-already-exists');
      }
      throw Failure(code: 'firebase-exception');
    } on SocketException {
      throw Failure(code: 'no-internet');
    } on HttpException {
      throw Failure(code: 'not-found');
    } on FormatException {
      throw Failure(code: 'bad-format');
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      if (!isEmail(email)) {
        throw Failure(code: 'invalidEmail');
      }
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      throw Failure(code: e.code);
    }
  }

  Future<User?> get user async => _auth.currentUser;

  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Failure(code: 'no-user-found');
      } else if (e.code == 'wrong-password') {
        throw Failure(code: 'wrong-password');
      }
      throw Failure(code: 'firebase-exception');
    } on SocketException {
      throw Failure(code: 'no-internet');
    } on HttpException {
      throw Failure(code: 'not-found');
    } on FormatException {
      throw Failure(code: 'bad-format');
    }
  }

  Future<String> signOut() async {
    await _auth.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', false);

    return 'User signed out';
  }
}
