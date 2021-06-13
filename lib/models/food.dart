import 'dart:math';

class Food{
  late int id;
  String name;
  String urlImage;
  String youtubeLink;
  int duration;
  int calorie;
  String complexity;
  List<String> ingredients;
  List<String> steps;
  String category;

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
  Map<String, dynamic> toMap(){
    return {
      'name' : name,
      'urlImage' : urlImage,
      'duration' : duration,
      'youtubeLink' : youtubeLink,
      'calorie' : calorie,
      'complexity' : complexity,
      'ingredients' : ingredients,
      'steps' : steps,
      'category' : category
    };
  }
}