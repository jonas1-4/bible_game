

import 'package:bible_game/data/colors.dart';
import 'package:bible_game/data/public_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerDropDown extends StatelessWidget {
  const DrawerDropDown({
    Key? key,
    required this.hint,
    required this.name,
    required this.items,
    required this.onTap,
  }) : super(key: key);

  final String hint, name;
  final List items;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(name,
            style: TextStyle(fontSize: 17)),
        Expanded(child: Container()),
        (items.length > 1)
            ? DropdownButton(
                underline: Container(),
                menuMaxHeight: 300,
                hint: Text(hint,style: TextStyle(color:  Colorthemes.foreground[theme])),
                dropdownColor: Colorthemes.backgroundlight[theme],
                items: items.map((value) {
                  String valueStr;
                  if(value.runtimeType == String){
                    valueStr = value;
                  }else{
                    valueStr = value['name'];
                  }
                  return DropdownMenuItem<String>(
                      onTap: () {
                        onTap(items.indexOf(value), valueStr);
                      },
                      value: valueStr,
                      child: Text(valueStr,));
                }).toList(),
                onChanged: (_) {},
              )
            : Text(hint, style: TextStyle( fontSize: 17)),
      ],
    );
  }
}
