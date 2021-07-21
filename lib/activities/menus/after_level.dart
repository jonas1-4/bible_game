import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/main.dart';
import 'package:bible_game/services/shared_prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EndScreen extends StatefulWidget {
  @override
  _EndScreenState createState() => _EndScreenState();
}

class _EndScreenState extends State<EndScreen> {
  int stars = SharedPrefs().getSpInt(
      spVerseLevel + SharedPrefs().getSpIntList(spSelectedVerse).toString());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colorthemes.backgroundlight[theme],
          centerTitle: true,
          title: Title(
              color: Colorthemes.foreground[theme],
              child: Text(
                'Bible Trainer',
                style: TextStyle(
                  color: Colorthemes.foreground[theme],
                ),
              )),
        ),
        body: Container(
          color: Colorthemes.background[theme],
          child: Column(children: [
            SizedBox(height: 25),
            Row(children: [
              Expanded(flex: 2, child: Container()),
              Expanded(
                flex: 6,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: (stars >= 0)
                      ? Icon(Icons.star,
                          size: 50, color: Colorthemes.accent[theme])
                      : Icon(Icons.star_outline,
                          color: Colorthemes.accent[theme]),
                ),
              ),
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 6,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: (stars >= 0)
                      ? Icon(Icons.star,
                          size: 50, color: Colorthemes.accent[theme])
                      : Icon(Icons.star_outline,
                          color: Colorthemes.accent[theme]),
                ),
              ),
              Expanded(child: Container()),
              Expanded(
                flex: 6,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: (stars >= 0)
                      ? Icon(Icons.star,
                          size: 50, color: Colorthemes.accent[theme])
                      : Icon(Icons.star_outline,
                          color: Colorthemes.accent[theme]),
                ),
              ),
              Expanded(flex: 2, child: Container()),
            ]),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text('Great',
                          style:
                              TextStyle(color: Colorthemes.foreground[theme]))),
                )
              ]),
            ),
            Expanded(child: Container()),
            Row(children: [
              Expanded(
                flex: 1,
                child: FittedBox(
                  child: IconButton(
                    onPressed: () =>
                        Navigator.popAndPushNamed(context, homescreenPath),
                    icon:
                        Icon(Icons.home, color: Colorthemes.foreground[theme]),
                  ),
                ),
              ),
              Expanded(child: Container()),
              Expanded(
                flex: 1,
                child: FittedBox(
                  child: IconButton(
                    onPressed: () =>
                        Navigator.popAndPushNamed(context, homescreenPath),
                    icon: Icon(Icons.arrow_right_alt,
                        color: Colorthemes.foreground[theme]),
                  ),
                ),
              ),
            ])
          ]),
        ),
      ),
    );
  }
}
