import 'package:flutter/material.dart';
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
      children: [
        Spacer(),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: 175,
            child: Text(
              'Welcome Back To MyApp',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Spacer(),
        GoogleSignUp(),
        SizedBox(height: 12),
        Text(
          'Login to continue',
          style: TextStyle(fontSize: 16),
        ),
        Spacer(),
      ],
    ),
  );
}