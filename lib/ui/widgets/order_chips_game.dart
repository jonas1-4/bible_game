import 'dart:math';

import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:flutter/material.dart';

int _position = 0;

class OrderChipsGame extends StatefulWidget {
  const OrderChipsGame({
    Key? key,
    required this.itemList,
    required this.onWrong,
    required this.onLost,
    required this.onAllCorrect,
    this.level = 0,
    this.percentHidden = 0,
  }) : super(key: key);

  //unorderedVerses   = bottom words shuffled
  //orderedVerses     = words in correctOrder
  //correctVerses     = words which are accepted/pressed
  //noDublicateVerses = words in correctOrder but without dublicates
  //errors            = times a wrong word was clicked/number of hearts
  final List<String> itemList;
  final Function onWrong;
  final Function onAllCorrect;
  final Function onLost;
  final int percentHidden, level;

  @override
  _OrderChipsGameState createState() => _OrderChipsGameState();
}

class _OrderChipsGameState extends State<OrderChipsGame> {
  List<String> bottomList = [], topList = [], checkList = [];
  int errors = 0, count = 0, percentHidden = 0;
  bool firstLetter = false;
  List<Map<String, bool>> gangGang = [new Map<String, bool>()];
  final ScrollController topScrollController = ScrollController(), botScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    switch (widget.level) {
      case 0:
        {
          percentHidden = widget.percentHidden;
        }
        break;
      case 1:
        break;
      case 2:
        {
          firstLetter = true;
        }
        break;
      case 3:
        {
          firstLetter = true;
        }
        break;
    }
    topList = widget.itemList;
    bottomList = List.from(topList);
    gangGang.removeAt(0);
    for (String word in topList) {
      gangGang.add({word: true});
    }

    if (percentHidden != 0) {
      List<int> elementsToRemove = [];
      while (topList.length - elementsToRemove.length >=
          topList.length * (percentHidden / 100)) {
        Random random = new Random();
        int elementIndex = random.nextInt(topList.length);
        while (elementsToRemove.contains(elementIndex)) {
          elementIndex = random.nextInt(topList.length);
        }
        gangGang[elementIndex][topList[elementIndex]] = false;
        elementsToRemove.add(elementIndex);
      }
      elementsToRemove.sort((b, a) => a.compareTo(b));
      print(elementsToRemove);
      for (int i in elementsToRemove) {
        bottomList.removeAt(i);
      }
    }
    checkList = List.from(bottomList);
    bottomList.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Scrollbar(
                isAlwaysShown: true,
                controller: topScrollController,
              child: ListView(
                  controller: topScrollController,
                children: [
                  Wrap(
                      children: gangGang.map((e) {
                    count++;
                    return DragTarget<String>(
                        onWillAccept: (data) => topList.contains(data),
                        onAccept: (data) {
                          if (data.toLowerCase() ==
                                  e.keys.elementAt(0).toLowerCase() ||
                              (firstLetter &&
                                  e.keys.elementAt(0)[0].toLowerCase() ==
                                      data[0].toLowerCase())) {
                            setState(() {
                              bottomList.remove(data);
                              e[data] = false;
                              checkList.remove(data);
                            });
                            if (checkList.isEmpty) {
                              if (errors < 4) {
                                widget.onAllCorrect();
                              } else {
                                widget.onLost();
                              }
                            }
                          } else {
                            errors++;
                            widget.onWrong();
                          }
                        },
                        onLeave: (data) {},
                        builder: (BuildContext context, List<String?> incoming,
                            List rejected) {
                          return InkWell(
                              child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Chip(
                                      backgroundColor: (e.containsValue(true))
                                          ? Colorthemes.backgroundlight[theme]
                                          : Colorthemes.backgroundlight[theme],
                                      shadowColor:
                                          Colorthemes.backgroundlight[theme],
                                      label: Text(
                                        e.keys.elementAt(0),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: (e.containsValue(true))
                                              ? Colorthemes.backgroundlight[theme]
                                              : Colorthemes.foreground[theme],
                                        ),
                                      ))));
                        });
                  }).toList()),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(child: Container()),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Scrollbar(

                isAlwaysShown: true,
                controller: botScrollController,
                      child: ListView(controller: botScrollController,children: [
                        Wrap(
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.end,
                          children: bottomList.map((e) {
                            Widget verseChip = Container(
                                margin: EdgeInsets.all(3),
                                child: InkWell(
                                  onTap: () {
                                    if (checkList[0].toLowerCase() ==
                                            e.toLowerCase() ||
                                        (firstLetter &&
                                            e[0].toLowerCase() ==
                                                checkList[0][0].toLowerCase())) {
                                      setState(() {
                                        bottomList.remove(checkList[0]);
                                        for (Map i in gangGang) {
                                          if (i[checkList[0]] == true) {
                                            i[checkList[0]] = false;
                                            break;
                                          }
                                        }
                                        checkList.removeAt(0);
                                      });
                                      if (checkList.isEmpty) {
                                        if (errors < 4) {
                                          widget.onAllCorrect();
                                        } else {
                                          widget.onLost();
                                        }
                                      }
                                    } else {
                                      errors++;
                                      widget.onWrong();
                                    }
                                  },
                                  child: Chip(
                                      backgroundColor:
                                          Colorthemes.backgroundlight[theme],
                                      shadowColor:
                                          Colorthemes.backgroundlight[theme],
                                      label: (!firstLetter)
                                          ? Text(e,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colorthemes
                                                      .foreground[theme]))
                                          : RichText(
                                              text: new TextSpan(
                                                // Note: Styles for TextSpans must be explicitly defined.
                                                // Child text spans will inherit styles from parent
                                                children: <TextSpan>[
                                                  new TextSpan(
                                                      text: e[0],
                                                      style: TextStyle(
                                                          color: Colorthemes
                                                                  .foreground[
                                                              theme])),
                                                  new TextSpan(
                                                      text: e.substring(1),
                                                      style: TextStyle(
                                                          color: Colorthemes
                                                                  .backgroundlight[
                                                              theme])),
                                                ],
                                              ),
                                            )),
                                ));

                            return (!firstLetter)
                                ? Draggable(
                                    data: e,
                                    childWhenDragging: Container(),
                                    feedback: Material(
                                      color: Colors.transparent,
                                      child: Chip(
                                        backgroundColor:
                                            Colorthemes.accent[theme],
                                        label: Text(
                                          e,
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 17),
                                        ),
                                      ),
                                    ),
                                    child: verseChip)
                                : verseChip;
                          }).toList(),
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
