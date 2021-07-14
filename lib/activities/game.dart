import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/services/bible.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../main.dart';

class RememberingGame extends StatefulWidget {
  RememberingGame({
    required this.book,
    required this.chapter,
    required this.verse,
  });
  final int book, chapter, verse;

  @override
  _RememberingGameState createState() => _RememberingGameState();
}

class _RememberingGameState extends State<RememberingGame> {
  List<String> unorderedVerses = [],
      orderedVerses = [],
      correctVerses = [],
      noDublicateVerses = [];

  @override
  void initState() {
    super.initState();
    noDublicateVerses = orderedVerses.toSet().toList();
    List verses =
        Bible().getSplitVerse(widget.book, widget.chapter, widget.verse);
    orderedVerses = verses[0];
    unorderedVerses = verses[1];
    noDublicateVerses = orderedVerses.toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    print(orderedVerses);
    return WillPopScope(
      onWillPop: () async {
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
                  Expanded(
                    flex: 1,
                    child: Wrap(
                        children: orderedVerses.map((e) {
                      return InkWell(
                          child: Container(
                              margin: EdgeInsets.all(3),
                              child: Chip(
                                  backgroundColor: (!correctVerses.contains(e))
                                      ? Colorthemes.backgroundlight[theme]
                                      : Colorthemes.backgroundlight[theme],
                                  shadowColor:
                                      Colorthemes.backgroundlight[theme],
                                  label: Text(
                                    e,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: (!correctVerses.contains(e))
                                          ? Colorthemes.backgroundlight[theme]
                                          : Colorthemes.foreground[theme],
                                    ),
                                  ))));
                    }).toList()),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.end,
                          children: unorderedVerses.map((e) {
                            return InkWell(
                              child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: InkWell(
                                    onTap: () {
                                      if (noDublicateVerses[
                                              correctVerses.length] ==
                                          e) {
                                        setState(() {
                                          while(unorderedVerses.contains(e)) unorderedVerses.remove(e);
                                          correctVerses.add(e);
                                        });
                                      }
                                    },
                                    child: Chip(
                                        backgroundColor:
                                            Colorthemes.backgroundlight[theme],
                                        shadowColor:
                                            Colorthemes.backgroundlight[theme],
                                        label: Text(e,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colorthemes
                                                    .foreground[theme]))),
                                  )),
                            );
                          }).toList(),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
