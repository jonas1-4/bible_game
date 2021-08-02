import 'dart:math';

import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:flutter/material.dart';

class OrderChipsGame extends StatefulWidget {
  const OrderChipsGame({
    Key? key,
    required this.itemList,
    required this.onWrong,
    required this.onAllCorrect,
    this.percentHidden = 0,
    this.firstLetter = false,
  }) : super(key: key);

  //unorderedVerses   = bottom words shuffled
  //orderedVerses     = words in correctOrder
  //correctVerses     = words which are accepted/pressed
  //noDublicateVerses = words in correctOrder but without dublicates
  //errors            = times a wrong word was clicked/number of hearts
  final List<String> itemList;
  final Function onWrong;
  final Function onAllCorrect;
  final int percentHidden;
  final bool firstLetter;

  @override
  _OrderChipsGameState createState() => _OrderChipsGameState();
}

class _OrderChipsGameState extends State<OrderChipsGame> {
  List<String> bottomList = [], topList = [], checkList = [];
  int errors = 0, count = 0, percentHidden = 0;
  bool firstLetter = false;
  List<Map<String, bool>> gangGang = [new Map<String, bool>()];

  @override
  void initState() {
    super.initState();
    percentHidden = widget.percentHidden;
    topList = widget.itemList;
    firstLetter = widget.firstLetter;
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
    print(checkList);
    bottomList.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Wrap(
                children: gangGang.map((e) {
              return InkWell(
                  child: Container(
                      margin: EdgeInsets.all(3),
                      child: Chip(
                          backgroundColor: (e.containsValue(true))
                              ? Colorthemes.backgroundlight[theme]
                              : Colorthemes.backgroundlight[theme],
                          shadowColor: Colorthemes.backgroundlight[theme],
                          label: Text(
                            e.keys.elementAt(0),
                            style: TextStyle(
                              fontSize: 16,
                              color: (e.containsValue(true))
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
                  children: bottomList.map((e) {
                    return InkWell(
                      child: Container(
                          margin: EdgeInsets.all(3),
                          child: InkWell(
                            onTap: () {
                              if (checkList[0] == e ||
                                  (firstLetter && e[0] == checkList[0][0])) {
                                setState(() {
                                  bottomList.remove(checkList[0]);
                                  for (Map i in gangGang) {
                                    if (i[checkList[0]] == true) {
                                      i[checkList[0]] = false;
                                      break;
                                    }
                                  }
                                  checkList.removeAt(0);
                                  print(gangGang);
                                });
                                if (checkList.isEmpty) {
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
                                backgroundColor:
                                    Colorthemes.backgroundlight[theme],
                                shadowColor: Colorthemes.backgroundlight[theme],
                                label: (!firstLetter)
                                    ? Text(e,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                Colorthemes.foreground[theme]))
                                    : RichText(
                                        text: new TextSpan(
                                          // Note: Styles for TextSpans must be explicitly defined.
                                          // Child text spans will inherit styles from parent
                                          children: <TextSpan>[
                                            new TextSpan(
                                                text: e[0],
                                                style: TextStyle(
                                                    color: Colorthemes
                                                        .foreground[theme])),
                                            new TextSpan(
                                                text: e.substring(1),
                                                style: TextStyle(
                                                    color: Colorthemes
                                                            .backgroundlight[
                                                        theme])),
                                          ],
                                        ),
                                      )),
                          )),
                    );
                  }).toList(),
                ),
              )),
        ],
      ),
    );
  }
}
