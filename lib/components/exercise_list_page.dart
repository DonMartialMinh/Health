import 'package:flutter/material.dart';
import 'package:health/components/detail_exercise_card.dart';
import 'package:health/models/exercise.dart';

class ExerciseListPage extends StatelessWidget {
  List<Widget> list;
  String title;

  ExerciseListPage({required this.list, required this.title});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(child: Scaffold (
      appBar: AppBar(title: Text('${this.title}'),backgroundColor: Colors.redAccent,),
      body: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: this.list,
            ),
          ),
        padding: EdgeInsets.only(bottom: 20),
        )
      )
    );
  }
}