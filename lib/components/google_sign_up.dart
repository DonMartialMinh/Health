import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health/provider/sign_in_provider.dart';
import 'package:provider/provider.dart';


class GoogleSignUp extends StatelessWidget{

  Future<void> login(BuildContext context) async {
    final provider = Provider.of<GoogleSignInProvider> (context, listen: false);
    await provider.login();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(20),
      child: OutlinedButton.icon(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
        onPressed: (){
          login(context);
        },
        icon: FaIcon(FontAwesomeIcons.google, color: Colors.red,),
        label: Text('Connect to Google account', style: TextStyle(fontSize: 20, color: Colors.black),),
    )
    );
  }
}