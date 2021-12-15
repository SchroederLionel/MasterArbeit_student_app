import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  ThemeProvider({required bool isDarkMode}) {
    _mode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  ThemeMode get mode => _mode;
  late ThemeMode _mode;
  void swapTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _mode = _mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    prefs.setBool('themeDark', _mode == ThemeMode.dark ? true : false);
    notifyListeners();
  }
}
