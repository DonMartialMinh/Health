import 'dart:math';

class Exercise {
  late int id, time ;
  String title, difficult, image;
  String effect, caution;
  List<String> steps;

  Exercise({
    required this.title,
    required this.time,
    required this.difficult,
    required this.image,
    this.effect = "",
    this.caution = "",
    this.steps = temp
  })
  {
  this.id = Random().nextInt(10000);
  }


  Map<String, dynamic> toMap(){
    return {
      'title' : title,
      'difficult' : difficult,
      'time' : time,
      'image' : image,
      'effect' : effect,
      'caution' : caution,
      'steps' : steps,
    };
  }
  factory Exercise.fromJson(Map<String, dynamic> json) => fromJson(json);
}

fromJson(Map<String, dynamic> json) {
  return Exercise(
      title: json['title'] as String,
      time: json['time'] as int,
      difficult: json['difficult'] as String,
      image: json['image'] as String
  );
}

const List<String> temp = [];