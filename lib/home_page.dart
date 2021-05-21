import 'package:flutter/material.dart';
import 'Diet.dart';
import 'package:health/Fitness.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _selectedIndex = 0;
  static const Color _colorFit = Colors.red;
  static const Color _colorFood = Colors.green;
  static const Color _colorFavorite = Colors.pink;
  static const Color _colorSettings = Colors.orange;
  static const Color _colorUnknown = Colors.white;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  List<Widget> _widgetOptions = <Widget>[
    Programs(),
    Diet(),
    Text(
      'Go Favorite',
      style: optionStyle,
    ),
    Text(
      'Go Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: const Icon(Icons.accessibility, color: Colors.black,),
        backgroundColor: _colorUnknown,

      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Fitness',
            backgroundColor: _colorFit,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Food',
            backgroundColor: _colorFood,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
            backgroundColor: _colorFavorite,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: _colorSettings,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
