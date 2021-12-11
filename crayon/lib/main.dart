import 'package:crayon/constants/constants.dart';
import 'package:crayon/l10n/app_localizations.dart';
import 'package:crayon/l10n/app_localizations_delegate.dart';
import 'package:crayon/providers/login/login_provider.dart';

import 'package:crayon/providers/util/locale_provider.dart';
import 'package:crayon/providers/util/theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'route/route.dart' as route;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  resetView();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
      ChangeNotifierProvider<ThemeProvider>(
          create: (BuildContext context) =>
              ThemeProvider(isDarkMode: prefs.getBool('themeDark') ?? false)),
      ChangeNotifierProvider<LocaleProvider>(
          create: (_) => LocaleProvider(prefs.getString('language'))),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final localeProvider = Provider.of<LocaleProvider>(context, listen: true);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crayon',
      themeMode: themeProvider.mode,
      theme: themeProvider.light,
      darkTheme: themeProvider.dark,
      onGenerateRoute: route.controller,
      initialRoute: route.splash,
      locale: localeProvider.getLocal,
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.languages,
    );
  }
}
