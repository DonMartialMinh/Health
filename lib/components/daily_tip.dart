import 'package:flutter/material.dart';

class DailyTip extends StatelessWidget {

  final Map<String, String> element = {
    'title': '3 Main workout tips',
    'subtitle': 'The American Council on Exercises (ACE) recently surveyed 3,000 ACE-certificated personal trainers about the best!',
    'image': 'assets/images/image011.jpg',
  };

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
              image: AssetImage(this.element['image']!),
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
            this.element['title']!,
            style: TextStyle(fontSize: 14.0),
          ),
        ),
        Container(
          width: width,
          margin: EdgeInsets.only(top: 10.0, left: 20),
          child: Text(
            this.element['subtitle']!,
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