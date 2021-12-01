import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crayon/datamodels/failure.dart';
import 'package:crayon/datamodels/lecture/lecture.dart';
import 'package:crayon/datamodels/user/user.dart' as myuser;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:validators/validators.dart';

class ApiService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  Future<String> addLecture(String lectureId) async {
    try {
      var howMany = '-'.allMatches(lectureId).length;
      String removeDash = lectureId.replaceAll('-', '');

      if (howMany > 2 && howMany < 6 && isAlphanumeric(removeDash)) {
        if (_auth.currentUser != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(_auth.currentUser!.uid)
              .collection('features')
              .doc('enrolled-lectures')
              .set({
            'enrolled-lectures': FieldValue.arrayUnion([lectureId])
          }, SetOptions(merge: true));
          return lectureId;
        }
      } else {
        throw Failure(code: 'wrong-qr-code');
      }

      throw Failure(code: 'not-logged-in');
    } on FirebaseException catch (e) {
      print(e);
      throw Failure(code: 'firebase-exception');
    } on SocketException {
      throw Failure(code: 'no-internet');
    } on HttpException {
      throw Failure(code: 'not-found');
    } on FormatException {
      throw Failure(code: 'bad-format');
    }
  }

  Stream<List<String>> getEnrolledLectures() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('features')
        .doc('enrolled-lectures')
        .snapshots()
        .map((snap) {
      var json = snap.data();
      if (json != null) {
        if (json.containsKey('enrolled-lectures')) {
          return List.from(json['enrolled-lectures']);
        }
      }
      return [];
    });
  }

  Stream<List<Lecture>> getMyLectures(List<String> lecturesToListen) {
    return FirebaseFirestore.instance
        .collection('lectures')
        .where('id', whereIn: lecturesToListen)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((document) {
              print(document.data());
              return Lecture.fromJson(document.data());
            }).toList());
  }
}
