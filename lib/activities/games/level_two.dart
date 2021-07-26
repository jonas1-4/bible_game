import 'package:bible_game/activities/menus/after_level.dart';
import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/services/bible.dart';
import 'package:bible_game/services/game_service.dart';
import 'package:bible_game/services/shared_prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../main.dart';

class GameLevelOne extends StatefulWidget {
  @override
  _GameLevelOneState createState() => _GameLevelOneState();
}

class _GameLevelOneState extends State<GameLevelOne> {
  //unorderedVerses   = bottom words shuffled
  //orderedVerses     = words in correctOrder
  //correctVerses     = words which are accepted/pressed
  //noDublicateVerses = words in correctOrder but without dublicates
  //errors            = times a wrong word was clicked/number of hearts
  List<String> unorderedVerses = [],
      orderedVerses = [],
      correctVerses = [],
      noDublicateVerses = [];
  int errors = 0;

  @override
  void initState() {
    super.initState();

    //printing to see Solution for debuging etc.
    print(orderedVerses);

    noDublicateVerses = orderedVerses.toSet().toList();
    List<int> selectedVerse = SharedPrefs().getSpIntList(spSelectedVerse);
    List verses = Bible()
        .getSplitVerse(selectedVerse[0], selectedVerse[1], selectedVerse[2]);
    orderedVerses = verses[0];
    unorderedVerses = verses[1];
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
                  Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Wrap(
                            children: orderedVerses.map((e) {
                          return InkWell(
                              child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Chip(
                                      backgroundColor: (!correctVerses
                                              .contains(e))
                                          ? Colorthemes.backgroundlight[theme]
                                          : Colorthemes.backgroundlight[theme],
                                      shadowColor:
                                          Colorthemes.backgroundlight[theme],
                                      label: Text(
                                        e,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: (!correctVerses.contains(e))
                                              ? Colorthemes
                                                  .backgroundlight[theme]
                                              : Colorthemes.foreground[theme],
                                        ),
                                      ))));
                        }).toList()),
                      ),
                      OrderChipsGame(
                          bottomList: unorderedVerses,
                          topList: correctVerses,
                          onWrong: () {
                            setState() {
                              errors++;
                            }
                          },
                          onAllCorrect: () {
                            GameService().increaseLevel();
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new EndScreen()));
                          })
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OrderChipsGame extends StatefulWidget {
  const OrderChipsGame({
    Key? key,
    required this.bottomList,
    required this.topList,
    required this.onWrong,
    required this.onAllCorrect,
  }) : super(key: key);

  final List<String> topList;
  final List<String> bottomList;
  final Function onWrong;
  final Function onAllCorrect;

  @override
  _OrderChipsGameState createState() => _OrderChipsGameState();
}

class _OrderChipsGameState extends State<OrderChipsGame> {
  List<String> noDublicateVerses = [], bottomList = [], topList = [];
  int errors = 0;

  @override
  void initState() {
    super.initState();
    noDublicateVerses = widget.topList.toSet().toList();
    bottomList = widget.bottomList;
    topList = widget.topList;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: widget.bottomList.map((e) {
              return InkWell(
                child: Container(
                    margin: EdgeInsets.all(3),
                    child: InkWell(
                      onTap: () {
                        if (noDublicateVerses[widget.topList.length] == e) {
                          setState(() {
                            while (bottomList.contains(e)) bottomList.remove(e);
                            topList.add(e);
                          });
                          if (widget.topList.length ==
                              noDublicateVerses.length) {
                            if (errors < 4) {
                              widget.onAllCorrect();
                            }
                          }
                        } else {
                          errors++;
                          widget.onWrong();
                        }
                      },
                      child: Chip(
                          backgroundColor: Colorthemes.backgroundlight[theme],
                          shadowColor: Colorthemes.backgroundlight[theme],
                          label: Text(e,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colorthemes.foreground[theme]))),
                    )),
              );
            }).toList(),
          ),
        ));
  }
}