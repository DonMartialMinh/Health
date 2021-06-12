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
      image: 'assets/images/Ayoga4.jpeg',
      title: 'Firefly Pose',
      time: 30,
      difficult: 'Advanced',
      effect: 'Want to fly? Fire up your core. Firefly pose is an arm balance pose that requires more core strength than arm strength.',
      caution: 'Shoulder, elbow, wrist and low back injuries.',
      steps: [
        'Squat with your feet a little less than shoulder distance apart. Tilt your pelvis forward and bring your trunk between your legs. Keeping your trunk low, straighten your legs enough to lift your pelvis to about knee height.',
        'Bring your left upper arm and shoulder as far as possible underneath the back of your left thigh just above the knee and place your left hand on the floor at the outside edge of your foot, fingers pointing forward. Repeat these actions on the other side.',
        'Lift yourself off the floor by carefully shifting your center of gravity. Press your hands into the floor and slowly begin to rock your weight back, off your feet and onto your hands. Keep your inner thighs as high on your arms as possible.',
        'With an inhalation, stretch your legs out to the sides as straight as you can, keeping your pelvis high to make your legs parallel to the floor.',
        'Press through the bases of your big toes but pull your toes back toward your torso and spread them apart. The inner edges of your feet should be angled slightly forward, the outer edges slightly back.',
        'Straighten your arms as much as possible. Hollow your chest as you widen your shoulder blades as much as possible; this will round your upper back, which will lift your torso higher.',
        'Without tensing your neck, lift your head and gaze forward. Breathe slowly and hold the pose for 15 seconds or longer, then release your feet to the floor with an exhale.'
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