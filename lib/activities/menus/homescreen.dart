import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/services/game_service.dart';
import 'package:bible_game/services/shared_prefs.dart';
import 'package:bible_game/ui/widgets/homescreen_drawer/homescreen_drawer.dart';
import 'package:bible_game/ui/widgets/menucard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../main.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<int> lastVerse = SharedPrefs().getSpIntList(spSelectedVerse);
    return Scaffold(
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
                    child: ColorFiltered(
                        child: Image.asset(
                          'assets/MenuDrawing.png',
                        ),
                        colorFilter: ColorFilter.mode(
                            Colorthemes.foreground[theme], BlendMode.srcIn)),
                  ),
                  Container(
                    child: Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        verticalDirection: VerticalDirection.down,
                        children: <Widget>[
                          if (lastVerse.isNotEmpty)
                            InkWell(
                              onTap: () => GameService().levelSelect(context: context),
                              child: MenuCard(titletext: 'continue'.tr()),
                            ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, bookSelectPath);
                            },
                            child: MenuCard(titletext: 'learn'.tr()),
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
