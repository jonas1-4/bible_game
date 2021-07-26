import 'package:bible_game/activities/games/level_one.dart';
import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/services/shared_prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class VerseSelect extends StatelessWidget {
  VerseSelect({required this.book, required this.chapter});
  final int book, chapter;

  @override
  Widget build(BuildContext context) {
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
        body: LayoutBuilder(builder: (context, constrains) {
          return Container(
              color: Colorthemes.background[theme],
              child: Padding(
                padding: EdgeInsets.fromLTRB(50, 20, 50, 50),
                child: Container(
                  height: constrains.maxHeight,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: bible[book]['chapters'][chapter].length,
                      itemBuilder: (context, index) {
                        List<int> verse = [book, chapter, index];
                        int verseLevel = SharedPrefs().getSpInt(spVerseLevel + verse.toString());

                        return InkWell(
                          onTap: () {
                            SharedPrefs().setSpIntList(
                                spSelectedVerse, verse);
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        new GameLevelOne()));
                          },
                          child: Container(
                            color: Colorthemes.backgroundlight[theme],
                            child: Column(
                              children: [
                                Expanded(child: Container()),
                                Text('Verse ${index + 1}',
                                    style: TextStyle(
                                        color: Colorthemes.foreground[theme],
                                        fontSize: 16)),
                                Expanded(child: Container()),

                                // Is a loop worth it?
                                Row(
                                  children: [
                                    Expanded(flex: 2, child: Container()),
                                    Icon(
                                      (verseLevel > 0)? Icons.star : Icons.star_outline,
                                      color: (verseLevel > 0)? Colorthemes.accent[theme] : Colorthemes.foreground[theme],
                                    ),
                                    Expanded(child: Container()),
                                    Icon(
                                      (verseLevel > 1)? Icons.star : Icons.star_outline,
                                      color: (verseLevel > 1)? Colorthemes.accent[theme] : Colorthemes.foreground[theme],
                                    ),
                                    Expanded(child: Container()),
                                    Icon(
                                      (verseLevel > 2)? Icons.star : Icons.star_outline,
                                      color: (verseLevel > 2)? Colorthemes.accent[theme] : Colorthemes.foreground[theme],
                                    ),
                                    Expanded(flex: 2, child: Container()),
                                  ],
                                ),
                                Expanded(child: Container()),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ));
        }));
  }
}
