import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health/components/section_title.dart';
import 'package:health/components/exercise_list_page.dart';
import 'package:health/models/exercise.dart';
import 'exercise_card.dart';

class ExcerciseBodyPartCategory extends StatelessWidget {

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
                      MaterialPageRoute(builder: (context) => ExerciseListPage(kind: 'BodyFocus' ,category: 'Arm', title: 'Arm focus exercises'))
                  );
                },
                child: SectionTitle('Arm'),
              ),
              Container(
                height: 234,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('BodyFocus')
                      .where('difficult', isEqualTo: 'Arm')
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
                      MaterialPageRoute(builder: (context) => ExerciseListPage(kind: 'BodyFocus' ,category: 'Leg', title: 'Leg focus exercises'))
                  );
                },
                child: SectionTitle('Leg'),
              ),
              Container(
                height: 234,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('BodyFocus')
                      .where('difficult', isEqualTo: 'Leg')
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
                      MaterialPageRoute(builder: (context) => ExerciseListPage(kind: 'BodyFocus' ,category: 'Belly', title: 'Belly focus exercises'))
                  );
                },
                child: SectionTitle('Belly'),
              ),
              Container(
                height: 234,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('BodyFocus')
                      .where('difficult', isEqualTo: 'Belly')
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