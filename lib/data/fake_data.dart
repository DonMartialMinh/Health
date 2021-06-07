import 'package:health/models/ads.dart';
import 'package:health/models/food.dart';
import 'package:health/models/exercise.dart';
import 'package:health/models/program.dart';
import 'package:health/models/tip.dart';

var FAKE_FOODS = [
  Food(name: 'Butternut Squash Risotto',
      urlImage: 'https://cdn-chbmh.nitrocdn.com/uCHJULoYOybHKDUKzLnqTxCnARqvoiSH/assets/static/optimized/rev-c265b59/wp-content/uploads/2018/06/IMG_7786-2-2000x1333.jpg',
      duration: Duration(minutes: 50),
      calorie: 323,
      youtubeLink: 'https://www.youtube.com/watch?v=-9UU52ubphc',
      complexity: Complexity.Simple,
      ingredients: [
        '500 g butternut squash, cubed',
        '1 tbsp olive oil',
        '1 tbsp balsamic vinegar',
        '10 g butter',
        '1 onion, finely chopped',
        '2 garlic cloves, finely chopped',
        '200 g risotto rice, uncooked weight',
        '30 ml strong booze (rum, whisky, brandy etc)',
        '500 ml vegetable stock',
        '1 bay leaf',
        '1 tsp mixed herbs'
      ],
      category: FoodCategory.Vegetarian,
      steps: [
        'Preheat your oven to 180° Celsius.',
        'Tip the chopped butternut squash onto a baking tray, drizzle the olive oil and balsamic vinegar over the top then get your hands in and mix everything through. Place the baking tray into the oven for 40 minutes.',
        'Meanwhile, heat a large, oven proof pan on a medium heat, add the butter and gently fry the garlic and onions for 5 minutes.',
        'Add the rice and stir through.',
        'Add the shot of booze and simmer for a 1 minute.',
        'Add the stock, mixed herbs and bayleaf, mix through, cover and place into the oven when there is 20 minutes remaining on the clock.',
        'The rice and butternut squash should be ready at the same time. Remove both from the oven, add the squash to the rice pan, mix through and serve immediately.'
      ]
  ),

  Food(name: 'Mexican Fajita Steak and Rice',
      urlImage: 'https://www.isabeleats.com/wp-content/uploads/2018/04/easy-steak-fajitas-small-1-650x650.jpg',
      duration: Duration(minutes: 17),
      calorie: 409,
      complexity: Complexity.Simple,
      youtubeLink: 'https://www.youtube.com/watch?v=5oF2pwVv16k',
      ingredients: [
        '1 tbsp olive oil',
        '1 green pepper, sliced',
        '1 red pepper, sliced',
        '2 red onions, sliced',
        '400 g frying steak or chicken breast, sliced into long strips',
        '2 tbsp Mexican/Cajun/Fajita spice mix',
        '150 g white rice, uncooked weight',
        '1 tbsp tomato puree'
      ],
      category: FoodCategory.NonVegetarian,
      steps: [
        'To start, bring rice (dry weight) to the boil cook according to the directions on the packet.',
        'Heat the olive oil in a large pan or work over a medium heat and add the chopped peppers and onions and fry until brown.',
        'Remove the veg from the pan and add the steak and fry for a couple of minutes or until it is cooked.',
        'Just like you would do with fajitas, add the vegetables back to the pan and mix through with the steak.',
        'Add the spice mix and mix through and cook for a further minute.',
        'Once the rice has cooked, drain it then add it to pan with the meat and vegetables along with the tomato puree and cook, stirring constantly for about a minute. Serve.',
      ]
  ),
];

final List<Program> programs = [
  Program(
      title: 'Beginner start',
      time: '5 min',
      difficult: 'Beginner',
      image: 'assets/images/image005.jpg',
      exercises: [
        Exercise(
          image: 'assets/images/image005.jpg',
          title: 'Plank',
          time: 50,
          difficult: 'Beginner',
        ),
        Exercise(
          image: 'assets/images/image006.jpg',
          title: 'Push up',
          time: 60,
          difficult: 'Beginner',
        ),
        Exercise(
          image: 'assets/images/image002.jpg',
          title: 'Crunches',
          time: 55,
          difficult: 'Beginner',
        ),
      ]
  ),
  Program(
      title: 'Intermediate start',
      time: '10 min',
      difficult: 'Intermediate',
      image: 'assets/images/image011.jpg',
      exercises: [
        Exercise(
          image: 'assets/images/iprogram1.jpeg',
          title: 'Swat',
          time: 120,
          difficult: 'Intermediate',
        ),
        Exercise(
          image: 'assets/images/iprogram2.jpeg',
          title: 'Jumping jacks',
          time: 100,
          difficult: 'Intermediate',
        ),
        Exercise(
          image: 'assets/images/iprogram3.jpeg',
          title: 'Run in place',
          time: 90,
          difficult: 'Intermediate',
        ),
      ]
  )
];

