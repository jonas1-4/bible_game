import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/ui/widgets/menucard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../main.dart';

class Homescreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colorthemes.foreground[theme],
          title: Title(
              color: Colors.black,
              child: Text(
                'Bibel-Lehrer',
                style: TextStyle(color: Colorthemes.background[theme]),
              )),
          centerTitle: true,
        ),
        body: LayoutBuilder(
          builder: (context, constrains) {
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
                             // InkWell(
                             //   onTap: () {},
                             //   child: MenuCard(titletext: 'Fortfahren'),
                             // ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, verseSelectPath);
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
          }
        ));
  }
}
