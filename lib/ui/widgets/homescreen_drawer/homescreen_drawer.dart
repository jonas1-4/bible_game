import 'dart:io';

import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/services/jsons.dart';
import 'package:bible_game/services/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_donation_buttons/donationButtons/paypalButton.dart';

import 'drawer_dropdown.dart';

import 'package:easy_localization/easy_localization.dart';

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
  List<dynamic> indexJson = [];
  List<String> translations = [];
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
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column( children: [
                    DrawerHeader(
                      child: ColorFiltered(
                          child: Image.asset('assets/MenuDrawing.png',
                              width: 100, height: 100),
                          colorFilter: ColorFilter.mode(
                              Colorthemes.foreground[theme], BlendMode.srcIn)),
                      decoration:
                          BoxDecoration(color: Colorthemes.background[theme], boxShadow: []),
                    ),
                    DrawerDropDown(
                        name: 'language'.tr(),
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
                    DrawerDropDown(
                        name: 'translation'.tr(),
                        hint: currentBible,
                        items: indexJson[SharedPrefs().getSpInt(spLanguageIndex)]
                            ['versions']??[],
                        onTap: (int index, String value) async {
                          SharedPrefs().setSpInt(spBibleVersionIndex, index);
                          SharedPrefs().setSpStr(spBibleVersionName,
                              indexJson[SharedPrefs().getSpInt(spLanguageIndex)]['versions'][index]['name']);
                          SharedPrefs().setSpStr(spBibleVersionJson,
                              indexJson[SharedPrefs().getSpInt(spLanguageIndex)]['versions'][index]['abbreviation']);
                          bible = await JsonService().getJson(
                              'assets/json/${SharedPrefs().getSpStr(spBibleVersionJson)}.json');
                          print(index.toString()+value);
                          setState(() {});
                        }),
                    Expanded(child: Container()),
                    PayPalButton(paypalButtonId: "3JTCBDL46K7VL", donationText: 'donatePP'.tr(),),
                  ]),
                ),
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


                                //(translationisJson[index]['versions']
                                //            .length <
                                //        2)
                                //    ?                                   : DropdownButton(
                                //        items: translationsJson[index]['versions']
                                //            .map((e) {
                                //        return DropdownMenuItem(
                                //            value: e[''], child: Text(e['name']));
                                //      }).toList()),
