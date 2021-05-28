import 'data/fake_data.dart';
import 'package:health/components/daily_tip.dart';
import 'package:health/components/exercise_list_page.dart';
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
import 'package:health/components/section_title.dart';

import 'package:flutter/material.dart';

class Programs extends StatelessWidget {

  List<Widget> generateCard(BuildContext context, List<Exercise> list, double width) {
    List<Widget> _list = [];
    list.forEach((exercise) {
      Widget element = Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: GestureDetector(
          child: FitImageCard(
            exercise: exercise,
            tag: '${exercise.id}',
            imageWidth: width,
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
    double _cardWidth = MediaQuery.of(context).size.width * 2/3;
    double _listCardWidth = MediaQuery.of(context).size.width;
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
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ExerciseListPage(list: this.generateCard(context, exercisesFatBurning, _listCardWidth), title: 'Fat burning'))
                    );
                  },
                  child: SectionTitle('Fat burning'),
                ),
                Section(
                  horizontalList: this.generateCard(context, exercisesFatBurning, _cardWidth),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ExerciseListPage(list: this.generateCard(context, exercisesYoga, _listCardWidth), title: 'Yoga'))
                    );
                  },
                  child: SectionTitle('Yoga'),
                ),
                Section(
                  horizontalList: this.generateCard(context, exercisesYoga, _cardWidth),
                ),
                SectionTitle('Ads generating'),
                Section(
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
                      SectionTitle('Daily tips'),
                      Section(
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
                        ],
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