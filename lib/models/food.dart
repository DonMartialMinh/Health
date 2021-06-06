import 'dart:math';

class Food{
  late int id;
  String name;
  String urlImage;
  String youtubeLink;
  Duration duration;
  int calorie;
  Complexity complexity;
  List<String> ingredients;
  List<String> steps;
  FoodCategory category;

  Food({
    required this.name,
    required this.urlImage,
    required this.duration,
    required this.youtubeLink,
    required this.calorie,
    required this.complexity,
    required this.ingredients,
    required this.steps,
    required this.category
}){
    this.id = Random().nextInt(1000);
  }
}

enum Complexity{
  Simple,
  Medium,
  Hard
}

enum FoodCategory{
  NonVegetarian,
  Vegetarian
}