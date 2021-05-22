import 'dart:math';

class Exercise {
  late int id;
  final String title, time, difficult, image;

  Exercise({
    required this.title,
    required this.time,
    required this.difficult,
    required this.image,
  })
  {
  this.id = Random().nextInt(1000);
  }
}