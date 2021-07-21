
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/services/shared_prefs.dart';

class GameService {
  void increaseLevel(){
    List verse = SharedPrefs().getSpIntList(spSelectedVerse);
    String verseStr = verse.toString();
    int currentVerseLevel =  SharedPrefs().getSpInt(spVerseLevel + verseStr);
    if(currentVerseLevel < 3){
      SharedPrefs().setSpInt(spVerseLevel + verseStr, currentVerseLevel+1);
      if(currentVerseLevel == 2){
        SharedPrefs().increaseSpInt(spChapterLevel + 'book' + verse[0].toString() + 'chapter' +verse[1].toString(), 1);
      }
    }
  }
}
