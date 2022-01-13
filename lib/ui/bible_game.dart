import 'package:bible_game/activities/menus/homescreen.dart';
import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


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
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colorthemes.foreground[theme],
                displayColor: Colorthemes.foreground[theme],
              ),
        ),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        home: Homescreen(),
      );
    });
  }
}
