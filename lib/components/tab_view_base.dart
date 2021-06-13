import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health/components/image_card_with_basic_footer.dart';
import 'package:health/data/fake_data.dart';
import 'package:flutter/material.dart';
import 'package:health/models/food.dart';

class TabViewBase extends StatelessWidget {
  final String tabName;

  TabViewBase({required this.tabName});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      //height: 230,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Food')
            .where('category', isEqualTo: tabName)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (!streamSnapshot.hasData) {
            return Container();
          }
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount:  streamSnapshot.data!.docs.length,
            itemBuilder: (ctx, index) =>
              Container(
                margin: EdgeInsets.all(20.0),
                child: ImageCardWithBasicFooter(
                  food: new Food(
                      name: streamSnapshot.data!.docs[index]['name'],
                      urlImage: streamSnapshot.data!.docs[index]['urlImage'],
                      duration: streamSnapshot.data!.docs[index]['duration'],
                      youtubeLink: streamSnapshot.data!.docs[index]['youtubeLink'],
                      calorie: streamSnapshot.data!.docs[index]['calorie'],
                      complexity: streamSnapshot.data!.docs[index]['complexity'],
                      ingredients: streamSnapshot.data!.docs[index]['ingredients'].cast<String>(),
                      steps: streamSnapshot.data!.docs[index]['steps'].cast<String>(),
                      category: streamSnapshot.data!.docs[index]['category']),
                  tag: '${streamSnapshot.data!.docs[index].id}',
                  imageWidth: size.width,
                ),
              )
          );
        },
      ),
    );
  }
}