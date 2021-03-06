import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health/components/section_title.dart';
import 'package:health/components/exercise_list_page.dart';
import 'package:health/models/exercise.dart';
import 'exercise_card.dart';

class ExcerciseYogaCategory extends StatelessWidget {

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
                      MaterialPageRoute(builder: (context) => ExerciseListPage(kind: 'Exercise' ,category: 'Beginners', title: 'Beginners yoga poses'))
                  );
                },
                child: SectionTitle('Beginners yoga poses'),
              ),
              Container(
                height: 234,
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
                            child: ExerciseCard(
                              exercise: new Exercise(
                                title: streamSnapshot.data!.docs[index]['title'],
                                time: streamSnapshot.data!.docs[index]['time'],
                                difficult: streamSnapshot.data!.docs[index]['difficult'],
                                image: streamSnapshot.data!.docs[index]['image'],
                                effect: streamSnapshot.data!.docs[index]['effect'],
                                caution: streamSnapshot.data!.docs[index]['caution'],
                                steps: streamSnapshot.data!.docs[index]['steps'].cast<String>(),
                              ),
                              imageWidth: _cardWidth,
                            ),
                          ),
                    );
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ExerciseListPage(kind: 'Exercise' ,category: 'Intermediate', title: 'Intermediate yoga poses'))
                  );
                },
                child: SectionTitle('Intermediate yoga poses'),
              ),
              Container(
            height: 234,
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
                        child: ExerciseCard(
                          exercise: new Exercise(
                            title: streamSnapshot.data!.docs[index]['title'],
                            time: streamSnapshot.data!.docs[index]['time'],
                            difficult: streamSnapshot.data!.docs[index]['difficult'],
                            image: streamSnapshot.data!.docs[index]['image'],
                            effect: streamSnapshot.data!.docs[index]['effect'],
                            caution: streamSnapshot.data!.docs[index]['caution'],
                            steps: streamSnapshot.data!.docs[index]['steps'].cast<String>(),
                          ),
                          imageWidth: _cardWidth,
                        ),
                      ),
                );
              },
            ),
          ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ExerciseListPage(kind: 'Exercise' ,category: 'Advanced', title: 'Advanced yoga poses'))
                  );
                },
                child: SectionTitle('Advanced yoga poses'),
              ),
              Container(
                height: 234,
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
                            child: ExerciseCard(
                              exercise: new Exercise(
                                title: streamSnapshot.data!.docs[index]['title'],
                                time: streamSnapshot.data!.docs[index]['time'],
                                difficult: streamSnapshot.data!.docs[index]['difficult'],
                                image: streamSnapshot.data!.docs[index]['image'],
                                effect: streamSnapshot.data!.docs[index]['effect'],
                                caution: streamSnapshot.data!.docs[index]['caution'],
                                steps: streamSnapshot.data!.docs[index]['steps'].cast<String>(),
                              ),
                              imageWidth: _cardWidth,
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