import 'dart:math';

class Weight{
  late int id;
  double weight;
  DateTime dateTime;

  Weight({required this.weight, required this.dateTime}) {
   this.id =  Random().nextInt(10000);
  }

  Map<String, dynamic> toMap(){
    return {
      'weight' : this.weight,
      'dateTime' : this.dateTime
    };
  }
}