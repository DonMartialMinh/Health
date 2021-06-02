import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String _text;

  SectionTitle(this._text);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0, bottom: 5),
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