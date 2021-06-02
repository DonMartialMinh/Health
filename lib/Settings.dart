import 'package:flutter/material.dart';
import 'components/Header.dart';
import 'components/user_photo.dart';

class Settings extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Header(
                  'Settings',
                  rightSide: Container(
                    height: 35.0,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    margin: EdgeInsets.only(right: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Text(
                        'User info',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: UserPhoto(),
                  ),
                ),
                Text('Minh Đôn', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
      )
    );
  }
}