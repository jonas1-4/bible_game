import 'package:bible_game/activities/games/level_one.dart';
import 'package:bible_game/activities/games/level_three.dart';
import 'package:bible_game/activities/games/level_two.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/services/shared_prefs.dart';
import 'package:flutter/material.dart';

class GameService {
  void levelSelect({required BuildContext context, bool replay = false}) {
    List verse = SharedPrefs().getSpIntList(spSelectedVerse);
    String verseStr = verse.toString();
    int currentVerseLevel = SharedPrefs().getSpInt(spVerseLevel + verseStr);
    if (replay) currentVerseLevel--;

    switch (currentVerseLevel) {
      case 0:
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new GameLevelOne()));
        break;
      case 1:
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new GameLevelTwo()));
        break;
      case 2:
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new GameLevelThree()));
        break;
      default:
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new GameLevelThree()));
        break;
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
