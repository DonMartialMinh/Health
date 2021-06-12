import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health/components/section.dart';
import 'package:health/components/section_title.dart';
import 'package:health/components/exercise_list_page.dart';
import 'package:health/models/exercise.dart';
import 'package:health/data/fake_data.dart';
import 'detail_exercise_card.dart';
import 'fit_image_card.dart';

class ExcerciseYogaCategory extends StatelessWidget {

  List<Exercise> getData (String sectionName) {
    return exercisesYoga.where((exercises) => exercises.difficult == sectionName).toList();
  }

  List<Widget> generateCard(BuildContext context, double width, List<Exercise> exercises) {
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
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text('Category'),backgroundColor: Colors.redAccent,),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ExerciseListPage(category: 'Beginners', title: 'Beginners yoga poses'))
                  );
                },
                child: SectionTitle('Beginners yoga poses'),
              ),
              Container(
                height: 230,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Exercise')
                      .where('difficult', isEqualTo: 'Beginners')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (!streamSnapshot.hasData) {
                      return Container();
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:  streamSnapshot.data!.docs.length,
                      itemBuilder: (ctx, index) =>
                          Container(
                            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: GestureDetector(
                              child: FitImageCard(
                                exercise: new Exercise(
                                  title: streamSnapshot.data!.docs[index]['title'],
                                  time: streamSnapshot.data!.docs[index]['time'],
                                  difficult: streamSnapshot.data!.docs[index]['difficult'],
                                  image: streamSnapshot.data!.docs[index]['image'],
                                  effect: streamSnapshot.data!.docs[index]['effect'],
                                  caution: streamSnapshot.data!.docs[index]['caution'],
                                  steps: streamSnapshot.data!.docs[index]['steps'].cast<String>(),
                                ),
                                tag: streamSnapshot.data!.docs[index].id,
                                imageWidth: _cardWidth,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return DetailExerciseCard(exercise: new Exercise(
                                        title: streamSnapshot.data!.docs[index]['title'],
                                        time: streamSnapshot.data!.docs[index]['time'],
                                        difficult: streamSnapshot.data!.docs[index]['difficult'],
                                        image: streamSnapshot.data!.docs[index]['image'],
                                        effect: streamSnapshot.data!.docs[index]['effect'],
                                        caution: streamSnapshot.data!.docs[index]['caution'],
                                        steps: streamSnapshot.data!.docs[index]['steps'].cast<String>(),
                                      ), tag: streamSnapshot.data!.docs[index].id);
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                    );
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ExerciseListPage(category: 'Intermediate', title: 'Intermediate yoga poses'))
                  );
                },
                child: SectionTitle('Intermediate yoga poses'),
              ),
              Container(
            height: 230,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Exercise')
                  .where('difficult', isEqualTo: 'Intermediate')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (!streamSnapshot.hasData) {
                  return Container();
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:  streamSnapshot.data!.docs.length,
                  itemBuilder: (ctx, index) =>
                      Container(
                        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: GestureDetector(
                          child: FitImageCard(
                            exercise: new Exercise(
                              title: streamSnapshot.data!.docs[index]['title'],
                              time: streamSnapshot.data!.docs[index]['time'],
                              difficult: streamSnapshot.data!.docs[index]['difficult'],
                              image: streamSnapshot.data!.docs[index]['image'],
                              effect: streamSnapshot.data!.docs[index]['effect'],
                              caution: streamSnapshot.data!.docs[index]['caution'],
                              steps: streamSnapshot.data!.docs[index]['steps'].cast<String>(),
                            ),
                            tag: streamSnapshot.data!.docs[index].id,
                            imageWidth: _cardWidth,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) {
                                  return DetailExerciseCard(exercise: new Exercise(
                                    title: streamSnapshot.data!.docs[index]['title'],
                                    time: streamSnapshot.data!.docs[index]['time'],
                                    difficult: streamSnapshot.data!.docs[index]['difficult'],
                                    image: streamSnapshot.data!.docs[index]['image'],
                                    effect: streamSnapshot.data!.docs[index]['effect'],
                                    caution: streamSnapshot.data!.docs[index]['caution'],
                                    steps: streamSnapshot.data!.docs[index]['steps'].cast<String>(),
                                  ), tag: streamSnapshot.data!.docs[index].id);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                );
              },
            ),
          ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ExerciseListPage(category: 'Advanced', title: 'Advanced yoga poses'))
                  );
                },
                child: SectionTitle('Advanced yoga poses'),
              ),
              Container(
                height: 230,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Exercise')
                      .where('difficult', isEqualTo: 'Advanced')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (!streamSnapshot.hasData) {
                      return Container();
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:  streamSnapshot.data!.docs.length,
                      itemBuilder: (ctx, index) =>
                          Container(
                            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: GestureDetector(
                              child: FitImageCard(
                                exercise: new Exercise(
                                  title: streamSnapshot.data!.docs[index]['title'],
                                  time: streamSnapshot.data!.docs[index]['time'],
                                  difficult: streamSnapshot.data!.docs[index]['difficult'],
                                  image: streamSnapshot.data!.docs[index]['image'],
                                  effect: streamSnapshot.data!.docs[index]['effect'],
                                  caution: streamSnapshot.data!.docs[index]['caution'],
                                  steps: streamSnapshot.data!.docs[index]['steps'].cast<String>(),
                                ),
                                tag: streamSnapshot.data!.docs[index].id,
                                imageWidth: _cardWidth,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return DetailExerciseCard(exercise: new Exercise(
                                        title: streamSnapshot.data!.docs[index]['title'],
                                        time: streamSnapshot.data!.docs[index]['time'],
                                        difficult: streamSnapshot.data!.docs[index]['difficult'],
                                        image: streamSnapshot.data!.docs[index]['image'],
                                        effect: streamSnapshot.data!.docs[index]['effect'],
                                        caution: streamSnapshot.data!.docs[index]['caution'],
                                        steps: streamSnapshot.data!.docs[index]['steps'].cast<String>(),
                                      ), tag: streamSnapshot.data!.docs[index].id);
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                    );
                  },
                ),
              ),
            ],
          ),
          padding: EdgeInsets.only(bottom: 20),
        ),
      ),
    ));
  }
}