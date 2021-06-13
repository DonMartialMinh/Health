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
  Food temp = new Food(
      name: 'Mexican Fajita Steak and Rice',
      urlImage: 'https://www.isabeleats.com/wp-content/uploads/2018/04/easy-steak-fajitas-small-1-650x650.jpg',
      duration:  17,
      calorie: 409,
      complexity: 'Simple',
      youtubeLink: 'https://www.youtube.com/watch?v=5oF2pwVv16k',
      ingredients: [
        '1 tbsp olive oil',
        '1 green pepper, sliced',
        '1 red pepper, sliced',
        '2 red onions, sliced',
        '400 g frying steak or chicken breast, sliced into long strips',
        '2 tbsp Mexican/Cajun/Fajita spice mix',
        '150 g white rice, uncooked weight',
        '1 tbsp tomato puree'
      ],
      category: 'NonVegetarian',
      steps: [
        'To start, bring rice (dry weight) to the boil cook according to the directions on the packet.',
        'Heat the olive oil in a large pan or work over a medium heat and add the chopped peppers and onions and fry until brown.',
        'Remove the veg from the pan and add the steak and fry for a couple of minutes or until it is cooked.',
        'Just like you would do with fajitas, add the vegetables back to the pan and mix through with the steak.',
        'Add the spice mix and mix through and cook for a further minute.',
        'Once the rice has cooked, drain it then add it to pan with the meat and vegetables along with the tomato puree and cook, stirring constantly for about a minute. Serve.',
      ]
  );

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference exercise = FirebaseFirestore.instance.collection('Food');

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