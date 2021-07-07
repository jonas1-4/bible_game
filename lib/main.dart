
import 'package:flutter/material.dart';

import 'activities/menus/homescreen.dart';

const String HomescreenPath = '/homescreen';
const String VerseselectPath = '/verseselect';

void main() {
  runApp(MaterialApp(
    initialRoute: HomescreenPath,
    routes: {
      HomescreenPath: (context) => Homescreen(),
    }
  ));
}
