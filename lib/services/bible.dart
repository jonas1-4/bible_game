import 'package:bible_game/data/public_variables.dart';

class Bible {

  ///returns an ordered List of all Bible book names
  List<String> getBookList() {
    List<String> books = [];
    for (int i = 0; i < bible.length; i++) {
      books.add(bible[i]['name']);
    }
    return books;
  }

  ///returns an ordered List of an Splitted Bible verse
  List<String> getSplitVerse(int book, int chapter, int verse) {
    List<String> verseList = bible[book]['chapters'][chapter][verse].split(' ');
    return verseList;
  }
  
  ///returns the verse location ?dont know how to call this
  String getVerseLocation(List<int> verse){
    return '${bible[verse[0]]['name']} ${verse[1] + 1}, ${verse[2] + 1}';
  }
    
  ///returns the abbreviation of the verse location
  String getVerseLocationAbb(List<int> verse){
    return '${bible[verse[0]]['abbrev'].toUpperCase()} ${verse[1] + 1}, ${verse[2] + 1}';
  }

  ///returns a Verse
  String getVerse(int book, int chapter, int verseString) {
    String verse = bible[book]['chapters'][chapter][verseString];
    return verse;
  }

  ///returns the verse following the currentVerse
  List<int> getFollowingVerse(List<int> currentVerse) {
    int book = currentVerse[0],
        chapter = currentVerse[1],
        verse = currentVerse[2];
    print('${bible[book]['chapters'][chapter].length}  || $verse');

    if (bible[book]['chapters'][chapter].length - 1 > verse) {
      verse++;
    } else {
      verse = 0;
      chapter++;
      if (bible[book]['chapters'].length - 1 < chapter) {
        chapter = 0;
        book++;
        if (bible.length - 1 < book) {
          book = 0;
        }
      }
    }
    return [book, chapter, verse];
  }

}
