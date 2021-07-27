import 'package:bible_game/data/public_variables.dart';

class Bible {

  //returns an ordered List of all Bible book names
  List<String> getBookList() {
    List<String> books = [];
    for (int i = 0; i < bible.length; i++) {
      books.add(bible[i]['name']);
    }
    return books;
  }
  
  //returns an ordered List of an Splitted Bible verse
  List<String> getSplitVerse(int book, int chapter, int verseString){
    List<String> verse= bible[book]['chapters'][chapter][verseString].split(' ');
    return verse;
  }
}
