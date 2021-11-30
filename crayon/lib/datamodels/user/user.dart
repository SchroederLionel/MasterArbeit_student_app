import 'dart:convert';

class User {
  String uid;
  String email;
  List<String> myLectures = [];
  User({required this.uid, required this.email, this.myLectures = const []});

  factory User.fromJson(Map<String, dynamic>? json) {
    final uid = json!['uid'] as String;
    final email = json['email'] as String;

    final myLecturesData = json['enrolled-lectures'] as List<dynamic>?;

    final myLectures = myLecturesData != null
        ? myLecturesData.map((lectureId) => lectureId as String).toList()
        : <String>[];

    return User(uid: uid, email: email, myLectures: myLectures);
  }

  Map<String, dynamic> toJson() =>
      {'uid': uid, 'email': email, 'enrolled-lectures': jsonEncode(myLectures)};
}
