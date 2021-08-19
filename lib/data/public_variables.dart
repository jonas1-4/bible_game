import 'package:bible_game/services/shared_prefs.dart';
import 'package:rate_my_app/rate_my_app.dart';

int theme = 0;

dynamic bible = {};

//not sure where to put it
RateMyApp rateMyApp = RateMyApp(
  remindLaunches: 15,
  preferencesPrefix: 'rateMyApp_',
  minDays: 5,
  minLaunches: 40,
);

//SharedPrefs const

//saving them as const here to avoid misspelling or 
//dublicate errors

const String spLanguage                 = 'language';
const String spLanguageIndex            = 'languageIndex';
const String spBibleVersionIndex        = 'bibleVersionIndex';
const String spBibleVersionName         = 'bibleVersionName';
const String spBibleVersionJson         = 'bibleVersionJson';
const String spVerseLevel               = 'verseLevel';
const String spChapterLevel             = 'chapterLevel';  
const String spSelectedVerse            = 'selectedVerse';
