import 'package:health/components/daily_tip.dart';
import 'package:health/components/header.dart';
import 'package:health/components/image_card_with_basic_footer.dart';
import 'package:health/components/section.dart';
import 'package:health/components/image_card_with_internal.dart';
import 'package:health/components/main_card_programs.dart';
import 'package:health/components/user_photo.dart';
import 'package:health/components/user_tip.dart';
import 'package:health/models/exercise.dart';
import 'components/fit_image_card.dart';
import 'components/detail_exercise_card.dart';
import 'package:health/components/activity_detail.dart';

import 'package:flutter/material.dart';

class Programs extends StatelessWidget {
  final List<Exercise> exercisesFatBurning = [
    Exercise(
      image: 'assets/images/image001.jpg',
      title: 'Easy Start',
      time: '5 min',
      difficult: 'Low',
    ),
    Exercise(
      image: 'assets/images/image002.jpg',
      title: 'Medium Start',
      time: '10 min',
      difficult: 'Medium',
    ),
    Exercise(
      image: 'assets/images/image003.jpg',
      title: 'Pro Start',
      time: '25 min',
      difficult: 'High',
    )
  ];

  final List<Exercise> exercisesYoga = [
    Exercise(
      image: 'assets/images/yoga1.jpeg',
      title: 'Cat pose',
      time: '5 min',
      difficult: 'Low',
    ),
    Exercise(
      image: 'assets/images/yoga2.jpeg',
      title: 'Cobra pose',
      time: '5 min',
      difficult: 'Low',
    ),
    Exercise(
      image: 'assets/images/yoga3.jpeg',
      title: 'Cow pose',
      time: '5 min',
      difficult: 'Low',
    ),
    Exercise(
      image: 'assets/images/yoga4.jpeg',
      title: 'Child pose',
      time: '5 min',
      difficult: 'Medium',
    )
  ];

  List<Widget> generateCard(BuildContext context, List<Exercise> list) {
    List<Widget> _list = [];
    list.forEach((exercise) {
      Widget element = Container(
        margin: EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          child: FitImageCard(
            exercise: exercise,
            tag: '${exercise.id}',
            imageWidth: MediaQuery.of(context).size.width/2,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return DetailExerciseCard(exercise: exercise, tag: '${exercise.id}',);
                },
              ),
            );
          },
        ),
      );
      _list.add(element);
    });
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 20.0),
            child: Column(
              children: <Widget>[
                Header(
                  'Fitness',
                  rightSide: UserPhoto(),
                ),
                MainCardPrograms(), // MainCard
                Section(
                  title: 'Fat burning',
                  horizontalList: this.generateCard(context, exercisesFatBurning),
                ),
                Section(
                  title: 'Yoga',
                  horizontalList: this.generateCard(context, exercisesYoga),
                ),
                Section(
                  title: 'Abs Generating',
                  horizontalList: <Widget>[
                    ImageCardWithInternal(
                      image: 'assets/images/image004.jpg',
                      title: 'Core \nWorkout',
                      duration: '7 min',
                    ),
                    ImageCardWithInternal(
                      image: 'assets/images/image004.jpg',
                      title: 'Core \nWorkout',
                      duration: '7 min',
                    ),
                    ImageCardWithInternal(
                      image: 'assets/images/image004.jpg',
                      title: 'Core \nWorkout',
                      duration: '7 min',
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 50.0),
                  padding: EdgeInsets.only(top: 10.0, bottom: 40.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                  ),
                  child: Column(
                    children: <Widget>[
                      Section(
                        title: 'Daily Tips',
                        horizontalList: <Widget>[
                          UserTip(
                            image: 'assets/images/image010.jpg',
                            name: 'User Img',
                          ),
                          UserTip(
                            image: 'assets/images/image010.jpg',
                            name: 'User Img',
                          ),
                          UserTip(
                            image: 'assets/images/image010.jpg',
                            name: 'User Img',
                          ),
                          UserTip(
                            image: 'assets/images/image010.jpg',
                            name: 'User Img',
                          ),
                        ],
                      ),
                      Section(
                        horizontalList: <Widget>[
                          DailyTip(),
                          DailyTip(),
                          DailyTip(),
                        ], title: '',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}