import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:health/views/tabs/Settings.dart';
import 'package:health/views/tabs/WeightTracker.dart';
import 'package:introduction_screen/introduction_screen.dart';
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
                  ),
                  /*bottomNavigationBar: CurvedNavigationBar(
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
                  ),*/
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

// class OnBoardingPage extends StatefulWidget {
//   @override
//   _OnBoardingPageState createState() => _OnBoardingPageState();
// }

// class _OnBoardingPageState extends State<OnBoardingPage> {
//   final introKey = GlobalKey<IntroductionScreenState>();
//
//   void _onIntroEnd(context) {
//     Navigator.of(context).push(
//       MaterialPageRoute(builder: (context) => Scaffold(body: SignUpWidget(),)),
//     );
//   }
//
//   Widget _buildImage(String assetName, [double width = 350]) {
//     return Image.asset('assets/images/$assetName', width: width);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const bodyStyle = TextStyle(fontSize: 19.0);
//
//     const pageDecoration = const PageDecoration(
//       titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
//       bodyTextStyle: bodyStyle,
//       descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
//       pageColor: Colors.white54,
//       imagePadding: EdgeInsets.zero,
//     );
//
//     return IntroductionScreen(
//       key: introKey,
//       globalBackgroundColor: Colors.white,
//       globalHeader: Align(
//         alignment: Alignment.topRight,
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.only(top: 16, right: 16),
//             child: _buildImage('appicon.png', 100),
//           ),
//         ),
//       ),
//       globalFooter: SizedBox(
//         width: double.infinity,
//         height: 60,
//         child: ElevatedButton(
//           child: const Text(
//             'Let\s go right away!',
//             style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//           ),
//           onPressed: () => _onIntroEnd(context),
//         ),
//       ),
//       pages: [
//         PageViewModel(
//           title: "Fractional shares",
//           body:
//           "Instead of having to buy an entire share, invest any amount you want.",
//           image: _buildImage('fitness.png'),
//           decoration: pageDecoration,
//         ),
//         PageViewModel(
//           title: "Learn as you go",
//           body:
//           "Download the Stockpile app and master the market with our mini-lesson.",
//           image: _buildImage('food.jpeg'),
//           decoration: pageDecoration,
//         ),
//         PageViewModel(
//           title: "Kids and teens",
//           body:
//           "Kids and teens can track their stocks 24/7 and place trades that you approve.",
//           image: _buildImage('bmi.png'),
//           decoration: pageDecoration,
//         ),
//         PageViewModel(
//           title: "Title of last page - reversed",
//           bodyWidget: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [
//               Text("Click on ", style: bodyStyle),
//               Icon(Icons.edit),
//               Text(" to edit a post", style: bodyStyle),
//             ],
//           ),
//           decoration: pageDecoration.copyWith(
//             bodyFlex: 2,
//             imageFlex: 4,
//             bodyAlignment: Alignment.bottomCenter,
//             imageAlignment: Alignment.topCenter,
//           ),
//           image: _buildImage('bmi.png'),
//           reverse: true,
//         ),
//       ],
//       onDone: () => _onIntroEnd(context),
//       //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
//       showSkipButton: true,
//       skipFlex: 0,
//       nextFlex: 0,
//       //rtl: true, // Display as right-to-left
//       skip: const Text('Skip'),
//       next: const Icon(Icons.arrow_forward),
//       done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
//       curve: Curves.fastLinearToSlowEaseIn,
//       controlsMargin: const EdgeInsets.all(16),
//       controlsPadding: kIsWeb
//           ? const EdgeInsets.all(12.0)
//           : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
//       dotsDecorator: const DotsDecorator(
//         size: Size(10.0, 10.0),
//         color: Color(0xFFBDBDBD),
//         activeSize: Size(22.0, 10.0),
//         activeShape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(25.0)),
//         ),
//       ),
//       dotsContainerDecorator: const ShapeDecoration(
//         color: Colors.white54,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(8.0)),
//         ),
//       ),
//     );
//   }
// }
