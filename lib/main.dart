import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/services/jsons.dart';
import 'package:bible_game/services/shared_prefs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'activities/menus/book_select.dart';
import 'activities/menus/homescreen.dart';

const String homescreenPath = '/homescreen';
const String bookSelectPath = '/bookselect';

void main() async {
  //needed for async main
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
  await EasyLocalization.ensureInitialized();

  // TODO Detect Language and set everything automatik

  if (SharedPrefs().getSpStr(spBibleVersionJson).isEmpty) {
    SharedPrefs().setSpStr(spBibleVersionJson, 'en_bbe');
    SharedPrefs().setSpStr(spLanguage, 'English');
    SharedPrefs().setSpInt(spLanguageIndex, 4);
    SharedPrefs().setSpStr(spBibleVersionName, 'Basic English');
    SharedPrefs().setSpInt(spBibleVersionIndex, 0);
  }

  bible = await JsonService().getJson(
      'assets/json/${SharedPrefs().getSpStr(spBibleVersionJson)}.json');
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
    print(context.supportedLocales);
    print('${context.deviceLocale.toString()}');
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
