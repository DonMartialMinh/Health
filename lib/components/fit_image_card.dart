import 'package:health/models/exercise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FitImageCard extends StatelessWidget {
  final Exercise exercise;
  final String tag;
  final double imageWidth;

  FitImageCard({
    required this.exercise,
    required this.tag,
    required this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            width: this.imageWidth,
            height: 160.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading.gif',
                image: this.exercise.image,
                fit: BoxFit.fill,
              ),
            ),
          ),
        Container(
          width: this.imageWidth,
          margin: EdgeInsets.only(top: 10.0),
          child: Text(
            this.exercise.title,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 14.0),
          ),
        ),
        Container(
          width: this.imageWidth,
          margin: EdgeInsets.only(top: 5.0),
          child: Text(
            '${this.exercise.time} sec    |    ${this.exercise.difficult}',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}