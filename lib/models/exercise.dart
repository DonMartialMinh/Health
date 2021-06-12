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
}

const List<String> temp = [];