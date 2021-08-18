import 'package:bible_game/activities/games/verse_order_game.dart';
import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/services/bible.dart';
import 'package:bible_game/services/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sizer/sizer.dart';

import 'after_level.dart';
import 'homescreen.dart';

class VerseDisplay extends StatefulWidget {
  @override
  _VerseDisplayState createState() => _VerseDisplayState();
}

class _VerseDisplayState extends State<VerseDisplay> {
  List<int> selectedVerse = SharedPrefs().getSpIntList(spSelectedVerse);

  @override
  Widget build(BuildContext context) {
    String verse =
        Bible().getVerse(selectedVerse[0], selectedVerse[1], selectedVerse[2]);

    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colorthemes.background[theme],
          backgroundColor: Colorthemes.backgroundlight[theme],
          title: Title(
              color: Colors.black,
              child: Text(
                'verse'.tr(),
              )),
          centerTitle: true,
        ),
        backgroundColor: Colorthemes.background[theme],
        body: SizedBox.expand(
          child: GestureDetector(
            onHorizontalDragEnd: (details) {
              // Swiping in right direction.
              if (details.primaryVelocity! > 4) {}

              // Swiping in left direction.
              if (details.primaryVelocity! < 4) {
                setState(() {
                  selectedVerse = Bible().nextVerse(selectedVerse);
                });
                print(selectedVerse);
              }
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(50, 20, 50, 50),
              child: Column(
                children: [
                  Text(
                    verse,
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  Expanded(child: Container()),
                  Row(children: [
                    IconButtonText(
                        icon: Icons.home,
                        text: 'toHomescreen'.tr(),
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Homescreen()))),
                    Expanded(child: Container()),
                    IconButtonText(
                        icon: Icons.navigate_next,
                        text: 'learnVerse'.tr(),
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VerseOrderGame(level: 0)))),
                  ])
                ],
              ),
            ),
          ),
        ));
  }
}
