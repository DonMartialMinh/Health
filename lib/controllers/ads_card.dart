import 'package:flutter/material.dart';
import 'package:health/models/ads.dart';
import 'package:url_launcher/url_launcher.dart';

class AdsCard extends StatelessWidget {
  final Ads ads;

  const AdsCard(
      {required this.ads});

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: [
              Container(
                width: size.width * 0.5,
                height: size.height * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Center(
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.gif',
                      image: this.ads.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Text(
              '${this.ads.name}',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 15.0),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Text(
              '${this.ads.price}',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        _launchURL(this.ads.url);
      },
    );
  }
}
