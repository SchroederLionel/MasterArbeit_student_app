import 'dart:convert';

/// User class contains the user id , email and enrolled lectures.
/// Funnction/Constructor which allow to transform the data into json or from json into object of type user.
class User {
  String uid;
  String email;
  List<String> enrolledLectures;

  User(this.enrolledLectures, {required this.uid, required this.email});

  factory User.fromJson(Map<String, dynamic>? json) {
    final uid = json!['uid'] as String;
    final email = json['email'] as String;
    var enrolledData = json['enrolled-lectures'];
    List<String> enrolledLectures = [];
    if (enrolledData != null) {
      enrolledLectures = List.from(enrolledData);
    } else {
      enrolledLectures = [];
    }

    return User(enrolledLectures, uid: uid, email: email);
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'enrolled-lectures': jsonEncode(enrolledLectures)
      };
}
