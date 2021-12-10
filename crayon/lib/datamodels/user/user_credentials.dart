import 'package:validators/validators.dart';

class UserBasics {
  String email;
  String password;
  UserBasics({required this.email, required this.password});

  String? isValid(String verificationPassod) {
    if (!isEmail(email)) {
      return 'invalidEmail';
    } else if (isPasswordValid(password)) {
      return 'passwordCheck';
    } else if (password != verificationPassod) {
      return 'passwordMatch';
    }

    return null;
  }

  bool isValidLogin() {
    if (isEmail(email) && isPasswordValid(password)) {
      return true;
    }
    return false;
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
