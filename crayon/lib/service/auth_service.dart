import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crayon/datamodels/failure.dart';
import 'package:crayon/datamodels/user/user.dart' as myuser;
import 'package:crayon/datamodels/user/user_credentials.dart';
import 'package:crayon/service/validator_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:validators/validators.dart';

/// The Authservice class allows to the user to login or respectively log out the user.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;

  /// Function which allows to register a user with an email and password.
  /// The Function checks also the validity of passwords and email entered by the user.
  Future<UserCredential> registerWithEmailPassword(
      UserBasics user, String verificationPassword) async {
    String? isValid = ValidatorService.isValid(
        user.email, user.password, verificationPassword);

    try {
      if (isValid != null) {
        throw Failure(code: isValid);
      }

      /// First register the user in Firestore Auth.
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      myuser.User newUser = myuser.User(
        [],
        email: user.email,
        uid: userCredential.user!.uid,
      );

      /// create a user profile
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
      } else if (e.code == 'user-disabled') {
        throw Failure(code: 'user-disabled');
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

  /// Function allows to reset the password of a user by email.
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

  /// Function which allows to sign the user in.
  /// Returns Future UserCredentials from firestore library.
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

  void signOut() async {
    await _auth.signOut();
  }
}
