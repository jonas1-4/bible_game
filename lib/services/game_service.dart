import 'package:bible_game/activities/games/verse_order_game.dart';
import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/services/shared_prefs.dart';
import 'package:flutter/material.dart';

Widget _buildPopupDialog(BuildContext context) {
  void playLevel(int level) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new VerseOrderGame(
                  level: level,
                )));
  }

  List<Widget> levels = [];
  for (int i = 0; i < 3; i++) {
    levels.add(
      InkWell(
        onTap: () => playLevel(i),
        child: Expanded(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Level ${i+1}",
                style: TextStyle(color: Colorthemes.foreground[theme]),
              ),
            ],
          ),
        ),
      ),
    );
    levels.add(Divider(color: Colorthemes.accentlight[theme],));
  }

  return new AlertDialog(
    backgroundColor: Colorthemes.background[theme],
    titleTextStyle: TextStyle(color: Colorthemes.foreground[theme]),
    title: const Text('Select Level'),
    content: Container(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: levels,
      ),
    ),
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
    } else {
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
