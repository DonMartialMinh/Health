import 'dart:math';

class Exercise {
  late int id, time ;
  final String title, difficult, image;
  late String effect, caution;
  late List<String> steps;

  Exercise({
    required this.title,
    required this.time,
    required this.difficult,
    required this.image,
    this.effect = "",
    this.caution = "",
    this.steps = Fake
  })
  {
  this.id = Random().nextInt(10000);
  }
}

const List<String> Fake = [''];