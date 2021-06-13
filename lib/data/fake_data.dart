import 'package:health/models/ads.dart';
import 'package:health/models/food.dart';
import 'package:health/models/exercise.dart';
import 'package:health/models/program.dart';
import 'package:health/models/tip.dart';

var FAKE_FOODS = [
  Food(
      name: 'Butternut Squash Risotto',
      urlImage: 'https://www.chewoutloud.com/wp-content/uploads/2015/11/butternut-risotto.jpg',
      duration: 50,
      calorie: 323,
      youtubeLink: 'https://www.youtube.com/watch?v=-9UU52ubphc',
      complexity: 'Simple',
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
      category: 'Vegetarian',
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

  Food(
      name: 'Mexican Fajita Steak and Rice',
      urlImage: 'https://www.isabeleats.com/wp-content/uploads/2018/04/easy-steak-fajitas-small-1-650x650.jpg',
      duration:  17,
      calorie: 409,
      complexity: 'Simple',
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
      category: 'NonVegetarian',
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