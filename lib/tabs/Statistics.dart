import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health/models/exercise.dart';
import 'package:health/models/program.dart';

import 'Foods.dart';

class Statistics extends StatelessWidget {
  Program temp = new Program(
      title: 'Advanced start',
      time: '20 min',
      difficult: 'Advanced',
      image: 'https://cdn.shopify.com/s/files/1/1103/4864/articles/people-2604149_960_720_960x.jpg?v=1520663623',
      exercises: [
        Exercise(
          image: 'https://www.verywellfit.com/thmb/piE3wytFQNS_S3WGuS8jix7L2FQ=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-564120931-57b615773df78c69097528e2.jpg',
          title: 'Power clean and press',
          time: 300,
          difficult: 'Advanced',
        ),
        Exercise(
          image: 'https://www.verywellfit.com/thmb/CypSw-kj6UbJW6mkNgmbEofx63c=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/Verywell-34-3498604-BicepCurl01-1576-599462e7b501e800128ff42d.gif',
          title: 'Biceps Curls',
          time: 250,
          difficult: 'Advanced',
        ),
        Exercise(
          image: 'https://www.chicagotribune.com/resizer/zgdusStLwKyPYh2La9itWDH9-4U=/1200x0/top/cloudfront-us-east-1.images.arcpublishing.com/tronc/UXUVNNAFPBCRPA36DBMFM3SCAM.jpg',
          title: 'Treadmill run',
          time: 360,
          difficult: 'Advanced',
        ),
        Exercise(
          image: 'https://www.verywellfit.com/thmb/Vk9yvjF9wHZjMmOiJBh_1f8w-dk=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/About-194-1231474-Chest-Press-Bench02-1560-fe31b6ad47f042c896163a5e1a89e169.jpg',
          title: 'Chest press',
          time: 300,
          difficult: 'Advanced',
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