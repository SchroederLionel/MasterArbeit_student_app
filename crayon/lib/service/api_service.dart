import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crayon/datamodels/failure.dart';
import 'package:crayon/datamodels/lecture/lecture.dart';
import 'package:crayon/datamodels/lecture/lecture_schedule.dart';
import 'package:crayon/datamodels/quiz/quiz_result.dart';
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
  /// Throws a Failure in case of an managed error.
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
  /// Throws a Failure in case of an managed error.
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
  /// Two parameters are required the Lecture id.
  /// returns the lectureId if the lecture was successfully added.
  /// Throws a Failure in case of an managed error.
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
  Stream<List<LectureSchedule>> getMyLectures(List<String> lecturesToListen) {
    try {
      return FirebaseFirestore.instance
          .collection('lectures')
          .where('id', whereIn: lecturesToListen)
          .snapshots(includeMetadataChanges: false)
          .map((snapshot) {
        List<LectureSchedule> schedules = [];
        for (var document in snapshot.docs) {
          schedules.addAll(Lecture.fromJson(document.data()).transform());
        }
        return schedules;
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

  /// Function which allows to ask a question to the teacher.
  /// Takes two parameter the question from the user and the corresponding lectureId.
  /// Throws a failure in case of an managed error.
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

  /// Function which allows the user to join the lobby as a post request.
  /// required parameters are the lectureId and the username.
  Future<void> joinLobby(String lectureId, String userName) {
    try {
      return FirebaseFirestore.instance
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

  /// Function which allows the user to leave the lobby.
  /// required parameters are the lecture id and the username for removal.
  /// throws a failure in case of an errir.
  Future<void> leaveLobby(String lectureId, String userName) {
    try {
      return FirebaseFirestore.instance
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

  /// Function which is used to post the users quizrespones.
  /// Required parameter is the quizresult which contains the lecture id and the responses.
  /// Throws a failure in case of an error.
  Future<void> postResponse(QuizResult result) {
    try {
      return FirebaseFirestore.instance
          .collection('lectures')
          .doc(result.lectureId)
          .collection('features')
          .doc('responses')
          .set({
        'responses': FieldValue.arrayUnion([result.toJson()]),
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
}
