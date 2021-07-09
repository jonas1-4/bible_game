
import 'dart:convert';

import 'package:bible_game/services/jsons.dart';
import 'package:flutter/material.dart';

import 'activities/menus/homescreen.dart';

const String HomescreenPath = '/homescreen';
const String VerseselectPath = '/verseselect';
String bible = '';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  bible = await JsonService().getJson('assets/de_schlachter.json');

  final data = jsonDecode(bible);
  print('${data[0]['chapters'][0][0]}');
  runApp(MaterialApp(
    initialRoute: HomescreenPath,
    routes: {
      HomescreenPath: (context) => Homescreen(),
    }
  ));
}
