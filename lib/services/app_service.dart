import 'package:bible_game/data/public_variables.dart';
import 'package:easy_localization/easy_localization.dart';

import 'jsons.dart';
import 'shared_prefs.dart';

class AppService {
  bibleGameInit() async {
    await SharedPrefs().init();
    await EasyLocalization.ensureInitialized();
    await rateMyApp.init();
    // TODO Detect Language and set everything automatik

    if (SharedPrefs().getSpStr(spBibleVersionJson).isEmpty) {
      SharedPrefs().setSpStr(spBibleVersionJson, 'en_bbe');
      SharedPrefs().setSpStr(spLanguage, 'English');
      SharedPrefs().setSpInt(spLanguageIndex, 4);
      SharedPrefs().setSpStr(spBibleVersionName, 'Basic English');
      SharedPrefs().setSpInt(spBibleVersionIndex, 0);
    }

    bible = await JsonService().getJson(
        'assets/json/${SharedPrefs().getSpStr(spBibleVersionJson)}.json');
  }
}
