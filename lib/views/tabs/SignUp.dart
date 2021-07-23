import 'package:flutter/material.dart';
import 'package:health/components/facebook_sign_up.dart';
import 'package:health/components/google_sign_up.dart';

class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      //CustomPaint(painter: BackgroundPainter()),
      buildSignUp(),
    ],
  );

  Widget buildSignUp() => Container(
    color: Color.fromRGBO(255, 189, 89, 1),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacer(),
        Image(
          image: AssetImage('assets/images/appicon.png'), width: 180, height: 180,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: 200,
            child: Text(
              'Welcome Back To Health',
              style: TextStyle(
                color: Colors.black,
                fontSize: 35,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        Spacer(),
        GoogleSignUp(),
        FacebookSignUp(),
        SizedBox(height: 10),
        Text(
          'Login to continue',
          style: TextStyle(fontSize: 16),
        ),
        Spacer(),
      ],
    ),
  );
}