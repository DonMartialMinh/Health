import 'package:flutter/material.dart';
import 'package:health/models/program.dart';

import 'activity_detail.dart';

class MainCardPrograms extends StatelessWidget {
  final Program program;

  MainCardPrograms({required this.program});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      child: Container(
        child: Stack(
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: FadeInImage.assetNetwork(
                  width: size.width,
                  placeholder: 'assets/images/loading.gif',
                  image: program.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      this.program.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      this.program.time,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    )
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.85),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
              ),
            ),
          ],
        ),
        width: size.width - 40,
        height: (size.width - 40) / 2,
        margin: EdgeInsets.only(
          top: 5.0,
          left: 20.0,
          right: 20.0,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return ActivityDetail(program: this.program);
            },
          ),
        );
      },
    );
  }
}