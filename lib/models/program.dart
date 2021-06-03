import 'dart:math';

import 'package:health/models/exercise.dart';

class Program {
  late int id;
  final String title, time, difficult, image;
  late String effect;
  List<Exercise> exercises;

  Program({
    required this.title,
    required this.time,
    required this.difficult,
    required this.image,
    required this.exercises,
    this.effect = "",
  })
  {
    this.id = Random().nextInt(1000);
  }
}