import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/services/jsons.dart';
import 'package:bible_game/services/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'activities/menus/book_select.dart';
import 'activities/menus/homescreen.dart';

const String homescreenPath = '/homescreen';
const String bookSelectPath = '/bookselect';

void main() async {
  //needed for async main
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();

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
  runApp(MaterialApp(initialRoute: homescreenPath, routes: {
    homescreenPath: (context) => Homescreen(),
    bookSelectPath: (context) => BookSelect(),
  }));
}
