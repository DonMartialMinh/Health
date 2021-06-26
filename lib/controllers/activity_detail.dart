import 'package:health/controllers/next_step.dart';
import 'package:health/models/exercise.dart';
import 'package:health/controllers/activity_timer.dart';
import 'package:flutter/material.dart';
import 'package:health/models/program.dart';

class ActivityDetail extends StatelessWidget {
  final Program program;

  ActivityDetail({
    required this.program,
  });

  List<Widget> generateList(List<Exercise> list) {
    List<Widget> _list = [];
    list.forEach((exercise) {
      Widget element = Container(
        //margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: GestureDetector(
          child: NextStep(title: exercise.title,image: exercise.image, seconds: exercise.time),
        ),
      );
      _list.add(element);
    });
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Exercise currentExercise = program.exercises[0];
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 270,
                  child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                      placeholder: 'assets/images/loading.gif',
                      image: program.image),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(0, 0, 0, 0.7),
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        program.title,
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.blueGrey,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        height: 90.0,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(231, 241, 255, 1.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 55.0),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Time',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.blueGrey[300]),
                                  ),
                                  Text(
                                    '${program.time}',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.lightBlue,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 45.0),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Intensity',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.blueGrey[300],
                                    ),
                                  ),
                                  Text(
                                    currentExercise.difficult,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: (
                                          currentExercise.difficult == 'Beginner') ? Colors.lightBlue
                                          : ((currentExercise.difficult == 'Intermediate') ? Colors.amber : Colors.red),
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15.0),
                        child: Column(
                          children: generateList(program.exercises),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
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
              return ActivityTimer(exercises: this.program.exercises);
            }),
          );
        },
      ),
    ));
  }
}