final List<Exercise> exercisesBodyPart = [
  Exercise(
    image: 'assets/images/Arm1.jpeg',
    title: 'Weight lifting',
    time: 150,
    difficult: 'Arm',
  ),
  Exercise(
    image: 'assets/images/Arm2.jpeg',
    title: 'Tricep dips',
    time: 150,
    difficult: 'Arm',
  ),
  Exercise(
    image: 'assets/images/Arm3.jpeg',
    title: 'Bicep curls',
    time: 150,
    difficult: 'Arm',
  ),
  Exercise(
    image: 'assets/images/Arm4.jpeg',
    title: 'Push ups',
    time: 150,
    difficult: 'Arm',
  ),
  Exercise(
    image: 'assets/images/Arm5.jpeg',
    title: 'Side plank with dumbbell raises',
    time: 150,
    difficult: 'Arm',
  ),
  Exercise(
    image: 'assets/images/Arm6.jpeg',
    title: 'Scissors',
    time: 150,
    difficult: 'Arm',
  ),
];

final List<Exercise> exercisesYoga = [
  Exercise(
    image: 'assets/images/Byoga1.jpeg',
    title: 'Cat pose',
    time: 30,
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
    time: 30,
    difficult: 'Beginners',
  ),
  Exercise(
    image: 'assets/images/Byoga3.jpeg',
    title: 'Cow pose',
    time: 30,
    difficult: 'Beginners',
  ),
  Exercise(
    image: 'assets/images/Byoga4.jpeg',
    title: 'Child pose',
    time: 30,
    difficult: 'Beginners',
  ),
  Exercise(
    image: 'assets/images/Iyoga1.jpeg',
    title: 'Boat pose',
    time: 30,
    difficult: 'Intermediate',
  ),
  Exercise(
    image: 'assets/images/Iyoga2.jpeg',
    title: 'Bow pose',
    time: 30,
    difficult: 'Intermediate',
  ),
  Exercise(
    image: 'assets/images/Iyoga3.jpeg',
    title: 'Crane(Crow) pose',
    time: 30,
    difficult: 'Intermediate',
  ),
  Exercise(
    image: 'assets/images/Iyoga4.jpeg',
    title: 'Dolphin Plank pose',
    time: 30,
    difficult: 'Intermediate',
  ),
  Exercise(
    image: 'assets/images/Ayoga1.jpeg',
    title: 'King Pigeon pose',
    time: 30,
    difficult: 'Advanced',
  ),
  Exercise(
    image: 'assets/images/Ayoga2.jpeg',
    title: 'Lord Of The Dance pose',
    time: 30,
    difficult: 'Advanced',
  ),
  Exercise(
    image: 'assets/images/Ayoga3.jpeg',
    title: 'Lotus pose',
    time: 30,
    difficult: 'Advanced',
  ),
  Exercise(
    image: 'assets/images/Ayoga4.jpeg',
    title: 'Peacock pose',
    time: 30,
    difficult: 'Advanced',
  ),
];

final List<Ads> ads = [
  Ads(
    name: 'Whey protein',
    content: 'Muscle enhance',
    price: '1,450,000 đ',
    image: 'https://product.hstatic.net/1000314545/product/suplo-008a-01_master.jpg',
    url: 'https://wheyshop.vn/san-pham/100-whey-gold-standard-5lbs-2-3kg-13-2'
  ),
  Ads(
      name: 'Best BCAA',
      content: 'Muscle enhance',
      price: '750,000 đ',
      image: 'https://product.hstatic.net/1000185761/product/bpi-sports-best-bcaa-100-serv-blueberry_c0ad5bda7d634b5f9aaa490f9303911d_master.jpg',
      url: 'https://wheyshop.vn/san-pham/best-bcaa-60-lan-dung'
  )
];

final List<Tip> tips = [
  Tip(
      title: 'Exercise daily',
      content: 'Exercise daily for at least an hour. You do not have to kill yourself from running, jogging, etc., but you should have some sort of moderate physical activity in your everyday life.',
      image: 'assets/images/tip1.jpeg'
  ),
  Tip(
      title: 'Eat the Right Foods and Portion Each Meal',
      content: 'Fruits and vegetables are the best thing to eat when getting into shape. Try to stay away from sweets.',
      image: 'assets/images/tip2.png'
  ),
  Tip(
      title: 'Keep Track of Calories and Food Intake Per Day',
      content: 'Keeping track of how many calories you eat in a day will be helpful in planning out your physical exercising.Losing weight and striving for a skinnier physique will involve more physical exercise than calories you ingest.',
      image: 'assets/images/tip3.jpeg'
  ),
  Tip(
      title: 'Be Sure to Get Sleep',
      content: 'It is crucial to get enough sleep to recharge the body\'s batteries. Six to eight hours of sleep will keep the body going throughout the day.',
      image: 'assets/images/tip4.jpeg'
  ),
  Tip(
      title: 'Stay Motivated',
      content: 'An important key to being in shape is to set goals and keep a positive mindset. If you stay positive, you will be able to push yourself to get that fit body you\'ve always wanted.',
      image: 'assets/images/tip5.png'
  )
];