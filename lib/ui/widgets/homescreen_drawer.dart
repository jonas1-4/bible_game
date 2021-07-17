import 'dart:io';

import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/services/jsons.dart';
import 'package:bible_game/services/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreenDrawer extends StatefulWidget {
  final Function setParentState;

  HomeScreenDrawer({
    required this.setParentState,
  });

  @override
  _HomeScreenDrawerState createState() => _HomeScreenDrawerState();
}

// TODO Settings Tab to change display name or profile picture delete acc etc

class _HomeScreenDrawerState extends State<HomeScreenDrawer> {
  Directory bibles = Directory('assets/json');
  List<String> translations = [];

  getbibles() async {
    dynamic translationsJson = await JsonService().getJson('assets/json/index.json');
    print(translationsJson);
    for(var i in translationsJson){
      translations.add(i['language']);
    }
    print(translations);
    setState(() {});
  }

  @override 
  void initState() {
    getbibles();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return Drawer(
        child: Container(
            color: Colorthemes.background[theme],
            child: SafeArea(
                child: Column(children: [
              Expanded(
                child: ListView(padding: EdgeInsets.zero, children: [
                  DrawerHeader(
                    child: ColorFiltered(
                        child: Image.asset('assets/MenuDrawing.png',
                            width: 100, height: 100),
                        colorFilter: ColorFilter.mode(
                            Colorthemes.foreground[theme], BlendMode.srcIn)),
                    decoration:
                        BoxDecoration(color: Colorthemes.background[theme]),
                  ),
                  if(translations.isNotEmpty)  DropdownButton<String>(
                      hint: Text(currentTranslation),
                      
                      dropdownColor: Colorthemes.backgroundlight[theme],
                    items: translations.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  )
                ]),
              )
            ]))));
  }

  //_launchPatreon() async {
  //  const url = 'https://www.patreon.com/fractalapps';
  //  if (await canLaunch(url)) {
  //    await launch(url);
  //  } else {
  //    throw 'Could not launch $url';
  //  }
  //}
}
