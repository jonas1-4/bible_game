import 'package:bible_game/services/app_service.dart';
import 'package:bible_game/ui/bible_game.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

const String splashscreenPath = '/splash';
const String biblegamePath = '/biblegame';
const String homescreenPath = '/homescreen';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await AppService().bibleGameInit();
  runApp(BibleGame());
}
