import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:health/views/tabs/Settings.dart';
import 'package:health/views/tabs/WeightTracker.dart';
import '../views/tabs/Foods.dart';
import 'package:health/views/tabs/Fitness.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../views/tabs/SignUp.dart';
import '../provider/sign_in_provider.dart';
import '../views/tabs/Settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  dynamic data;
  int _selectedIndex = 0;
  static const Color _colorFit = Colors.redAccent;
  static const Color _colorFood = Colors.green;
  static const Color _colorFavorite = Colors.pinkAccent;
  static const Color _colorSettings = Colors.orange;
  static List<Widget> _widgetOptions = <Widget>[
    Fitness(),
    Foods(),
    WeightTracker(),
    Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
          child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final provider = Provider.of<GoogleSignInProvider>(context);
              if (provider.isSigningIn) {
                return buildLoading();
              } else if (snapshot.hasData) {
                return Scaffold(
                  body: Center(
                    child: _widgetOptions.elementAt(_selectedIndex),
                  ),
                  /*bottomNavigationBar: BottomNavigationBar(
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
                        label: 'Weight',
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
                  ),*/
                  bottomNavigationBar: CurvedNavigationBar(
                    //backgroundColor: Colors.blueAccent,
                    items: <Widget>[
                      CircleAvatar(
                        backgroundColor: _colorFit,
                        child: Icon(
                          Icons.fitness_center,
                          color: Colors.white,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: _colorFood,
                        child: Icon(
                          Icons.food_bank,
                          color: Colors.white,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: _colorFavorite,
                        child: Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: _colorSettings,
                        child: Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                      ),
                    ],
                    //currentIndex: _selectedIndex,
                    onTap: (index) {
                      _onItemTapped(index);
                      //Handle button tap
                    },
                  ),
                );
              } else {
                return SignUpWidget();
              }
            },
          ),
        ),
      );

  Widget buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          //CustomPaint(painter: BackgroundPainter()),
          Center(child: CircularProgressIndicator()),
        ],
      );
}
