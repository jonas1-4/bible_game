import 'package:bible_game/activities/games/verse_order_game.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/services/shared_prefs.dart';
import 'package:flutter/material.dart';

Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: const Text('Popup example'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Hello"),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
    ],
  );
}

class GameService {
  void levelSelect({required BuildContext context, bool replay = false}) {
    List verse = SharedPrefs().getSpIntList(spSelectedVerse);
    String verseStr = verse.toString();
    int currentVerseLevel = SharedPrefs().getSpInt(spVerseLevel + verseStr);
    if (replay) {
      currentVerseLevel--;
      SharedPrefs().setSpInt(spVerseLevel + verseStr, currentVerseLevel);
    }
    if (currentVerseLevel == 3) {
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog(context),
      );
    }else{

    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new VerseOrderGame(
                  level: currentVerseLevel,
                )));
    }
  }

  void nextLevel(BuildContext context) {
    List verseList = SharedPrefs().getSpIntList(spSelectedVerse);
    String verseStr = verseList.toString();
    int currentVerseLevel = SharedPrefs().getSpInt(spVerseLevel + verseStr);
    if (currentVerseLevel < 3) {
      levelSelect(context: context);
      return;
    }
    int book = verseList[0], chapter = verseList[1], verse = verseList[2];

    if (bible[book]['chapters'][chapter][verse].length - 1 > verse) {
      verse++;
    } else {
      verse = 0;
      chapter++;
      if (bible[book]['chapters'][chapter].length - 1 < chapter) {
        chapter = 0;
        book++;
      }
      if (bible[book]['chapters'].length - 1 < book) {
        book = 1;
      }
    }
    SharedPrefs().setSpIntList(spSelectedVerse, [book, chapter, verse]);
    levelSelect(context: context);
  }

  void increaseLevel() {
    List verse = SharedPrefs().getSpIntList(spSelectedVerse);
    String verseStr = verse.toString();
    int currentVerseLevel = SharedPrefs().getSpInt(spVerseLevel + verseStr);
    if (currentVerseLevel < 3) {
      SharedPrefs().setSpInt(spVerseLevel + verseStr, currentVerseLevel + 1);
      if (currentVerseLevel == 2) {
        SharedPrefs().increaseSpInt(
            spChapterLevel +
                'book' +
                verse[0].toString() +
                'chapter' +
                verse[1].toString(),
            1);
      }
    }
  }
}
