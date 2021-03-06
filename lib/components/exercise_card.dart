import 'package:health/models/exercise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'detail_exercise_card.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final double imageWidth;

  ExerciseCard({
    required this.exercise,
    required this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
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
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent
              ),
            ),
          ),
          Container(
            width: this.imageWidth,
            margin: EdgeInsets.only(top: 5.0),
            child: Text(
              '${this.exercise.time} secs    |    ${this.exercise.difficult}',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return DetailExerciseCard(exercise: this.exercise);
            },
          ),
        );
      },
    );
  }
}