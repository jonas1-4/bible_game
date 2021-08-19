import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/services/game_service.dart';
import 'package:bible_game/services/shared_prefs.dart';
import 'package:bible_game/ui/widgets/homescreen_drawer/homescreen_drawer.dart';
import 'package:bible_game/ui/widgets/menucard.dart';
import 'package:bible_game/ui/widgets/photo_hero.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

import 'book_select.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<int> lastVerse = SharedPrefs().getSpIntList(spSelectedVerse);
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colorthemes.background[theme],
          iconTheme: IconThemeData(color: Colorthemes.foreground[theme]),
          backgroundColor: Colorthemes.backgroundlight[theme],
          title: Title(
              color: Colors.black,
              child: Text(
                'bibleGame'.tr(),
                style: TextStyle(color: Colorthemes.foreground[theme]),
              )),
          centerTitle: true,
        ),
        drawer: HomeScreenDrawer(setParentState: refresh),
        body: LayoutBuilder(builder: (context, constrains) {
          return Container(
            height: constrains.maxHeight,
            color: Colorthemes.background[theme],
            child: Padding(
              padding: EdgeInsets.fromLTRB(50, 20, 50, 50),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: PhotoHero(
                      width: 300,
                      photo: 'assets/images/MenuDrawing.png',
                    ),
                  ),
                  Container(
                    child: Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        verticalDirection: VerticalDirection.down,
                        children: <Widget>[
                          if (lastVerse.isNotEmpty)
                            MenuCard(
                              titletext: 'continue'.tr(),
                              onTap: () =>
                                  GameService().levelSelect(context: context),
                            ),
                          MenuCard(
                            titletext: 'learn'.tr(),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookSelect())),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
