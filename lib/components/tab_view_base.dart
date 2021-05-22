import 'package:health/components/image_card_with_basic_footer.dart';
import 'package:health/data/fake_data.dart';
import 'package:flutter/material.dart';
import 'package:health/models/food.dart';

class TabViewBase extends StatelessWidget {
  final String tabName;

  TabViewBase({required this.tabName});

  List<Widget> _renderItem(Size size) {
    List<Food> foods = FAKE_FOODS.where((foods) => foods.category == this.tabName).toList();
    return List<Widget>.generate(foods.length, (index) {
      Food food = Food(
        name: foods[index].name,
        urlImage: foods[index].urlImage,
        duration: foods[index].duration,
        calorie: foods[index].calorie,
        complexity: foods[index].complexity,
        ingredients: foods[index].ingredients,
        category: foods[index].category
      );
      return Container(
        margin: EdgeInsets.only(top: 20.0),
        child: ImageCardWithBasicFooter(
          food: food,
          tag: '${foods[index].id}',
          imageWidth: size.width,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20.0),
        width: size.width,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(219, 228, 255, 1.0),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Track my ' + this.tabName,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color.fromRGBO(122, 158, 255, 1.0),
                    ),
                  ),
                  Icon(
                    Icons.add,
                    size: 25.0,
                    color: Color.fromRGBO(122, 158, 255, 1.0),
                  )
                ],
              ),
            ),
            Column(children: this._renderItem(size)),
          ],
        ),
      ),
    );
  }
}