import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health/components/detail_exercise_card.dart';
import 'package:health/components/fit_image_card.dart';
import 'package:health/data/GetExercise.dart';
import 'package:health/data/fake_data.dart';
import 'package:health/models/ads.dart';
import 'package:health/models/exercise.dart';
import 'package:health/models/food.dart';

import 'Foods.dart';

class Statistics extends StatelessWidget {
  Exercise temp = new Exercise(
    title: 'Glute bridge',
    time: 10,
    difficult: 'Leg',
    image: 'https://cdn2.coachmag.co.uk/sites/coachmag/files/styles/insert_main_wide_image/public/2018/01/glute-bridge.jpg?itok=BRlJnlx2',
    effect: 'The glutes are often overlooked but they’re a key muscle group.',
    caution: '',
    steps: [
      'The bridge is a great way to work on your glutes. Lying on your back with knees bent and feet flat on the floor.',
      'Squeeze your glutes and push your heels into the floor to lift your hips into a bridge.',
      'You should finish with your hips straight and abdominals tight.'
    ]
  );


  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference exercise = FirebaseFirestore.instance.collection('BodyFocus');

    Future<void> addUser() async {
      // Call the user's CollectionReference to add a new user
        return exercise
            .add(temp.toMap())
            .then((value) => print("food Added"))
            .catchError((error) => print("Failed to add food: $error"));
    }

    return FlatButton(
      onPressed: addUser,
      child: Text(
        "tip ads",
      ),
    );
  }
}

//streamSnapshot.data!.docs[index]['title']