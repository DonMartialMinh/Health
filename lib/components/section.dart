import 'package:flutter/material.dart';
import 'package:health/components/Header.dart';

class Section extends StatelessWidget {
  final List<Widget> horizontalList;
  final String title;

  Section({required this.title, required this.horizontalList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 35.0),
      child: Column(
        children: <Widget>[
          SectionTitle(this.title),
          SingleChildScrollView(
            padding: EdgeInsets.only(left: 20.0, top: 10.0),
            scrollDirection: Axis.horizontal,
            child: Row(
                children: this.horizontalList
            ),
          )
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String _text;

  SectionTitle(this._text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20.0, left: 20.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            Text(this._text, style: TextStyle(fontSize: 20),),
            Expanded(child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.arrow_right_alt, size: 30,)
              ],
            ))
          ],
        )
      )
    );
  }
}