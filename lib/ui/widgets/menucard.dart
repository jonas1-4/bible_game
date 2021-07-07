
import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final String titletext;
  MenuCard({required this.titletext});

  @override
  Widget build(BuildContext buildContext) {
    return Card(
      color: Colors.blue,
      elevation: 5,
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            Center(
                child: Text(
              '$titletext',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
          ],
        ),
      ),
    );
  }
}
