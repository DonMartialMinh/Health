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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            clipBehavior: Clip.hardEdge,
            child: Center(
              child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading.gif',
                    image: tip.image
                ),
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