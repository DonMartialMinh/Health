import 'package:flutter/cupertino.dart';
import 'package:health/models/food.dart';
import 'package:flutter/material.dart';
import 'package:health/controllers/detail_food_page.dart';

class FoodCard extends StatelessWidget {
  final Food food;
  final String tag;
  final double imageWidth;

  FoodCard({
    required this.food,
    required this.tag,
    required this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    return  InkWell(
        onTap: () {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DetailFoodPage(food: food, tag: this.tag,))
      );
    },
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Stack(
             children: <Widget>[
               Container(
                 padding: EdgeInsets.all(0),
                 child: ClipRRect(
                   borderRadius: BorderRadius.circular(10),
                   clipBehavior: Clip.hardEdge,
                   child: Center(
                     child: Hero(
                       tag: this.tag,
                       child: FadeInImage.assetNetwork(
                           placeholder: 'assets/images/loading.gif',
                           image: food.urlImage
                       ),
                     )
                   ),
                 ),
               ),
               Positioned(
                 bottom: 10,left: 10,
                 child: Container(
                   padding: EdgeInsets.all(5),
                   decoration: BoxDecoration(
                       color: Colors.black45,
                       borderRadius: BorderRadius.circular(10),
                       border: Border.all(color: Colors.white, width: 2)
                   ),
                   child: Row(
                     children: <Widget>[
                       Icon(Icons.timer, color: Colors.white, size: 25,),
                       Text('${food.duration} minutes',
                         style: TextStyle(fontSize: 22, color: Colors.white),),
                     ],
                   ),
                 ),
               ),
               Positioned(
                 top: 10,right: 10,
                 child: Container(
                   padding: EdgeInsets.all(5),
                   decoration: BoxDecoration(
                     color: food.complexity == 'Simple' ? Colors.greenAccent : (food.complexity == 'Medium' ? Colors.yellowAccent : Colors.pinkAccent),
                     borderRadius: BorderRadius.circular(10),

                   ),
                   child: Row(
                     children: <Widget>[
                       Text('${food.complexity.toString().split('.').last}',
                         style: TextStyle(fontSize: 22, color: Colors.black),),
                     ],
                   ),
                 ),
               ),
               Positioned(
                 bottom: 10,right: 10,
                 child: Container(
                   padding: EdgeInsets.all(5),
                   decoration: BoxDecoration(
                     color: Colors.black45,
                     borderRadius: BorderRadius.circular(10),
                       border: Border.all(color: Colors.white, width: 2)
                   ),
                   child:Row(
                     children: [
                       Icon(Icons.fitness_center, color: Colors.white, size: 25,),
                       Text('${food.calorie} kcal',
                         style: TextStyle(fontSize: 22, color: Colors.white),),
                     ],
                   )
                 ),
               ),
             ],
           ),
           Container(
             width: this.imageWidth,
             margin: EdgeInsets.only(top: 10.0),
             child: Text(
               this.food.name,
               textAlign: TextAlign.left,
               style: TextStyle(fontSize: 20.0),
             ),
           ),
         ]
       )
    );
  }
}