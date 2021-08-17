import 'package:bible_game/activities/menus/homescreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../main.dart';



//EasyLocalization and MaterialApp require to be run in seperated classes??

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
      initialRoute: homescreenPath,
      debugShowCheckedModeBanner: false,
      routes: {
        homescreenPath: (context) => Homescreen(),
      },
    );
  }
}
