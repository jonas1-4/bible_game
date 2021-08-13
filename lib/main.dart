import 'package:bible_game/services/app_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'activities/menus/book_select.dart';
import 'activities/menus/homescreen.dart';

const String homescreenPath = '/homescreen';
const String bookSelectPath = '/bookselect';

void main() async {

  //needed for async main
  WidgetsFlutterBinding.ensureInitialized();
  await AppService().bibleGameInit();

  runApp(EasyLocalization(
    supportedLocales: [Locale('en'), Locale('de')],
    path: 'assets/translations',
    fallbackLocale: Locale('en'),
    child: BibleGame(),
  ));
}

class BibleGame extends StatelessWidget {
  const BibleGame({
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
        bookSelectPath: (context) => BookSelect(),
      },
    );
  }
}
