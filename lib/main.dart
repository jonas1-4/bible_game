import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/services/jsons.dart';
import 'package:bible_game/services/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'activities/menus/book_select.dart';
import 'activities/menus/homescreen.dart';

const String homescreenPath = '/homescreen';
const String bookSelectPath = '/bookselect';

void main() async{
  //needed for async main
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
  bible = await JsonService().getJson('assets/$currentTranslation');
  runApp(MaterialApp(
    initialRoute: homescreenPath,
    routes: {
      homescreenPath: (context) => Homescreen(),
      bookSelectPath: (context) => BookSelect(),
    }
  ));
}
