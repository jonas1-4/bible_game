import 'package:bible_game/ui/splash.dart';
import 'package:bible_game/ui/bible_game.dart';
import 'package:flutter/material.dart';

const String splashscreenPath = '/splash';
const String biblegamePath    = '/biblegame';
const String homescreenPath   = '/homescreen';

void main() {
  //create MaterialApp just for splashscreen (everything gets initialised as
  //soon as the splash screen is displayed)
  runApp(MaterialApp(
    initialRoute: splashscreenPath,
    routes: {
      splashscreenPath: (context) => Splash(),
      biblegamePath: (context) => BibleGame()
    },
  ));
}
