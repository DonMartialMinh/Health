import 'package:health/models/food.dart';
import 'package:health/models/exercise.dart';

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

final List<Exercise> exercisesBodyPart = [
  Exercise(
    image: 'assets/images/Arm1.jpeg',
    title: 'Weight lifting',
    time: '5 min',
    difficult: 'Arm',
  ),
  Exercise(
    image: 'assets/images/Arm2.jpeg',
    title: 'Tricep dips',
    time: '10 min',
    difficult: 'Arm',
  ),
  Exercise(
    image: 'assets/images/Arm3.jpeg',
    title: 'Bicep curls',
    time: '25 min',
    difficult: 'Arm',
  ),
  Exercise(
    image: 'assets/images/Arm4.jpeg',
    title: 'Push ups',
    time: '25 min',
    difficult: 'Arm',
  ),
  Exercise(
    image: 'assets/images/Arm5.jpeg',
    title: 'Side plank with dumbbell raises',
    time: '25 min',
    difficult: 'Arm',
  ),
  Exercise(
    image: 'assets/images/Arm6.jpeg',
    title: 'Scissors',
    time: '25 min',
    difficult: 'Arm',
  ),
];

final List<Exercise> exercisesYoga = [
  Exercise(
    image: 'assets/images/Byoga1.jpeg',
    title: 'Cat pose',
    time: '5 min',
    difficult: 'Beginners',
    effect: 'This pose provides a gentle massage to the spine and belly organs.',
    caution: 'With a neck injury, keep the head in line with the torso.',
    steps: [
      'Start on your hands and knees in a “tabletop” position. Make sure your knees are set directly below your hips and your wrists, elbows and shoulders are in line and perpendicular to the floor. Center your head in a neutral position, eyes looking at the floor.',
      'As you exhale, round your spine toward the ceiling, making sure to keep your shoulders and knees in position. Release your head toward the floor, but don’t force your chin to your chest.',
      'Inhale, coming back to neutral “tabletop” position on your hands and knees.',
      'This pose is often paired with Cow Pose on the inhale for a gentle, flowing vinyasa.'
    ]
  ),
  Exercise(
    image: 'assets/images/Byoga2.jpeg',
    title: 'Cobra pose',
    time: '5 min',
    difficult: 'Beginners',
  ),
  Exercise(
    image: 'assets/images/Byoga3.jpeg',
    title: 'Cow pose',
    time: '5 min',
    difficult: 'Beginners',
  ),
  Exercise(
    image: 'assets/images/Byoga4.jpeg',
    title: 'Child pose',
    time: '5 min',
    difficult: 'Beginners',
  ),
  Exercise(
    image: 'assets/images/Iyoga1.jpeg',
    title: 'Boat pose',
    time: '5 min',
    difficult: 'Intermediate',
  ),
  Exercise(
    image: 'assets/images/Iyoga2.jpeg',
    title: 'Bow pose',
    time: '5 min',
    difficult: 'Intermediate',
  ),
  Exercise(
    image: 'assets/images/Iyoga3.jpeg',
    title: 'Crane(Crow) pose',
    time: '5 min',
    difficult: 'Intermediate',
  ),
  Exercise(
    image: 'assets/images/Iyoga4.jpeg',
    title: 'Dolphin Plank pose',
    time: '5 min',
    difficult: 'Intermediate',
  ),
  Exercise(
    image: 'assets/images/Ayoga1.jpeg',
    title: 'King Pigeon pose',
    time: '5 min',
    difficult: 'Advanced',
  ),
  Exercise(
    image: 'assets/images/Ayoga2.jpeg',
    title: 'Lord Of The Dance pose',
    time: '5 min',
    difficult: 'Advanced',
  ),
  Exercise(
    image: 'assets/images/Ayoga3.jpeg',
    title: 'Lotus pose',
    time: '5 min',
    difficult: 'Advanced',
  ),
  Exercise(
    image: 'assets/images/Ayoga4.jpeg',
    title: 'Peacock pose',
    time: '5 min',
    difficult: 'Advanced',
  ),
];