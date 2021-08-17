import 'package:bible_game/activities/menus/homescreen.dart';
import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/services/app_service.dart';
import 'package:bible_game/ui/widgets/photo_hero.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../main.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  startTimer() async {
    await AppService().bibleGameInit();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Homescreen()));

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 10;
    startTimer();
    return Scaffold(
      backgroundColor: Colorthemes.background[theme],
      body: Center(
          child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colorthemes.foreground[theme], BlendMode.srcIn),
              child: PhotoHero(
                photo: 'assets/images/MenuDrawing.png',
                width: 150,
              ))),
    );
  }
}
