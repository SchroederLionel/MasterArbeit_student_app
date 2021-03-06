import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Theme provider is used for managing the theme changed.
/// Contains the theme light and dark and stores the favorite theme in shared preferences.
class ThemeProvider extends ChangeNotifier {
  ThemeData light = ThemeData(
      fontFamily: 'Poppins',
      primaryColor: Colors.orange,
      primaryColorDark: Colors.orange,
      iconTheme: const IconThemeData(color: Colors.white),
      dialogBackgroundColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
      )),
      backgroundColor: Colors.indigo,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      canvasColor: Colors.white,
      cardColor: Colors.white,
      textTheme: const TextTheme(
          headline1: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Colors.black),
          headline2: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 31,
              fontWeight: FontWeight.bold,
              color: Colors.black),
          subtitle1: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 21,
              fontWeight: FontWeight.w600,
              color: Colors.black),
          bodyText1: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black),
          bodyText2: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.black),
          headline6: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black),
          headline5: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 38,
              fontWeight: FontWeight.w400,
              color: Colors.black)));

  ThemeData dark = ThemeData(
      fontFamily: 'Poppins',
      primaryColor: Colors.orangeAccent,
      primaryColorDark: Colors.orangeAccent,
      dialogBackgroundColor: const Color(0xFF212332),
      iconTheme: const IconThemeData(color: Colors.white70),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
      )),
      backgroundColor: const Color(0xFF212332),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF212332),
      canvasColor: const Color(0xFF2A2D3E),
      cardColor: const Color(0xFF2A2D3E),
      textTheme: const TextTheme(
        headline1: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        headline2: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 31,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        subtitle1: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 21,
            fontWeight: FontWeight.w600,
            color: Colors.white),
        bodyText1: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.white),
        bodyText2: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white),
        headline5: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 38,
            fontWeight: FontWeight.w400,
            color: Colors.white),
        headline6: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white),
      ));

  /// ThemeProvider required at intitialization the theme mode ( light or dark.)
  /// Parameter is a bool true if dark theme should be used and white for white theme.
  ThemeProvider({required bool isDarkMode}) {
    _mode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    if (_mode == ThemeMode.dark) {
      changeSystemBarDark();
    } else {
      changeSystemBarLight();
    }
  }

  ThemeMode get mode => _mode;
  late ThemeMode _mode;

  /// Function which allows to change the systen status bar color. (Light)
  void changeSystemBarLight() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent));
    _mode = ThemeMode.light;
  }

  /// Function which allows to change the systen status bar color. (Black)
  void changeSystemBarDark() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent));

    _mode = ThemeMode.dark;
  }

  /// Function which allows to swap the theme from dark to white or the other way depending on the current theme mode.
  /// On swap the  change of will be stored in the shared preferences.
  void swapTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_mode == ThemeMode.dark) {
      changeSystemBarLight();
    } else {
      changeSystemBarDark();
    }

    prefs.setBool('themeDark', _mode == ThemeMode.dark ? true : false);
    notifyListeners();
  }
}
