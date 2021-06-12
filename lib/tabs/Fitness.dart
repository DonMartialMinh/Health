import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health/components/activity_detail.dart';
import 'package:health/components/exercise_yoga_category.dart';
import 'package:health/models/ads.dart';
import 'package:health/models/tip.dart';
import '../components/exercise_body_part_category.dart';
import '../data/fake_data.dart';
import 'package:health/components/daily_tip.dart';
import 'package:health/components/header.dart';
import 'package:health/components/section.dart';
import 'package:health/components/image_card_with_internal.dart';
import 'package:health/components/main_card_programs.dart';
import 'package:health/models/exercise.dart';
import '../components/fit_image_card.dart';
import '../components/detail_exercise_card.dart';
import 'package:health/components/section_title.dart';
import 'package:health/models/program.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:health/data/GetExercise.dart';

class Fitness extends StatelessWidget {
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
                  return DetailExerciseCard(exercise: exercise, tag: '${exercise.id}');
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

  List<Widget> generateAds(BuildContext context, List<Ads> list) {
    List<Widget> _list = [];
    list.forEach((ads) {
      Widget element = Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: GestureDetector(
          child: ImageCardWithInternal(image: ads.image, title: ads.name, duration: ads.price),
          onTap: () {
            _launchURL(ads.url);
          },
        ),
      );
      _list.add(element);
    });
    return _list;
  }

  List<Widget> generateTips(BuildContext context, List<Tip> list) {
    List<Widget> _list = [];
    list.forEach((tip) {
      Widget element = Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: DailyTip(tip: tip),
      );
      _list.add(element);
    });
    return _list;
  }

  List<Widget> generateMainCard(BuildContext context, List<Program> list) {
    List<Widget> _list = [];
    list.forEach((program) {
      Widget element = Container(
        //margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: GestureDetector(
          child: MainCardPrograms(program: program,),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return ActivityDetail(program: program);
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


  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double _cardWidth = MediaQuery.of(context).size.width * 2/3;
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
                Section(
                  horizontalList: this.generateMainCard(context, programs),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ExcerciseBodyPartCategory())
                    );
                  },
                  child: SectionTitle('Body focus'),
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
                  height: 230,
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
                Padding(padding: EdgeInsets.only(bottom: 20)),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.pink[50],
                  ),
                  child: Column(
                    children: [
                      SectionTitle('Advertises'),
                      Section(
                          horizontalList: this.generateAds(context, ads)
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
                      Section(
                        horizontalList: this.generateTips(context, tips),
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

