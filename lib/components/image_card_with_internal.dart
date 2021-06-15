import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImageCardWithInternal extends StatelessWidget {
  final String image, title, price, effect;

  const ImageCardWithInternal({
    required this.image,
    required this.title,
    required this.price,
    required this.effect
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: [
              Container(
                width: size.width* 0.9 ,
                height: size.width * 0.6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Center(
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.gif',
                      image: this.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,left: 0,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.red, width: 2)
                  ),
                  child: Text(' ${this.effect}',
                        style: TextStyle(fontSize: 15, color: Colors.red),),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Text(
              '${this.title}',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 15.0),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Text(
              '${this.price}',
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