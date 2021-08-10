import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:bible_game/main.dart';
import 'package:bible_game/services/game_service.dart';
import 'package:bible_game/services/shared_prefs.dart';
import 'package:bible_game/ui/icon_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class EndScreen extends StatefulWidget {
  @override
  _EndScreenState createState() => _EndScreenState();
}

class _EndScreenState extends State<EndScreen> {
  int stars = SharedPrefs().getSpInt(
      spVerseLevel + SharedPrefs().getSpIntList(spSelectedVerse).toString());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //have to pop so the lastverse/continue Button updates
        Navigator.popAndPushNamed(context, homescreenPath);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colorthemes.backgroundlight[theme],
          centerTitle: true,
          title: Title(
              color: Colorthemes.foreground[theme],
              child: Text(
                'perfect'.tr(),
                style: TextStyle(
                  color: Colorthemes.foreground[theme],
                ),
              )),
        ),
        body: Container(
            color: Colorthemes.background[theme],
            child: Column(children: [
              SizedBox(height: 70),
              IconRow(
                  size: 80,
                  conditionInt: stars,
                  iconIf: Icons.star,
                  iconIfNot: Icons.star_outline,
                  condition: (int star, int i) => i < star),
              Expanded(child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButtonText(
                        icon: Icons.arrow_right_alt,
                        onTap: () => GameService().nextLevel(context),
                        text: 'nextLvl'.tr(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      IconButtonText(
                        icon: Icons.replay,
                        onTap: () => GameService()
                            .levelSelect(context: context, replay: true),
                        text: 'replay'.tr(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      IconButtonText(
                        icon: Icons.home,
                        onTap: () =>
                            Navigator.popAndPushNamed(context, homescreenPath),
                        text: 'toHomescreen'.tr(),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
            ])),
      ),
    );
  }
}

class IconButtonText extends StatelessWidget {
  const IconButtonText({
    required this.onTap,
    required this.icon,
    required this.text,
    Key? key,
  }) : super(key: key);

  final Function onTap;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          icon,
          size: 20,
          color: Colorthemes.foreground[theme],
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: TextStyle(color: Colorthemes.foreground[theme], fontSize: 20),
        ),
      ]),
    );
  }
}
