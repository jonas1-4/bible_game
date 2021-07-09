import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/services/jsons.dart';
import 'package:flutter/material.dart';

import 'activities/menus/homescreen.dart';
import 'activities/menus/verseselect.dart';

const String homescreenPath = '/homescreen';
const String verseSelectPath = '/verseselect';
void main() async{
  //needed for Flutter and assets
  WidgetsFlutterBinding.ensureInitialized();

  bible = await JsonService().getJson('assets/de_schlachter.json');
  print('${bible[0]['chapters'][0][0]}');
  runApp(MaterialApp(
    initialRoute: homescreenPath,
    routes: {
      homescreenPath: (context) => Homescreen(),
      verseSelectPath: (context) => VerseSelect(),
    }
  ));
}
