import 'dart:math';

class Food{
  late int id;
  String name;
  String urlImage;
  Duration duration;
  int calorie;
  Complexity complexity;
  List<String> ingredients;
  String category;

  Food({
    required this.name,
    required this.urlImage,
    required this.duration,
    required this.calorie,
    required this.complexity,
    required this.ingredients,
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