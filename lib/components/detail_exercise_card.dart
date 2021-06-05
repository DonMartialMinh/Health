


import 'package:flutter/material.dart';
import 'package:health/models/exercise.dart';
import 'package:health/components/list_component.dart';

class DetailExerciseCard extends StatelessWidget{
  Exercise exercise;
  String tag;
  DetailExerciseCard({required this.exercise, required this.tag});

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
                child: Hero(
                  tag: this.tag,
                  child: Image(
                      image: AssetImage(exercise.image)),
                )
            ),
            Container(
              padding: EdgeInsets.all(20),
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
            Column(
              children: this.generateComponent(context, exercise.steps),
            ),
            Padding(padding: EdgeInsets.only(bottom: 30))
          ],
        ),
      ),
    ));
  }
}