import 'dart:async';

import 'package:bible_game/activities/menus/homescreen.dart';
import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/ui/widgets/photo_hero.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

BuildContext? _context ;

// TODO the hero animation should go to homescreen
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool navigate = false;
  startTimer() async {
    Timer(Duration(milliseconds: 10000), () {
      Navigator.of(_context!)
          .push(MaterialPageRoute(builder: (context) => Homescreen()));
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
     timeDilation = 15;
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
