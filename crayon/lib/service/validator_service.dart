import 'package:crayon/l10n/app_localizations.dart';
import 'package:validators/validators.dart';

/// The Validator service class is used to check if the users input fields are valid.
class ValidatorService {
  /// Function which allows to check if an email is valid.
  /// If the email if valid null will be returned.
  /// Else the respective error message.
  static String? checkEmail(String? email, AppLocalizations? appLo) {
    if (email != null) {
      if (!isEmail(email)) {
        return appLo!.translate('invalidEmail') ?? 'Invalid Email';
      }
    } else {
      return appLo!.translate('required') ?? 'Required';
    }
    return null;
  }

  /// Function which allows to check if the users credential at the account registration is valid.
  /// returns null if the verification did not fail.
  /// else returns an error code.
  static String? isValid(
      String email, String password, String? verificationPassword) {
    if (verificationPassword != password) {
      return 'passwordMatch';
    } else if (!isEmail(email)) {
      return 'invalidEmail';
    } else if (password.length < 8) {
      return 'passwordCheck';
    } else {
      return null;
    }
  }

  /// Function allows to check if the password entered by the user is valid.
  /// I.E if the password has a length less than 8 the password is no longer valid.
  static String? checkPassword(String? password, AppLocalizations? appLo) {
    if (password != null) {
      if (password.trim().isEmpty) {
        return appLo!.translate('required') ?? 'Required';
      }
      if (password.trim().length < 8) {
        return appLo!.translate('passwordCheck') ?? 'passwordCheck';
      }
    } else {
      return appLo!.translate('required') ?? 'Required';
    }
    return null;
  }

  /// Function which allos to check if the verification password matches the password.
  /// Returns null if valid.
  /// Else returns the respective error code.
  static String? checkVerificationPassword(
      String? password, String? verificationPassword, AppLocalizations? appLo) {
    if (password != null && verificationPassword != null) {
      if (verificationPassword.trim().isEmpty) {
        return appLo!.translate('required') ?? 'Required';
      }
      if (verificationPassword.trim().length < 8) {
        return appLo!.translate('passwordCheck') ??
            'Passwords length us below 8.';
      }
      if (verificationPassword != password) {
        return appLo!.translate('passwordMatch') ?? 'Passwords do not match';
      }
    } else {
      return appLo!.translate('required') ?? 'Required';
    }
    return null;
  }

  ///Function which allows to check if a given string has a length above of two.
  static String? isStringLengthAbove2(String? text, AppLocalizations? appLo) {
    if (text != null) {
      if (!isByteLength(text, 2)) {
        return appLo!.translate('required') ?? 'Required';
      }
    } else {
      return appLo!.translate('required') ?? 'Required';
    }

    return null;
  }

  /// Function which allows to check if a string is a number.
  static String? isNumber(String? text) {
    if (text != null) {
      if (isInt(text)) {
        return 'Number required';
      }
    }
    return null;
  }
}
