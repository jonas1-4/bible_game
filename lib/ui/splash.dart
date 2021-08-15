import 'dart:async';

import 'package:bible_game/activities/menus/homescreen.dart';
import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/ui/widgets/photo_hero.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  startTimer() {
    var _duration = Duration(milliseconds: 1000);
    return Timer(_duration, navigate);
  }

  void navigate() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => Homescreen()));
  }

  @override
  void initState() {
    startTimer();

    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    timeDilation = 10;
    return Scaffold(
        backgroundColor: Colorthemes.background[theme],
        body: Center(
            child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colorthemes.foreground[theme], BlendMode.srcIn),
            child: PhotoHero(
              photo: 'assets/images/MenuDrawing.png',
              width: 300,
            ))));
  }
}
