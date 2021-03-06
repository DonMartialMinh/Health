import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health/components/header.dart';
import 'package:health/components/exercise_yoga_category.dart';
import 'package:health/models/ads.dart';
import 'package:health/models/tip.dart';
import 'package:health/components/exercise_body_part_category.dart';
import 'package:health/components/tip_card.dart';
import 'package:health/components/ads_card.dart';
import 'package:health/components/main_card_programs.dart';
import 'package:health/models/exercise.dart';
import 'package:health/components/exercise_card.dart';
import 'package:health/components/section_title.dart';
import 'package:health/models/program.dart';
import 'package:flutter/material.dart';

class Fitness extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 2/3;
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
                  rightSide: Container(
                    height: 35.0,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    margin: EdgeInsets.only(right: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Text(
                        'Program',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
                SectionTitle('Fitness program'), // MainCard
                Container(
                  height: 230,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Program')
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
                            //margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: MainCardPrograms(program: new Program(
                                title: streamSnapshot.data!.docs[index]['title'],
                                time: streamSnapshot.data!.docs[index]['time'],
                                difficult: streamSnapshot.data!.docs[index]['difficult'],
                                image: streamSnapshot.data!.docs[index]['image'],
                                exercises: List<Exercise>.from(streamSnapshot.data!.docs[index]['exercises'].map((i) => Exercise.fromJson(i)))
                            )),
                          )
                      );
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ExcerciseBodyPartCategory())
                    );
                  },
                  child: SectionTitle('Body focus'),
                ),
                Container(
                  height: 234,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('BodyFocus')
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
                                imageWidth: cardWidth,
                              ),
                            ),
                      );
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ExcerciseYogaCategory())
                    );
                  },
                  child: SectionTitle('Yoga'),
                ),
                Container(
                  height: 234,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Exercise')
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
                                imageWidth: cardWidth,
                              ),
                            ),
                      );
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.pink[50],
                  ),
                  child: Column(
                    children: [
                      SectionTitle('Our products'),
                      Container(
                        height: 270,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('Ads')
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
                                child: AdsCard( ads: new Ads(
                                    name: streamSnapshot.data!.docs[index]['name'],
                                    content:  streamSnapshot.data!.docs[index]['content'],
                                    price: streamSnapshot.data!.docs[index]['price'],
                                    image: streamSnapshot.data!.docs[index]['image'],
                                    url:  streamSnapshot.data!.docs[index]['url']),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 20))
                    ],
                  ),
                ),
                Container(
                  //margin: EdgeInsets.only(top: 50.0),
                  padding: EdgeInsets.only( bottom: 40.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SectionTitle('Tips'),
                      Container(
                        height: 335,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('Tip')
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
                                  child: TipCard(tip: new Tip(
                                      title: streamSnapshot.data!.docs[index]['title'],
                                      content: streamSnapshot.data!.docs[index]['content'],
                                      image: streamSnapshot.data!.docs[index]['image'])
                                  ),
                                ),
                            );
                          },
                        ),
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

