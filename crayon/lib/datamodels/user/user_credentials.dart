import 'package:validators/validators.dart';

/// UserBasics used for login and creation of the account.
/// Contains function for validations.
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

  ///function which checks if the email and the password is valid.
  ///Returns true if valid else false;
  bool isValidLogin() {
    if (isEmail(email) && isPasswordValid(password)) {
      return true;
    }
    return false;
  }

  /// Funciton which checks if the password is Valid.
  /// length of the password has to be above 8.
  /// returns true if password is valid else false.
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
