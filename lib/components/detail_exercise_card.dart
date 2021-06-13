

import 'package:health/components/activity_timer.dart';
import 'package:flutter/material.dart';
import 'package:health/models/exercise.dart';
import 'package:health/components/list_component.dart';

class DetailExerciseCard extends StatelessWidget{
  Exercise exercise;
  String tag;
  late List <Exercise> list;
  DetailExerciseCard({required this.exercise, required this.tag}){
    list = [];
    list.add(exercise);
  }

  List<Widget> generateComponent(BuildContext context, List<String> list) {
    List<Widget> _list = [];
    int index = 0;
    list.forEach((step) {
      Widget element = Container(
        child: ListComponent(index: index, content: step, color: Colors.redAccent),
      );
      _list.add(element);
      index++;
    });
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text('${this.exercise.title}', style: TextStyle(fontSize: 25),),backgroundColor: Colors.redAccent,),
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Center(
              child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/loading.gif',
                  image: this.exercise.image
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text('Guideline', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'PatrickHand'),),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: RichText(
                text: TextSpan(
                    style:  new TextStyle(
                        fontSize: 22,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                        fontFamily: 'PatrickHand'),
                  children: [
                    new TextSpan(text: exercise.effect),
                    new TextSpan(text: ' '),
                    new TextSpan(
                        text: exercise.caution,
                        style: new TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                            fontFamily: 'PatrickHand'),
                    ),
                  ]
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text('Steps', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'PatrickHand'),),
            ),
            Column(
              children: this.generateComponent(context, exercise.steps),
            ),
            Padding(padding: EdgeInsets.only(bottom: 30))
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        child: Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color: Colors.red[500],
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(100, 140, 255, 0.5),
                  blurRadius: 10.0,
                  offset: Offset(0.0, 5.0),
                ),
              ]),
          child: Text(
            'Start',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) {
              return ActivityTimer(exercises: this.list);
            }),
          );
        },
      ),
    ));
  }
}