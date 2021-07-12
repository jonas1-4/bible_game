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
  List<String> unorderedVerse = [], orderedVerse = [];
  Map<String, bool> score = {};

  @override
  void initState() {
    super.initState();
    unorderedVerse = widget.unorderedVerse;
    orderedVerse = widget.orderedVerse;
  }

  @override
  Widget build(BuildContext context) {
    String i;
    for (i in orderedVerse) {
      if (!unorderedVerse.contains(i)) {
        score[i] = true;
      }
    }
    print(orderedVerse);
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
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                  alignment: Alignment.topCenter,
                  color: Colorthemes.background[theme],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        color: Colorthemes.backgroundlight[theme],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Wrap(
                              children: orderedVerse.map((e) {
                            return Draggable<String>(
                              data: e,
                              child: Container(
                                color: Colorthemes.backgroundlight[theme],
                                child: Column(children: <Widget>[
                                  if (score[e] == true)
                                    Container()
                                  else
                                    Material(
                                        color: Colorthemes.backgroundlight[theme],
                                        child: Container(
                                      color: Colorthemes.backgroundlight[theme],
                                      margin: new EdgeInsets.symmetric(
                                          horizontal: 3.0, vertical: 4),
                                      child: InkWell(
                                        onTap: () {
                                          for (var i in orderedVerse) {
                                            if (score[i] != true) {
                                              if (e == i) {
                                                setState(() {
                                                  score[i] = true;
                                                  for (var c in orderedVerse) {
                                                    if (c == i) {
                                                      unorderedVerse.remove(i);
                                                    }
                                                  }
                                                  if (0 ==
                                                      unorderedVerse.length) {
                                                    runApp(Homescreen());
                                                  }
                                                });
                                                return;
                                              }
                                              return;
                                            }
                                          }
                                        },
                                        child: Chip(
                                          elevation: 4,
                                          backgroundColor: Colorthemes
                                              .background[theme],
                                          label: Text(
                                            e,
                                            style: TextStyle(
                                                color: Colorthemes.foreground[theme],
                                                fontSize: 17),
                                          ),
                                        ),
                                      ),
                                    ))
                                ]),
                              ),
                              feedback: Material(
                                color: Colors.transparent,
                                child: Chip(
                                  backgroundColor:
                                      Colorthemes.backgroundlight[theme],
                                  label: Text(
                                    e,
                                    style: TextStyle(
                                        color: Colorthemes.foreground[theme],
                                        fontSize: 17),
                                  ),
                                ),
                              ),
                              childWhenDragging: Container(),
                            );
                          }).toList()),
                        ),
                      ),
                    ),
                  ))
              //Container(
              //    height: 300,
              //    alignment: Alignment.topCenter,
              //    color: Colorthemes.background[theme],
              //    child: Padding(
              //      padding: const EdgeInsets.all(8.0),
              //      child: Container(
              //          height: 100,
              //        child: Card(
              //            color: Colorthemes.accent[theme],
              //          child: Padding(
              //            padding: const EdgeInsets.all(8.0),
              //            child: Container(
              //                height: 399,
              //              child: Column(
              //                crossAxisAlignment: CrossAxisAlignment.start,
              //                mainAxisSize: MainAxisSize.min,
              //                children: <Widget>[
              //                  ListView(
              //                    children: [
              //                      Wrap(
              //                          alignment: WrapAlignment.start,
              //                          children: orderedVerse.map((e) {
              //                            return DragTarget<String>(
              //                              builder: (BuildContext context,
              //                                  List<String?> incoming,
              //                                  List rejected) {
              //                                if (score[e]!) {
              //                                  return Container(
              //    height: 300,
              //                                    color: Colorthemes.accent[theme],
              //                                    margin: new EdgeInsets.symmetric(
              //                                        horizontal: 3.0),
              //                                    child: Material(
              //                                      color: Colors.transparent,
              //                                      child: Chip(
              //                                        elevation: 4,
              //                                        backgroundColor: Colorthemes
              //                                            .backgroundlight[theme],
              //                                        label: Text(
              //                                          e,
              //                                          style: TextStyle(
              //                                              color: Colors.black,
              //                                              fontSize: 17),
              //                                        ),
              //                                      ),
              //                                    ),
              //                                  );
              //                                } else {
              //                                  return Container(
              //                                    margin: new EdgeInsets.symmetric(
              //                                        horizontal: 3.0),
              //                                    color: Colorthemes.accent[theme],
              //                                    child: Material(

              //                                      color: Colorthemes.accent[theme],
              //                                      child: Chip(
              //                                        backgroundColor:
              //                                            Colors.grey[200],
              //                                        label: Text(
              //                                          e,
              //                                          style: TextStyle(
              //                                              color:
              //                                                  Colors.grey[200]),
              //                                        ),
              //                                      ),
              //                                    ),
              //                                  );
              //                                }
              //                              },

              //                              //Wenn eingabe Richtig dann:

              //                              onAccept: (data) {
              //                                setState(() {
              //                                  score[e] = true;

              //                                  for (var c in orderedVerse) {
              //                                    if (c == e) {
              //                                      orderedVerse.remove(e);
              //                                    }
              //                                  }

              //                                  if (0 == unorderedVerse.length) {
              //                                    runApp(Homescreen());
              //                                  }
              //                                });
              //                              },

              //                              onWillAccept: (data) => data == e,

              //                              onLeave: (data) {},
              //                            );
              //                          }).toList()),
              //                    ],
              //                  ),
              //                  //Container(
              //                  //    alignment: Alignment.bottomRight,
              //                  //    child: Text('$stelle'))
              //                ],
              //              ),
              //            ),
              //          ),
              //        ),
              //      ),
              //    )),
            ),
            Expanded(
              child: Container(
                  alignment: Alignment.bottomCenter,
                  color: Colorthemes.background[theme],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        color: Colorthemes.backgroundlight[theme],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Wrap(
                              children: unorderedVerse.map((e) {
                            return Draggable<String>(
                              data: e,
                              child: Container(
                                color: Colorthemes.backgroundlight[theme],
                                child: Column(children: <Widget>[
                                  if (score[e] == true)
                                    Container()
                                  else
                                    Material(
                                        color: Colorthemes.backgroundlight[theme],
                                        child: Container(
                                      color: Colorthemes.backgroundlight[theme],
                                      margin: new EdgeInsets.symmetric(
                                          horizontal: 3.0, vertical: 4),
                                      child: InkWell(
                                        onTap: () {
                                          for (var i in orderedVerse) {
                                            if (score[i] != true) {
                                              if (e == i) {
                                                setState(() {
                                                  score[i] = true;
                                                  for (var c in orderedVerse) {
                                                    if (c == i) {
                                                      unorderedVerse.remove(i);
                                                    }
                                                  }
                                                  if (0 ==
                                                      unorderedVerse.length) {
                                                    runApp(Homescreen());
                                                  }
                                                });
                                                return;
                                              }
                                              return;
                                            }
                                          }
                                        },
                                        child: Chip(
                                          elevation: 4,
                                          backgroundColor: Colorthemes
                                              .background[theme],
                                          label: Text(
                                            e,
                                            style: TextStyle(
                                                color: Colorthemes.foreground[theme],
                                                fontSize: 17),
                                          ),
                                        ),
                                      ),
                                    ))
                                ]),
                              ),
                              feedback: Material(
                                color: Colors.transparent,
                                child: Chip(
                                  backgroundColor:
                                      Colorthemes.backgroundlight[theme],
                                  label: Text(
                                    e,
                                    style: TextStyle(
                                        color: Colorthemes.foreground[theme],
                                        fontSize: 17),
                                  ),
                                ),
                              ),
                              childWhenDragging: Container(),
                            );
                          }).toList()),
                        ),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
