import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/services/bible.dart';
import 'package:bible_game/services/shared_prefs.dart';
import 'package:bible_game/ui/widgets/menucard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../main.dart';
import '../game.dart';

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
                        return InkWell(
                          onTap: () {
                            List verses =
                                Bible().getSplitVerse(book, chapter, index);
                            SharedPrefs().setSpIntList(
                                spLastVerse, [book, chapter, index]);
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new RememberingGame(
                                          book: book,
                                          chapter: chapter,
                                          verse: index,
                                        )));
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
                                      Icons.star_outline,
                                      color: Colorthemes.foreground[theme],
                                    ),
                                    Expanded(child: Container()),
                                    Icon(
                                      Icons.star_outline,
                                      color: Colorthemes.foreground[theme],
                                    ),
                                    Expanded(child: Container()),
                                    Icon(
                                      Icons.star_outline,
                                      color: Colorthemes.foreground[theme],
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Container()),
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
