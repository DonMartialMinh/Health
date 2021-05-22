import 'package:flutter/material.dart';
import 'package:health/models/food.dart';

class DetailFoodPage extends StatelessWidget{
  Food food;
  String tag;
  DetailFoodPage({required this.food, required this.tag});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text('${this.food.name}'),backgroundColor: Colors.green,),
      body: Center(
        child: Column(
          children: <Widget> [
            Center(
              child: Hero(
                tag: this.tag,
                child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading.gif',
                    image: food.urlImage),
              )
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text('Ingredients', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'PatrickHand'),),
            ),
            Expanded(child: ListView.builder(
                itemCount: food.ingredients.length,
                itemBuilder: (context, index){
                  String _ingredient = this.food.ingredients[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}', style: TextStyle(fontSize: 22, color: Colors.white),),
                      backgroundColor: Colors.green,
                    ),
                    title: Text(_ingredient, style: TextStyle(fontSize: 20,fontFamily: 'PatrickHand'),),
                  );
                }
            ))
          ],
        ),
      ),
    ));
  }
}