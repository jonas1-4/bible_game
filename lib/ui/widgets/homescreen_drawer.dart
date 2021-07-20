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
  List<dynamic> indexJson = [];
  int index = -1;

  getbibles() async {
    indexJson = await JsonService().getJson('assets/json/index.json');
    for (var i in indexJson) {
      translations.add(i['language']);
    }
    setState(() {});
  }

  @override
  void initState() {
    getbibles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String currentTranslation = SharedPrefs().getSpStr(spLanguage);
    String currentBible = SharedPrefs().getSpStr(spBibleVersionName);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return Drawer(
        child: Container(
            color: Colorthemes.background[theme],
            child: SafeArea(
                child: Column(children: [
              Expanded(
                child: ListView(padding: EdgeInsets.all(10), children: [
                  DrawerHeader(
                    child: ColorFiltered(
                        child: Image.asset('assets/MenuDrawing.png',
                            width: 100, height: 100),
                        colorFilter: ColorFilter.mode(
                            Colorthemes.foreground[theme], BlendMode.srcIn)),
                    decoration:
                        BoxDecoration(color: Colorthemes.background[theme]),
                  ),
                  DrawerDropDown(
                      hint: currentTranslation,
                      items: translations,
                      onTap: (int index, String value) async {
                        SharedPrefs().setSpStr(spLanguage, value);
                        SharedPrefs().setSpInt(spLanguageIndex, index);
                        SharedPrefs().setSpInt(spBibleVersionIndex, 0);
                        SharedPrefs().setSpStr(spBibleVersionName,
                            indexJson[index]['versions'][0]['name']);
                        SharedPrefs().setSpStr(spBibleVersionJson,
                            indexJson[index]['versions'][0]['abbreviation']);
                        bible = await JsonService().getJson(
                            'assets/json/${SharedPrefs().getSpStr(spBibleVersionJson)}.json');
                        print(index.toString()+value);
                        setState(() {});
                      }),
                  //DrawerDropDown(
                  //    hint: currentBible,
                  //    items: indexJson[SharedPrefs().getSpInt(spLanguageIndex)]
                  //        ['versions'],
                  //    spString: spBibleVersionName,
                  //    spInt: spBibleVersionIndex,
                  //    bibleJson: indexJson),
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

class DrawerDropDown extends StatelessWidget {
  const DrawerDropDown({
    Key? key,
    required this.hint,
    required this.items,
    required this.onTap,
  }) : super(key: key);

  final String hint;
  final List<String> items;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('Bible Version:',
            style: TextStyle(color: Colorthemes.foreground[theme])),
        Expanded(child: Container()),
        (items.length > 1)
            ? DropdownButton<String>(
                underline: Container(),
                menuMaxHeight: 300,
                hint: Text(hint,
                    style: TextStyle(color: Colorthemes.foreground[theme])),
                dropdownColor: Colorthemes.backgroundlight[theme],
                items: items.map((String value) {
                  return DropdownMenuItem<String>(
                      onTap: () {
                        onTap(items.indexOf(value), value);
                      },
                      value: value,
                      child: Text(value,
                          style:
                              TextStyle(color: Colorthemes.foreground[theme])));
                }).toList(),
                onChanged: (_) {},
              )
            : Text(hint),
      ],
    );
  }
}


                                //(translationisJson[index]['versions']
                                //            .length <
                                //        2)
                                //    ?                                   : DropdownButton(
                                //        items: translationsJson[index]['versions']
                                //            .map((e) {
                                //        return DropdownMenuItem(
                                //            value: e[''], child: Text(e['name']));
                                //      }).toList()),
