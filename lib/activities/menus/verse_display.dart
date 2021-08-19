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
              behavior: HitTestBehavior.opaque,
            onHorizontalDragEnd: (details) {
              // Swiping in right direction.
              if (details.velocity.pixelsPerSecond.dx > 250) {
                setState(() {
                  selectedVerse = Bible().getPreviousVerse(selectedVerse);
                });
              }

              // Swiping in left direction.
              if (details.velocity.pixelsPerSecond.dx < -250) {
                setState(() {
                  selectedVerse = Bible().getFollowingVerse(selectedVerse);
                });
              }
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(50, 20, 50, 50),
              child: Column(
                children: [
                  Card(
                      color: Colorthemes.backgroundlight[theme],
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: [
                          Text(
                            verse,
                            style: TextStyle(fontSize: 17.sp),
                          ),
                          Row(children:[ Text('${Bible().getVerseLocation(selectedVerse)}', style: TextStyle(fontSize:  10.sp))], mainAxisAlignment: MainAxisAlignment.end),
                        ],
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Row(children: [
                    IconButtonText(
                        size: 14.sp,
                        icon: Icons.home,
                        text: 'toHomescreen'.tr(),
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Homescreen()))),
                    Expanded(child: Container()),
                    IconButtonText(
                        size: 14.sp,
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
