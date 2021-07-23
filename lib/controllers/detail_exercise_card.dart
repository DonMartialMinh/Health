import 'package:numberpicker/numberpicker.dart';
import 'package:flutter/material.dart';
import 'package:health/models/exercise.dart';
import 'package:health/controllers/list_component.dart';

import 'activity_timer.dart';

class DetailExerciseCard extends StatefulWidget{
  Exercise exercise;
  late List <Exercise> list;
  int _currentTimeValue = 0;
  DetailExerciseCard({required this.exercise}){
    list = [];
    list.add(exercise);
    _currentTimeValue = exercise.time;
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
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyWidgetState();
  }
}

class _MyWidgetState extends State<DetailExerciseCard> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text('${widget.exercise.title}', style: TextStyle(fontSize: 25)),
        backgroundColor: Colors.redAccent,),
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Center(
              child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/loading.gif',
                  image: widget.exercise.image
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
                      new TextSpan(text: widget.exercise.effect),
                      new TextSpan(text: ' '),
                      new TextSpan(
                        text: widget.exercise.caution,
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
              children: widget.generateComponent(context, widget.exercise.steps),
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
        onTap: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: const Text('Set timer:'),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NumberPicker(
                        value: widget._currentTimeValue,
                        minValue: 0,
                        maxValue: 200,
                        step: 1,
                        haptics: true,
                        textStyle: TextStyle(fontSize: 25),
                        selectedTextStyle: TextStyle(fontSize: 35, color: Colors.redAccent),
                        onChanged: (value) => setState(() { widget._currentTimeValue = value;}),
                      ),
                      Text(' secs', style: TextStyle(fontSize: 25),)
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel', style: TextStyle(fontSize: 20 ,color: Colors.redAccent),),
                    ),
                    TextButton(
                      onPressed: () => {
                        Navigator.pop(context),
                        Navigator.push(context,MaterialPageRoute(builder: (_) {
                        return ActivityTimer(exercises: widget.list, time: widget._currentTimeValue );
                         }),
                        ),
                      },
                      child: const Text('OK', style: TextStyle(fontSize: 20, color: Colors.redAccent),),
                    ),
                  ],
                );
              }
          ),
        ),
      ),
    ));
  }
}

