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
  
  //returns an ordered and an unordered List of an Splitted Bible verse
  List<List<String>> getSplitVerse(int book, int chapter, int verseString){
    // cant as
    List<String> verseOrdered = bible[book]['chapters'][chapter][verseString].split(' ');
    List<String> verse = bible[book]['chapters'][chapter][verseString].split(' ')
    ..shuffle();
    return [verseOrdered, verse,];
  }
}
