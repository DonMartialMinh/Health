import 'package:flutter/material.dart';
import 'package:health/models/food.dart';

var FAKE_FOODS = [
  // Banh my category
  Food(name: 'Banh my thit',
      urlImage: 'https://blog.beemart.vn/wp-content/uploads/2019/09/cach-lam-banh-mi-thit-de-ban-1-e1569653919220.jpg',
      duration: Duration(minutes: 5),
      calorie: 500,
      complexity: Complexity.Simple,
      ingredients: ['Banh my', 'Thit heo', 'Rau cu', 'Nuoc sot', 'Cha lua', 'Pate'],
      category: 'Breakfast'
  ),
  Food(name: 'Banh my trung',
      urlImage: 'https://media-cdn.tripadvisor.com/media/photo-s/0a/8b/d4/11/banh-mi-pate-tr-ng.jpg',
      duration: Duration(minutes: 5),
      calorie: 600,
      complexity: Complexity.Simple,
      ingredients: ['Banh my', 'Trung ga', 'Rau cu', 'Nuoc sot', 'Cha lua', 'Pate'],
      category: 'Breakfast'
  ),
  Food(name: 'Banh my xa xiu',
      urlImage: 'https://static.wixstatic.com/media/c34839_12fb60bc0382498fbf777e084cf9228f~mv2.png/v1/fill/w_561,h_373,al_c,lg_1,q_85/c34839_12fb60bc0382498fbf777e084cf9228f~mv2.webp',
      duration: Duration(minutes: 5),
      calorie: 369,
      complexity: Complexity.Simple,
      ingredients: ['Banh my', 'Thit xa xiu', 'Rau cu', 'Nuoc sot', 'Cha lua', 'Pate'],
      category: 'Breakfast'
  ),
  // Bun thit nuong
  Food(name: 'Bun thit nuong truyen thong',
      urlImage: 'https://www.hoidaubepaau.com/wp-content/uploads/2018/06/bun-thit-nuong.jpg',
      duration: Duration(minutes: 8),
      calorie: 215,
      complexity: Complexity.Medium,
      ingredients: ['Bun tuoi', 'Nuoc mam', 'Rau cu', 'Ot', 'hanh phi', 'Hanh tim', 'Top mo', 'Dua leo'],
      category: 'Lunch'
  ),
  Food(name: 'Bun thit nuong cha ram',
      urlImage: 'https://www.cet.edu.vn/wp-content/uploads/2018/03/bun-thit-nuong-kieu-mien-nam.jpg',
      duration: Duration(minutes: 8),
      calorie: 576,
      complexity: Complexity.Medium,
      ingredients: ['Bun tuoi', 'Nuoc mam', 'Rau cu', 'Ot', 'hanh phi', 'Hanh tim', 'top mo', 'Dua leo', 'Cha ram'],
      category: 'Lunch'
  ),
  // Banh Canh
  Food(name: 'Banh canh gio heo',
      urlImage: 'https://bekhoe.net/wp-content/uploads/2018/07/cach-nau-banh-canh-gio-heo.jpg',
      duration: Duration(minutes: 15),
      calorie: 411,
      complexity: Complexity.Hard,
      ingredients: ['Banh canh tuoi', 'Nuoc mam', 'Rau cu', 'Ot', 'hanh phi', 'Gio Heo', 'top mo', 'Hanh la', 'Nam rom'],
      category: 'Dinner'
  ),
  Food(name: 'Banh canh ca loc',
      urlImage: 'https://monngonchuabenh.com/wp-content/uploads/2019/03/cach-lam-banh-canh-ca-loc-hue.jpg',
      duration: Duration(minutes: 15),
      calorie: 451,
      complexity: Complexity.Hard,
      ingredients: ['Banh canh tuoi', 'Nuoc mam', 'Rau cu', 'Ot', 'hanh phi', 'Ca loc', 'Sa te', 'Hanh la'],
      category: 'Dinner'
  ),
];