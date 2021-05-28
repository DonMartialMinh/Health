import 'dart:math';

class Exercise {
  late int id;
  final String title, time, difficult, image;
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
  this.id = Random().nextInt(1000);
  }
}

const List<String> Fake = [''];