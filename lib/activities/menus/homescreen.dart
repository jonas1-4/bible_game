import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/ui/widgets/menucard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<String> biblevers = ['Fehler'];

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
        body: Container(
          color: Colorthemes.background[theme],
          child: Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Container(margin: EdgeInsets.all(35),
                  child: ColorFiltered(
                      child: Image.asset(
                        'assets/MenuDrawing.png',
                        fit: BoxFit.fill
                      ),
                      colorFilter: ColorFilter.mode(
                          Colorthemes.foreground[theme], BlendMode.srcIn)),
                ),
                SizedBox(height: 75),
                Container(
                  child: Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      verticalDirection: VerticalDirection.down,
                      children: <Widget>[
                        if (biblevers[0] != 'fehler')
                          InkWell(
                            onTap: () {},
                            child: MenuCard(titletext: 'Fortfahren'),
                          ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/versselect');
                          },
                          child: MenuCard(titletext: 'Lernen'),
                        ),
                        InkWell(
                            onTap: () {},
                            child: MenuCard(titletext: 'Wettbewerb')),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
