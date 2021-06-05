import 'package:flutter/material.dart';

class ImageCardWithInternal extends StatelessWidget {
  final String image, title, duration;

  const ImageCardWithInternal({
    required this.image,
    required this.title,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: size.width* 0.9 ,
            height: size.width * 0.6,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.hardEdge,
              child: Center(
                child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading.gif',
                    image: this.image
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Text(
              this.title,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 15.0),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Text(
              '${this.duration}',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}