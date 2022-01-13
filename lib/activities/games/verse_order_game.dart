import 'package:bible_game/activities/menus/after_level.dart';
import 'package:bible_game/activities/menus/verse_select.dart';
import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/services/bible.dart';
import 'package:bible_game/services/game_service.dart';
import 'package:bible_game/services/shared_prefs.dart';
import 'package:bible_game/ui/icon_row.dart';
import 'package:bible_game/ui/widgets/order_chips_game.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../main.dart';

class VerseOrderGame extends StatefulWidget {
  VerseOrderGame({required this.level});
  final int level;

  @override
  _VerseOrderGameState createState() => _VerseOrderGameState();
}

class _VerseOrderGameState extends State<VerseOrderGame> {
  int errors = 0;
  List<String> verse = [];
  List<int> selectedVerse = SharedPrefs().getSpIntList(spSelectedVerse);

  @override
  void initState() {
    super.initState();
    verse = Bible()
        .getSplitVerse(selectedVerse[0], selectedVerse[1], selectedVerse[2]);
  }

  void madeError() {
    setState(() {
      errors++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //have to pop so the lastverse/continue Button updates
        Navigator.popAndPushNamed(context, homescreenPath);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colorthemes.background[theme],
          backgroundColor: Colorthemes.backgroundlight[theme],
          title: Title(
              color: Colors.black,
              child: Text(
                'bibleGame'.tr(),
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  (errors < 4)
                      ? IconRow(
                          condition: (int condition, int i) => condition <= i,
                          conditionInt: errors,
                          iconIf: Icons.favorite,
                          leftRightMiddle: 0,
                          iconIfNot: Icons.favorite_border)
                      : Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Icon(Icons.favorite_border,
                              color: Colorthemes.background[theme], size: 25),
                        ),
                  SizedBox(height: 20),
                  OrderChipsGame(
                      level: widget.level,
                      onLost: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new VerseSelect(
                                    book: selectedVerse[0],
                                    chapter: selectedVerse[1])));
                      },
                      itemList: verse,
                      onWrong: madeError,
                      onAllCorrect: () {
                        GameService().increaseLevel();
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new EndScreen()));
                      },
                      percentHidden: 40),
                  SizedBox(height: 20),
                  Text(
                    '${Bible().getVerseLocationAbb(selectedVerse)}',
                    style: TextStyle(color: Colorthemes.foreground[theme]),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
