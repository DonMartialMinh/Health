
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health/models/exercise.dart';

class GetExercise extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Exercise')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (ctx, index) =>
                Text(streamSnapshot.data!.docs[0]['text']),
          );
        },
      )
    );
  }
}

Future <List<Exercise>> getExercises() async {
  List<Exercise> exercises = [];
  int temp = 0;
  // Get a reference to the database.
  CollectionReference collection = FirebaseFirestore.instance.collection('Exercise');
  var querySnapshot = await collection.get();
  for (var queryDocumentSnapshot in querySnapshot.docs) {
    Map<String, dynamic> data = queryDocumentSnapshot.data();
    exercises[temp].title = data['title'];
    exercises[temp].time = data['time'];
    exercises[temp].difficult = data['difficult'];
    exercises[temp].image = data['image'];
    temp++;
  }
  print(exercises.length);
  return exercises;

  // Query the table for all The Dogs.
  // final List<Map<String, dynamic>> maps = FirebaseFirestore.instance.collection('Exercise').doc().get();
  //
  //
  // // Convert the List<Map<String, dynamic> into a List<Dog>.
  // return List.generate(maps.length, (i) {
  //   return Dog(
  //     id: maps[i]['id'],
  //     name: maps[i]['name'],
  //     age: maps[i]['age'],
  //   );
  // });
}
