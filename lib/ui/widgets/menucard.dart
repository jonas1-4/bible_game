import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:flutter/material.dart';


class MenuCard extends StatelessWidget {
  final String titletext;
  final VoidCallback onTap;
  MenuCard({required this.titletext, required this.onTap});

  @override
  Widget build(BuildContext buildContext) {
    return InkWell(
        onTap: onTap,
      child: Card(
        color: Colorthemes.backgroundlight[theme],
        elevation: 5,
        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              Center(
                  child: Text(
                '$titletext',
                style:
                    TextStyle(fontSize: 20),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
