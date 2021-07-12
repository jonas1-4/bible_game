import 'package:bible_game/activities/menus/verse_select.dart';
import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class ChapterSelect extends StatelessWidget {
  ChapterSelect({required this.book});
  final int book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colorthemes.background[theme],
          backgroundColor: Colorthemes.backgroundlight[theme],
          title: Title(
              color: Colors.black,
              child: Text(
                'Chapter',
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
                  child: ListView.builder(
                      itemCount: bible[book]['chapters'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              if (index != 0)
                                Divider(
                                    color: Colorthemes.backgroundlight[theme]),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      primary:
                                          Colorthemes.backgroundlight[theme]),
                                  onPressed: () {
                                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new VerseSelect(book: book, chapter: index)));
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    children: [
                                      
                                      Text('Chapter ${index + 1}',
                                          style: TextStyle(
                                              color: Colorthemes
                                                  .foreground[theme],
                                              fontSize: 16)),
                                      Expanded(child: Container()),
                                      Text('0/${bible[book]['chapters'][index].length}')
                                    ],
                                  )),
                            ],
                          ),
                        );
                      }),
                ),
              ));
        }));
  }
}
