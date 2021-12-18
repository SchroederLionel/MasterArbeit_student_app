import 'package:crayon/l10n/app_localizations.dart';
import 'package:crayon/l10n/app_localizations_delegate.dart';
import 'package:crayon/providers/login/login_provider.dart';
import 'package:crayon/providers/util/connection_provider.dart';
import 'package:crayon/providers/util/locale_provider.dart';
import 'package:crayon/providers/util/theme.dart';
import 'package:crayon/state/enum.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'route/route.dart' as route;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MultiProvider(
    providers: [
      StreamProvider<ConnectivityStatus>(
        create: (context) =>
            ConnectionProvider().connectionStatusController.stream,
        initialData: ConnectivityStatus.offline,
      ),
      ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
      ChangeNotifierProvider<ThemeProvider>(
          create: (_) =>
              ThemeProvider(isDarkMode: prefs.getBool('themeDark') ?? false)),
      ChangeNotifierProvider<LocaleProvider>(
          create: (_) => LocaleProvider(prefs.getString('language'))),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final localeProvider = Provider.of<LocaleProvider>(context, listen: true);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: MaterialApp(
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
      ),
    );
  }
}
