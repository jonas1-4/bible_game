import 'package:bible_game/ui/splash.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'activities/menus/book_select.dart';
import 'activities/menus/homescreen.dart';

const String homescreenPath = '/homescreen';
const String bookSelectPath = '/bookselect';
const String splashscreenPath = '/splash';
const String biblegamePath = '/biblegame';

void main() {
  runApp(MaterialApp(initialRoute: splashscreenPath, routes: {splashscreenPath: (context) => Splash(), biblegamePath: (context) => BibleGame()},));
}

class BibleGame extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
        supportedLocales: [Locale('en'), Locale('de')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: BibleMaterialGame());
  }
}

class BibleMaterialGame extends StatelessWidget {
  const BibleMaterialGame({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: splashscreenPath,
      debugShowCheckedModeBanner: false,
      routes: {
        splashscreenPath: (context) => Splash(),
        homescreenPath: (context) => Homescreen(),
        bookSelectPath: (context) => BookSelect(),
      },
    );
  }
}