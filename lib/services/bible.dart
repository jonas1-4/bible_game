import 'package:bible_game/data/public_variables.dart';

class Bible {
  List<String> getBookList() {
    List<String> books = [];
    for (int i = 0; i < bible.length; i++) {
      books.add(bible[i]['name']);
    }
    return books;
  }
}
