
import 'dart:math';

class Ads {
  late int id;
  String name;
  String content;
  String price;
  String image;
  String url;

  Ads({required this.name, required this.content, required this.price, required this.image, required this.url}){
  this.id = Random().nextInt(1000);
  }
}