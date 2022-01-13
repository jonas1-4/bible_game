import 'package:bible_game/activities/menus/chapter_select.dart';
import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/services/bible.dart';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
//Thanks to (List Search): https://www.kindacode.com/article/how-to-create-a-filter-search-listview-in-flutter/

class BookSelect extends StatefulWidget {
  @override
  _BookSelectState createState() => _BookSelectState();
}

class _BookSelectState extends State<BookSelect> {
  List<String> _books = Bible().getBookList();
  List<String> _booksResult = [];

  @override
  initState() {
    // at the beginning, all users are shown
    _booksResult = _books;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<String> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _books;
    } else {
      results = _books
          .where((user) =>
              user.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _booksResult = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colorthemes.background[theme],
          backgroundColor: Colorthemes.backgroundlight[theme],
          title: Title(
              color: Colors.black,
              child: Text(
                'book'.tr(),
                style: TextStyle(color: Colorthemes.foreground[theme]),
              )),
          centerTitle: true,
        ),
        body: LayoutBuilder(builder: (context, constrains) {
          return Container(
              color: Colorthemes.background[theme],
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      onChanged: (value) => _runFilter(value),
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colorthemes.accent[theme])),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colorthemes.backgroundlight[theme])),
                          focusColor: Colorthemes.accent[theme],
                          hoverColor: Colorthemes.accent[theme],
                          labelText: 'search'.tr(),
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colorthemes.accent[theme],
                          ),
                          labelStyle:
                              TextStyle(color: Colorthemes.accent[theme])),
                      style: TextStyle(color: Colorthemes.foreground[theme]),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                        itemCount: _booksResult.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Column(
                              children: [
                                if (index != 0)
                                  Divider(
                                      color:
                                          Colorthemes.backgroundlight[theme]),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        primary:
                                            Colorthemes.backgroundlight[theme]),
                                    onPressed: () {
                                      
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new ChapterSelect(
                                                      book: _books.indexOf(_booksResult[index]))));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(_booksResult[index],
                                            style: TextStyle(
                                                color: Colorthemes
                                                    .foreground[theme],
                                                fontSize: 16)),
                                      ],
                                    )),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ));
        }));
  }
}
