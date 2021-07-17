import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/services/shared_prefs.dart';
import 'package:bible_game/ui/widgets/homescreen_drawer.dart';
import 'package:bible_game/ui/widgets/menucard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../main.dart';
import '../game.dart';

class Homescreen extends StatefulWidget {

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  void refresh(){
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<int> lastVerse = SharedPrefs().getSpIntList(spLastVerse);
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colorthemes.background[theme],
          backgroundColor: Colorthemes.backgroundlight[theme],
          title: Title(
              color: Colors.black,
              child: Text(
                'Bibel-Lehrer',
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
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            new RememberingGame(
                                              book: lastVerse[0],
                                              chapter: lastVerse[1],
                                              verse: lastVerse[2],
                                            )));
                              },
                              child: MenuCard(titletext: 'Fortfahren'),
                            ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, bookSelectPath);
                            },
                            child: MenuCard(titletext: 'Lernen'),
                          ),
                          InkWell(
                              onTap: () {},
                              child: MenuCard(titletext: 'Wettbewerb')),
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
