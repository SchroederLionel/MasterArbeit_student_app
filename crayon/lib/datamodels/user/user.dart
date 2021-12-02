class User {
  String uid;
  String email;

  User({required this.uid, required this.email});

  factory User.fromJson(Map<String, dynamic>? json) {
    final uid = json!['uid'] as String;
    final email = json['email'] as String;

    return User(uid: uid, email: email);
  }

  Map<String, dynamic> toJson() => {'uid': uid, 'email': email};
}
