import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/ui/widgets/menucard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../main.dart';
import 'menus/homescreen.dart';

class RememberingGame extends StatefulWidget {
  RememberingGame({
    required this.unorderedVerse,
    required this.orderedVerse,
  });
  final List<String> unorderedVerse, orderedVerse;

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
    unorderedVerses = widget.unorderedVerse;
    orderedVerses = widget.orderedVerse;
    noDublicateVerses = orderedVerses.toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    print(orderedVerses);
    return Scaffold(
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
                                shadowColor: Colorthemes.backgroundlight[theme],
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
                                      unorderedVerses.remove(e);
                                        correctVerses.add(e);
                                    });}
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
    );
  }
}
