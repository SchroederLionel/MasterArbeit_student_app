import 'package:validators/validators.dart';

class UserBasics {
  String email;
  String password;
  UserBasics({required this.email, required this.password});

  bool isValid() {
    if (isEmail(email) && isPasswordValid(password)) {
      return true;
    } else {
      return false;
    }
  }

  bool isPasswordValid(String password) {
    password = password.trim();
    if (password.isEmpty) {
      return false;
    } else if (password.length < 8) {
      return false;
    } else {
      return true;
    }
  }
}
