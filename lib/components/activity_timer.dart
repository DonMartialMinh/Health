
import 'package:flutter/material.dart';
import 'package:health/models/exercise.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:async';

class ActivityTimer extends StatefulWidget {
  final List<Exercise> exercises;
  late int currentExerciseIndex;
  late int _start;
  late bool isStarting;
  late Timer _timer;

  ActivityTimer({required this.exercises}){
    currentExerciseIndex = 0;
    _start = exercises[currentExerciseIndex].time;
    isStarting = false;
    _timer = new Timer.periodic(
      const Duration(seconds: 0),
          (Timer timer) {
      },
    );
  }


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ActivityTimerState();
  }
}

class _ActivityTimerState extends State<ActivityTimer> {
  void startTimer() {
    const sec = const Duration(seconds: 1);
      widget._timer = new Timer.periodic(
        sec,
            (Timer timer) {
          if (widget._start == 1) {
            timer.cancel();
          }
          if (!widget.isStarting) {
            setState(() {
              timer.cancel();
            });
          } else if (widget.isStarting ){
            setState(() {
              widget._start--;
            });
          }
        },
      );
  }
  @override
  void dispose() {
    widget._timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 270,
                      child: Image.asset(
                        widget.exercises[widget.currentExerciseIndex].image,
                        fit: BoxFit.fitHeight,
                      ),
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
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
                  // height: size.height - 270.0,
                  width: size.width,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Text(
                              '${widget.exercises[widget.currentExerciseIndex].title}',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w900,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: (widget.currentExerciseIndex + 1 == widget.exercises.length)
                            ? Text(
                              'Next: Finish',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w900,
                                color: Colors.grey[500],
                              ),
                            )
                            : Text(
                              'Next: ${widget.exercises[widget.currentExerciseIndex + 1].title}',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w900,
                                color: Colors.grey[500],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: CircularPercentIndicator(
                              radius: size.width * 0.60,
                              animation: false,
                              //animationDuration: 1200,
                              lineWidth: 16.0,
                              percent: widget._start / widget.exercises[widget.currentExerciseIndex].time,
                              center: (widget.isStarting) ? InkWell(child: Container(
                                child: Text(
                                  '${widget._start} sec',
                                  style: TextStyle(
                                    fontSize: 50.0,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                                onTap: () {
                                  setState(() {
                                    widget.isStarting = false;
                                  });
                                },
                              ) : new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(padding: EdgeInsets.only(top:40)),
                                  Text(
                                    '${widget._start} sec',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  InkWell(
                                    child: Icon(Icons.play_arrow, size: 90,),
                                    onTap: () {
                                        setState(() {
                                          widget.isStarting = true;
                                          startTimer();
                                        });
                                    },
                                  )
                                ],
                              ),
                              backgroundColor: Colors.white,
                              circularStrokeCap: CircularStrokeCap.round,
                              linearGradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(190, 130, 255, 1.0),
                                  Color.fromRGBO(105, 139, 255, 1.0),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
        ),
        bottomNavigationBar:
         GestureDetector(
          child: Container(
            width: size.width - 130.0,
            height: 55.0,
            margin: EdgeInsets.only(left: 20,right: 20.0, bottom: 30),
            decoration: BoxDecoration(
              color: Colors.red[500],
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Center(
              child: (widget.currentExerciseIndex + 1 == widget.exercises.length)? Text(
                'Finish',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w900,
                ),
              ): Text(
              'Next',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            ),
          ),
          onTap: () {
            if (widget.currentExerciseIndex < widget.exercises.length - 1)
              {
                Next();
              }
            else
              {
                Navigator.pop(context);
              }
          },
        )
      ),
    );
  }

  void Next() {
    setState(() {
      widget.isStarting = false;
      widget.currentExerciseIndex++;
      widget._start = widget.exercises[widget.currentExerciseIndex].time;
    });
  }
}