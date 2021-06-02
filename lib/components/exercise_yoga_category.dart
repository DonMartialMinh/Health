import 'package:flutter/material.dart';
import 'package:health/components/section.dart';
import 'package:health/components/section_title.dart';
import 'package:health/components/exercise_list_page.dart';
import 'package:health/models/exercise.dart';
import 'package:health/data/fake_data.dart';
import 'detail_exercise_card.dart';
import 'fit_image_card.dart';

class ExcerciseYogaCategory extends StatelessWidget {
  List<Widget> generateCard(BuildContext context, double width,String sectionName) {
    List<Exercise> exercises = exercisesYoga.where((exercises) => exercises.difficult == sectionName).toList();
    List<Widget> _list = [];
    exercises.forEach((exercise) {
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
    // TODO: implement build
    double _cardWidth = MediaQuery.of(context).size.width * 2/3;
    double _listCardWidth = MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text('Category'),backgroundColor: Colors.redAccent,),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ExerciseListPage(list: this.generateCard(context, _listCardWidth, 'Beginners'), title: 'Beginners yoga poses'))
                  );
                },
                child: SectionTitle('Beginners yoga poses'),
              ),
              Section(
                horizontalList: this.generateCard(context, _cardWidth, 'Beginners'),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ExerciseListPage(list: this.generateCard(context, _listCardWidth, 'Intermediate'), title: 'Intermediate yoga poses'))
                  );
                },
                child: SectionTitle('Intermediate yoga poses'),
              ),
              Section(
                horizontalList: this.generateCard(context, _cardWidth, 'Intermediate'),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ExerciseListPage(list: this.generateCard(context, _listCardWidth, 'Advanced'), title: 'Advanced yoga poses'))
                  );
                },
                child: SectionTitle('Advanced yoga poses'),
              ),
              Section(
                horizontalList: this.generateCard(context, _cardWidth, 'Advanced'),
              ),
            ],
          ),
          padding: EdgeInsets.only(bottom: 20),
        ),
      ),
    ));
  }
}