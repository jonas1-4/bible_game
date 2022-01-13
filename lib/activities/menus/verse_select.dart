import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/services/game_service.dart';
import 'package:bible_game/services/shared_prefs.dart';
import 'package:bible_game/ui/icon_row.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class VerseSelect extends StatelessWidget {
  VerseSelect({required this.book, required this.chapter});
  final int book, chapter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colorthemes.background[theme],
          backgroundColor: Colorthemes.backgroundlight[theme],
          title: Title(
              color: Colors.black,
              child: Text(
                'verse'.tr(),
                style: TextStyle(color: Colorthemes.foreground[theme]),
              )),
          centerTitle: true,
        ),
        body: LayoutBuilder(builder: (context, constrains) {
          return Container(
              color: Colorthemes.background[theme],
              child: Padding(
                padding: EdgeInsets.fromLTRB(50, 20, 50, 50),
                child: Container(
                  height: constrains.maxHeight,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: bible[book]['chapters'][chapter].length,
                      itemBuilder: (context, index) {
                        List<int> verse = [book, chapter, index];
                        int verseLevel = SharedPrefs()
                            .getSpInt(spVerseLevel + verse.toString());

                        return InkWell(
                          onTap: () {
                            SharedPrefs().setSpIntList(spSelectedVerse, verse);
                            GameService().levelSelect(context:context);
                             
                          },
                          child: Container(
                            color: Colorthemes.backgroundlight[theme],
                            child: Column(
                              children: [
                                Expanded(child: Container()),
                                Text('${'verse'.tr()} ${index + 1}',
                                    style: TextStyle(
                                        color: Colorthemes.foreground[theme],
                                        fontSize: 16)),
                                Expanded(child: Container()),
                                IconRow(
                                  conditionInt: verseLevel,
                                  iconIf: Icons.star,
                                  iconIfNot: Icons.star_outline,
                                  expand: true,
                                  outSideFlex: 3,
                                  plus: false,
                                  condition: (int condition, int i) => condition > i,
                                ),
                                Expanded(child: Container()),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ));
        }));
  }
}
