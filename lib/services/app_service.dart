import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/services/bible.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'jsons.dart';
import 'shared_prefs.dart';

class AppService {
  bibleGameInit(BuildContext context) async {
    // TODO SharedPrefs should set automaticly

    if (SharedPrefs().getSpStr(spBibleVersionJson).isEmpty) {

      switch (context.locale.languageCode) {
        case 'de':
        {
            SharedPrefs().setSpStr(spLanguage, 'German');
            SharedPrefs().setSpInt(spLanguageIndex, 2);
            SharedPrefs().setSpStr(spBibleVersionName, 'Schlachter');
            SharedPrefs().setSpInt(spBibleVersionIndex, 0);
            SharedPrefs().setSpStr(spBibleVersionJson, 'de_schlachter');
        }
          break;
        default:
          {
            SharedPrefs().setSpStr(spLanguage, 'English');
            SharedPrefs().setSpInt(spLanguageIndex, 4);
            SharedPrefs().setSpStr(spBibleVersionName, 'Basic English');
            SharedPrefs().setSpInt(spBibleVersionIndex, 0);
            SharedPrefs().setSpStr(spBibleVersionJson, 'en_bbe');
          }
      }
    }

    bible = await JsonService().getJson(
        'assets/json/${SharedPrefs().getSpStr(spBibleVersionJson)}.json');
    return true;
  }
}
