
import 'dart:convert';

import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/services/jsons.dart';
import 'package:flutter/material.dart';

import 'activities/menus/homescreen.dart';

const String HomescreenPath = '/homescreen';
const String VerseselectPath = '/verseselect';
void main() async{
  //needed for Flutter and assets
  WidgetsFlutterBinding.ensureInitialized();

  bible = await JsonService().getJson('assets/de_schlachter.json');
  print('${bible[0]['chapters'][0][0]}');
  runApp(MaterialApp(
    initialRoute: HomescreenPath,
    routes: {
      HomescreenPath: (context) => Homescreen(),
    }
  ));
}
