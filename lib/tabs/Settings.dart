import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health/provider/sign_in_provider.dart';
import 'package:provider/provider.dart';
import '../components/Header.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Settings extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
    final user = FirebaseAuth.instance.currentUser;
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Header(
                  'Settings',
                  rightSide: Container(
                    height: 35.0,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    margin: EdgeInsets.only(right: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Text(
                        'User info',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: CircleAvatar(
                      maxRadius: 50,
                      backgroundImage: NetworkImage(user!.photoURL!),
                    ),
                  ),
                ),
                Text('${user.displayName}', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                OutlinedButton.icon(
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Logging Out'),
                        content: const Text('Are you sure want to log out ?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => {
                              provider.logout(),
                              Navigator.pop(context),
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                  icon: FaIcon(FontAwesomeIcons.powerOff, color: Colors.red,),
                  label: Text('Log Out', style: TextStyle(fontSize: 20, color: Colors.black),),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}