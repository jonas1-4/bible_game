import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:flutter/cupertino.dart';

class IconRow extends StatelessWidget {
  const IconRow({
    Key? key,
    required this.conditionInt,
    required this.iconIf,
    required this.iconIfNot,
    required this.condition,
    this.number = 3,
    this.expand = false,
    this.leftRightMiddle = 2,
    this.outSideFlex = 1,
    this.plus = false,
    this.size = 25,
  }) : super(key: key);

  final int conditionInt, number, outSideFlex;
  final double size;
  final IconData iconIf, iconIfNot;
  final bool expand, plus;
  final int leftRightMiddle;
  final bool Function(int condit, int iterator) condition;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (leftRightMiddle == 0 || leftRightMiddle == 2)
      children.add(Expanded(flex: outSideFlex, child: Container()));
    if (plus) {
      for (int i = number - 1; i >= 0; i--) {
        print(
            'i: $i  conditionInt: $i condition: ${condition(conditionInt, i)}');
        children.add(Padding(
          padding: const EdgeInsets.all(3.0),
          child: Icon(condition(conditionInt, i) ? iconIf : iconIfNot, size: size,
              color: Colorthemes.accentlight[theme]),
        ));
        if (expand)
          children.add(Expanded(
            child: Container(),
          ));
      }
    } else {
      for (int i = 0; i < number; i++) {
        print(
            'i: $i  conditionInt: $i condition: ${condition(conditionInt, i)}');
        children.add(Padding(
          padding: const EdgeInsets.all(3.0),
          child: Icon(condition(conditionInt, i) ? iconIf : iconIfNot, size: size,
              color: Colorthemes.accentlight[theme]),
        ));
        if (expand)
          children.add(Expanded(
            child: Container(),
          ));
      }
    }
    if (expand) children.removeLast();
    if (leftRightMiddle == 1 || leftRightMiddle == 2)
      children.add(Expanded(child: Container(), flex: outSideFlex));

    return Row(children: children);
  }
}
