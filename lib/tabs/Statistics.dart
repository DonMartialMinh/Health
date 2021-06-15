import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health/models/exercise.dart';
import 'package:health/models/program.dart';

import 'Foods.dart';

class Statistics extends StatelessWidget {
  Program temp = new Program(
      title: 'Intermediate start',
      time: '10 min',
      difficult: 'Intermediate',
      image: 'https://www.runtastic.com/blog/wp-content/uploads/2018/06/how-to-squat-properly-without-mistake.jpg',
      exercises: [
        Exercise(
          image: 'https://www.runtastic.com/blog/wp-content/uploads/2018/06/how-to-squat-properly-without-mistake.jpg',
          title: 'Swat',
          time: 120,
          difficult: 'Intermediate',
        ),
        Exercise(
          image: 'https://www.wheystore.vn/upload/news_optimize/wst_1607682528_jumping_jack_la_gi__huong_dan_tap_jumping_jack_giam_can_hieu_qua_image_1607682528_1.jpg',
          title: 'Jumping jacks',
          time: 100,
          difficult: 'Intermediate',
        ),
        Exercise(
          image: 'https://post.healthline.com/wp-content/uploads/2020/03/Female_Running_Inplace_1200x628-facebook-1200x628.jpg',
          title: 'Run in place',
          time: 90,
          difficult: 'Intermediate',
        ),
      ]
  );


  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference exercise = FirebaseFirestore.instance.collection('Program');

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