import 'package:crayon/datamodels/custom_locale.dart';
import 'package:crayon/l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The localprovider is used for language changes.
/// By chaning the language the new language string code will be stored into the sharedpreferences.
class LocaleProvider extends ChangeNotifier {
  Locale _locale = AppLocalizations.languages.first;

  LocaleProvider(String? code) {
    if (code == null) {
      _locale = AppLocalizations.languages.first;
    } else {
      _locale = CustomLocale(languageCode: code);
    }
  }

  Locale get getLocal => _locale;

  void setLocale(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _locale = locale;
    prefs.setString('language', _locale.languageCode);
    notifyListeners();
  }
}
