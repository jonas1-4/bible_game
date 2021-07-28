import 'dart:collection';

import 'package:bible_game/activities/menus/after_level.dart';
import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/services/bible.dart';
import 'package:bible_game/services/game_service.dart';
import 'package:bible_game/services/shared_prefs.dart';
import 'package:bible_game/ui/widgets/order_chips_game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../main.dart';

class GameLevelThree extends StatefulWidget {
  @override
  _GameLevelThreeState createState() => _GameLevelThreeState();
}

class _GameLevelThreeState extends State<GameLevelThree> {
  int errors = 0;
  List<String> verse = [];

  void madeError(){
    setState(() {
      errors++;
    });
  }

  @override
  void initState() {
    super.initState();
    List<int> selectedVerse = SharedPrefs().getSpIntList(spSelectedVerse);
    verse = Bible()
        .getSplitVerse(selectedVerse[0], selectedVerse[1], selectedVerse[2]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //have to pop so the lastverse/continue Button updates
        Navigator.popAndPushNamed(context, homescreenPath);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colorthemes.background[theme],
          backgroundColor: Colorthemes.backgroundlight[theme],
          title: Title(
              color: Colors.black,
              child: Text(
                'Verse',
                style: TextStyle(color: Colorthemes.foreground[theme]),
              )),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SizedBox.expand(
            child: Container(
              padding: EdgeInsets.all(20),
              color: Colorthemes.background[theme],
              child: Column(
                children: <Widget>[
                  (errors < 4)
                      ? Row(children: [
                          Expanded(
                            child: Container(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Icon(
                                (errors < 1)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colorthemes.accentlight[theme],
                                size: 25),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Icon(
                                (errors < 2)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colorthemes.accentlight[theme],
                                size: 25),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Icon(
                                (errors < 3)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colorthemes.accentlight[theme],
                                size: 25),
                          ),
                        ])
                      : Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Icon(Icons.favorite_border,
                              color: Colorthemes.background[theme], size: 25),
                        ),
                  SizedBox(height: 20),
                  OrderChipsGame(
                      firstLetter: true,
                      itemList: verse,
                      onWrong: madeError,
                      onAllCorrect: () {
                        GameService().increaseLevel();
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new EndScreen()));
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}