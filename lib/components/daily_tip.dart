import 'package:flutter/material.dart';
import 'package:health/models/tip.dart';

class DailyTip extends StatelessWidget {
  Tip tip;
  DailyTip({required this.tip});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width * 0.80;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: width,
          height: 200.0,
          margin: EdgeInsets.only(
            bottom: 10.0,
            left: 20.0,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(tip.image),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            this.tip.title,
            style: TextStyle(fontSize: 14.0),
          ),
        ),
        Container(
          width: width,
          margin: EdgeInsets.only(top: 10.0, left: 20),
          child: Text(
            this.tip.content,
            style: TextStyle(
              color: Colors.black45,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );
  }
}