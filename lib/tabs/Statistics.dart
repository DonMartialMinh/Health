import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health/components/detail_exercise_card.dart';
import 'package:health/components/fit_image_card.dart';
import 'package:health/data/GetExercise.dart';
import 'package:health/data/fake_data.dart';
import 'package:health/models/exercise.dart';

class Statistics extends StatelessWidget {
  Exercise temp = new Exercise(
      image: 'assets/images/Byoga2.jpeg',
      title: 'Cobra pose',
      time: 30,
      difficult: 'Beginners',
      effect: 'This pose provides a gentle massage to the spine and belly organs.',
      caution: 'With a neck injury, keep the head in line with the torso.',
      steps: [
        'Start on your hands and knees in a “tabletop” position. Make sure your knees are set directly below your hips and your wrists, elbows and shoulders are in line and perpendicular to the floor. Center your head in a neutral position, eyes looking at the floor.',
        'As you exhale, round your spine toward the ceiling, making sure to keep your shoulders and knees in position. Release your head toward the floor, but don’t force your chin to your chest.',
        'Inhale, coming back to neutral “tabletop” position on your hands and knees.',
        'This pose is often paired with Cow Pose on the inhale for a gentle, flowing vinyasa.'
      ]
  );

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference exercise = FirebaseFirestore.instance.collection('Exercise');

    Future<void> addUser() async {
      // Call the user's CollectionReference to add a new user
        return exercise
            .add(temp.toMap())
            .then((value) => print("exercise Added"))
            .catchError((error) => print("Failed to add user: $error"));
    }

    return FlatButton(
      onPressed: addUser,
      child: Text(
        "Add Exercise",
      ),
    );
  }
}

//streamSnapshot.data!.docs[index]['title']