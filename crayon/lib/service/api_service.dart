import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crayon/datamodels/failure.dart';
import 'package:crayon/datamodels/lecture/lecture.dart';
import 'package:crayon/datamodels/user/user.dart' as myuser;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:validators/validators.dart';

/// The ApiSerivce class main role is to make the different requests to Firestore.
/// These function can only be executed if the user is logged in.
class ApiService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Function which allows to retrieve the user data from firestore.
  /// @returns custom User.
  Future<myuser.User> getUserData() async {
    try {
      if (_auth.currentUser != null) {
        var userDocument = await FirebaseFirestore.instance
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .get();
        if (!userDocument.exists) {
          throw Failure(code: 'user-not-exists');
        }
        return myuser.User.fromJson(userDocument.data());
      }
      throw Failure(code: 'not-logged-in');
    } on FirebaseException catch (_) {
      throw Failure(code: 'firebase-exception');
    } on SocketException {
      throw Failure(code: 'no-internet');
    } on HttpException {
      throw Failure(code: 'not-found');
    } on FormatException {
      throw Failure(code: 'bad-format');
    }
  }

  /// Function which allows to remove a lecture where the user is enrolled in.
  /// returns a boolean if the deletion was successfull.
  Future<String> removeLecture(String lectureId) async {
    try {
      if (_auth.currentUser != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .update({
          'enrolled-lectures': FieldValue.arrayRemove([lectureId])
        });

        return lectureId;
      }
      throw Failure(code: 'not-logged-in');
    } on FirebaseException catch (_) {
      throw Failure(code: 'firebase-exception');
    } on SocketException {
      throw Failure(code: 'no-internet');
    } on HttpException {
      throw Failure(code: 'not-found');
    } on FormatException {
      throw Failure(code: 'bad-format');
    }
  }

  /// Function which allows to add a lecture to the users enrolled lecture list.
  /// Two parameters are required the Lecture id which and the user himself. After the post request if there is no error the user with the added element will be returned.
  /// returns the lectureId if the lecture was successfully added.
  Future<String> addLecture(String lectureId) async {
    try {
      var howMany = '-'.allMatches(lectureId).length;
      String removeDash = lectureId.replaceAll('-', '');

      if (howMany > 2 && howMany < 6 && isAlphanumeric(removeDash)) {
        if (_auth.currentUser != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(_auth.currentUser!.uid)
              .set({
            'enrolled-lectures': FieldValue.arrayUnion([lectureId])
          }, SetOptions(merge: true));

          return lectureId;
        }
      } else {
        throw Failure(code: 'wrong-qr-code');
      }

      throw Failure(code: 'not-logged-in');
    } on FirebaseException catch (_) {
      throw Failure(code: 'firebase-exception');
    } on SocketException {
      throw Failure(code: 'no-internet');
    } on HttpException {
      throw Failure(code: 'not-found');
    } on FormatException {
      throw Failure(code: 'bad-format');
    }
  }

  /// Function which allows to get the actual lectures based on the lecture ids where the user is enrolled in.
  /// returns a list of lectures (Stream). Which allows to detect if the room or something else changes.
  Stream<List<Lecture>> getMyLectures(List<String> lecturesToListen) {
    print('CALLED');
    try {
      return FirebaseFirestore.instance
          .collection('lectures')
          .where('id', whereIn: lecturesToListen)
          .snapshots(includeMetadataChanges: false)
          .map((snapshot) => snapshot.docs.map((document) {
                print(snapshot.metadata.isFromCache
                    ? "-----Cached-----"
                    : "----Not Cached----");
                print(
                    (document.metadata.isFromCache ? "Cached" : "Not Cached"));
                return Lecture.fromJson(document.data());
              }).toList());
    } on FirebaseException catch (_) {
      throw Failure(code: 'firebase-exception');
    } on SocketException {
      throw Failure(code: 'no-internet');
    } on HttpException {
      throw Failure(code: 'not-found');
    } on FormatException {
      throw Failure(code: 'bad-format');
    }
  }

  /// Function which allows to ask a question to the teacher.
  /// Takes two parameter the question from the user and the corresponding lectureId.
  Future<void> postQuestion(String question, String lectureId) async {
    try {
      await FirebaseFirestore.instance
          .collection('lectures')
          .doc(lectureId)
          .collection('features')
          .doc('questions')
          .set({
        'questions': FieldValue.arrayUnion([question])
      });
    } on FirebaseException catch (_) {
      throw Failure(code: 'firebase-exception');
    } on SocketException {
      throw Failure(code: 'no-internet');
    } on HttpException {
      throw Failure(code: 'not-found');
    } on FormatException {
      throw Failure(code: 'bad-format');
    }
  }

  Future<void> joinLobby(String lectureId, String userName) async {
    try {
      await FirebaseFirestore.instance
          .collection('lectures')
          .doc(lectureId)
          .collection('features')
          .doc('lobby')
          .set({
        'participants': FieldValue.arrayUnion([userName]),
      }, SetOptions(merge: true));
    } on FirebaseException catch (_) {
      throw Failure(code: 'firebase-exception');
    } on SocketException {
      throw Failure(code: 'no-internet');
    } on HttpException {
      throw Failure(code: 'not-found');
    } on FormatException {
      throw Failure(code: 'bad-format');
    }
  }

  void leaveLobby(String lectureId, String userName) {
    try {
      FirebaseFirestore.instance
          .collection('lectures')
          .doc(lectureId)
          .collection('features')
          .doc('lobby')
          .set({
        'participants': FieldValue.arrayRemove([userName]),
      }, SetOptions(merge: true));
    } on FirebaseException catch (_) {
      throw Failure(code: 'firebase-exception');
    } on SocketException {
      throw Failure(code: 'no-internet');
    } on HttpException {
      throw Failure(code: 'not-found');
    } on FormatException {
      throw Failure(code: 'bad-format');
    }
  }

  Future<bool> lobbySendScore(
      String userName, String lectureId, int score) async {
    try {
      await FirebaseFirestore.instance
          .collection('lectures')
          .doc(lectureId)
          .collection('features')
          .doc('responses')
          .set({
        'responses': FieldValue.arrayUnion([
          {'userName': userName, 'score': score}
        ]),
      }, SetOptions(merge: true));

      return true;
    } on FirebaseException catch (_) {
      throw Failure(code: 'firebase-exception');
    } on SocketException {
      throw Failure(code: 'no-internet');
    } on HttpException {
      throw Failure(code: 'not-found');
    } on FormatException {
      throw Failure(code: 'bad-format');
    }
  }
}
