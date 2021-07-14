import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool timer = false;


double percent = 0;
String animationname = 'Super2';
List<String> BibleversString = ['fehler'];

class EndScreen extends StatefulWidget {
  @override
  _EndScreenState createState() => _EndScreenState();
}

bool jobromode = false;

class _EndScreenState extends State<EndScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor:Colorthemes.backgroundlight[theme],
          centerTitle: true,
          title: Title(
              color:Colorthemes.foreground[theme],
              child: Text(
                'Bible Trainer',
                style: TextStyle(color:Colorthemes.foreground[theme],),
              )),
        ),
        body: Container(
          color:Colorthemes.background[theme],
          child: SizedBox(
            height: double.infinity,
            child: Container(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 30,
                    left: 100,
                    child: Container(
                      color:Colorthemes.background[theme],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              //getVers(BibleversString, false);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.replay,
                                  color:Colorthemes.foreground[theme],
                                ),
                                Container(width: 20),
                                Text(
                                  'Wiederholen',
                                  style: TextStyle(color:Colorthemes.foreground[theme],),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 40),
                          if (jobromode)
                            InkWell(
                              onTap: () {
                               // getVers(BibleversString, true);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.flight_takeoff,
                                      color:Colorthemes.foreground[theme],),
                                  Container(width: 20),
                                  Text(
                                    'Nächster Vers',
                                    style: TextStyle(color:Colorthemes.foreground[theme],),
                                  )
                                ],
                              ),
                            )
                          else
                            InkWell(
                              onTap: () {
                                //getVers(BibleversString, true);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.arrow_forward,
                                      color:Colorthemes.foreground[theme],),
                                  Container(width: 20),
                                  Text(
                                    'Nächster Vers',
                                    style: TextStyle(color:Colorthemes.foreground[theme],),
                                  )
                                ],
                              ),
                            ),
                          SizedBox(height: 40),
                          InkWell(
                            onTap: () => null,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(Icons.home, color:Colorthemes.foreground[theme],),
                                Container(width: 20),
                                Text(
                                  'Zum Homescreen',
                                  style: TextStyle(color:Colorthemes.foreground[theme],),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          Row(
                            children: <Widget>[
                              CupertinoSwitch(
                                value: jobromode,
                                activeColor:Colorthemes.background[theme],
                                onChanged: (bool) {
                                  setState(() {
                                    jobromode = !jobromode;
                                    if (jobromode) {
                                      animationname = 'Super!';
                                    } else {
                                      animationname = 'Super2';
                                    }
                                  });
                                },
                              ),
                              Text(
                                'JoBromode',
                                style: TextStyle(color:Colorthemes.background[theme],),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Align(
                  //  alignment: Alignment.topCenter,
                  //  child: SafeArea(
                  //    child: Column(
                  //      children: <Widget>[
                  //        SizedBox(
                  //          width: double.maxFinite,
                  //          child: Container(
                  //            height: 150,
                  //            child: FlareActor(
                  //              'assets/EndScreenAnimation.flr',
                  //              animation: animationname,
                  //              fit: BoxFit.contain,
                  //            ),
                  //          ),
                  //        ),
                  //      ],
                  //    ),
                  //  ),
                  //),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

