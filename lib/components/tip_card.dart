import 'package:flutter/material.dart';
import 'package:health/models/tip.dart';

class TipCard extends StatelessWidget {
  Tip tip;
  TipCard({required this.tip});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width * 0.8;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: width,
          height: 180.0,
          margin: EdgeInsets.only(
            bottom: 10.0,
            left: 20.0,
          ),
          child: ClipRRect(
            child: Center(
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading.gif',
                image: tip.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            this.tip.title,
            style: TextStyle(fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color : Colors.redAccent
            ),
          ),
        ),
        Container(
          width: width,
          margin: EdgeInsets.only(top: 10.0, left: 20),
          child: Text(
            this.tip.content,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );
  }
}