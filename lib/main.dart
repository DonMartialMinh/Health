
import 'package:flutter/material.dart';
import 'views/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Health app",
      theme: ThemeData(
        fontFamily: 'PatrickHand',
      ),
      home: SafeArea(
        child:  HomePage(),
      )
    );
  }
}



