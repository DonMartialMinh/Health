import 'package:flutter/material.dart';
import 'package:health/models/food.dart';
import 'package:url_launcher/url_launcher.dart';
import 'list_component.dart';

class DetailFoodPage extends StatelessWidget{
  Food food;
  String tag;
  DetailFoodPage({required this.food, required this.tag});

  List<Widget> generateMethod(BuildContext context, List<String> list) {
    List<Widget> _list = [];
    int index = 0;
    list.forEach((step) {
      Widget element = Container(
        child: ListComponent(index: index, content: step, color: Colors.green),
      );
      _list.add(element);
      index++;
    });
    return _list;
  }

  List<Widget> generateIngredients(BuildContext context, List<String> list) {
    List<Widget> _list = [];
    list.forEach((step) {
      Widget element = Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(' - $step', style: TextStyle(fontSize: 20,fontFamily: 'PatrickHand'),),
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
    // TODO: implement build
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text('${this.food.name}'),backgroundColor: Colors.green,),
      body: Center(
        child: SingleChildScrollView(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: this.generateIngredients(context, food.ingredients),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text('Method', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'PatrickHand'),),
              ),
              Column(
                children: this.generateMethod(context, food.steps),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('You can see this video for more detail: ', style: TextStyle(fontSize: 22, fontStyle: FontStyle.italic, fontFamily: 'PatrickHand'),),
                    InkWell(
                      child: Text('Click Here!', style: TextStyle(color: Colors.redAccent ,fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'PatrickHand'),),
                      onTap: () {
                        _launchURL(food.youtubeLink);
                      },
                    )
                  ],
                )
              ),
              Padding(padding: EdgeInsets.only(bottom: 30))
            ],
          ),
        ),
      ),
    ));
  }
}