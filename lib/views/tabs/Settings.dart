import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health/models/User.dart';
import 'package:health/provider/sign_in_provider.dart';
import 'package:provider/provider.dart';
import 'package:health/controllers/Header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class Setting extends StatefulWidget{
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Setting> {
  final firebaseUser = FirebaseAuth.instance.currentUser;
  late TextEditingController _controller;
  final currentUser _user = new currentUser(
    name: "Anonymous",
    image: "image",
    desireWeight: 0.0,
    dateOfBirth: DateTime.now(),
    height: 1,
    phoneNumber: "0000000000"
  );
  double currentWeight  = 0.0;

  Future<void> _getData() async {
    final document = FirebaseFirestore.instance
        .collection("User")
        .doc(firebaseUser!.uid);

    try {
      await document.get().then((snapshot) async {
        setState((){
          this._user.desireWeight = snapshot.get('desireWeight').toDouble();
          this._user.name = snapshot.get('name').toString();
          this._user.height = snapshot.get('height').toInt();
          this._user.dateOfBirth = snapshot.get('dateOfBirth').toDate();
          this._user.image = snapshot.get('image').toString();
          this._user.phoneNumber = snapshot.get('phoneNumber').toString();
        });
      });
    } on Exception catch (e) {
      print(e); // Only catches an exception of type `Exception`.
    } catch (e) {
      print(e); // Catches all types of `Exception` and `Error`.
    }
  }

  Future<void> _getCurrentWeight() async {
    final query = FirebaseFirestore.instance
        .collection("User")
        .doc(firebaseUser!.uid)
        .collection('WeightHistory')
        .orderBy('dateTime', descending: true).limit(1);

    await query.get().then((QuerySnapshot snapshot) async {
      setState(() {
        if (snapshot.docs.isEmpty == false)
        {
          this.currentWeight = snapshot.docs[0]['weight'];
        }
        else {
          this.currentWeight = 0.0;
        }
      });
    });
  }

  void _clearData(BuildContext context) {
    setState(() {
      _controller.clear();
      Navigator.pop(context);
    });
  }

  Future<void> _updateDateOfBirth(BuildContext context, DateTime datetime) async {
    final DateTime temp = (
       await showDatePicker(
           context: context,
           initialDate: datetime,
           firstDate: new DateTime(DateTime.now().year - 100),
           lastDate: new DateTime(DateTime.now().year + 100)
       )
    )!;
    setState(() {
      this._user.dateOfBirth = temp;
    });
    await FirebaseFirestore.instance.collection('User')
        .doc(firebaseUser!.uid).update({
      'dateOfBirth' : temp,
    });
  }

  Future<void> _updateHeight(double height) async {
    await FirebaseFirestore.instance.collection('User')
        .doc(firebaseUser!.uid).update({
      'height' : height,
    });
    _getData();
  }

  Future<void> _updateGoal(double goal) async {
    await FirebaseFirestore.instance.collection('User')
        .doc(firebaseUser!.uid).update({
      'desireWeight' : goal,
    });
    _getData();
  }

  Future<void> _updateName(String name) async {
    await FirebaseFirestore.instance.collection('User')
        .doc(firebaseUser!.uid).update({
      'name' : name,
    });
    _getData();
  }

  Future<void> _updatePhoneNumber(String phoneNumber) async {
    await FirebaseFirestore.instance.collection('User')
        .doc(firebaseUser!.uid).update({
      'phoneNumber' : phoneNumber,
    });
    _getData();
  }
  
  double roundDouble(double value, int places){
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentWeight();
    _getData();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignInProvider>(context,listen: false);
    final user = FirebaseAuth.instance.currentUser;
    final width = MediaQuery.of(context).size.width;
    final bmi = roundDouble(this.currentWeight/ pow((this._user.height/ 100).toDouble(), 2), 1);
    var bmiColor = Colors.orange[100];
    var bmiKind = "";

    if (bmi > 0.0 && bmi < 18.5) {
      bmiColor = Colors.orange[100];
      bmiKind = "Underweight";
    }else if (bmi >= 18.5 && bmi < 25.0){
      bmiColor = Colors.green[100];
      bmiKind = "Normal";
    }else if (bmi >= 25.0 && bmi < 30.0){
      bmiColor = Colors.orange[400];
      bmiKind = "Overweight";
    }else if (bmi >= 30){
      bmiColor = Colors.red[400];
      bmiKind = "Obese";
    }

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
                      color: Colors.orange,
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
                Text('${user.email}', style: TextStyle(fontSize: 18, color: Colors.black45)),
                OutlinedButton.icon(
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Logging Out'),
                        content: const Text('Are you sure want to log out ?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel', style: TextStyle(fontSize: 20, color: Colors.orange),),
                          ),
                          TextButton(
                            onPressed: () => {
                              provider.logout(),
                              Navigator.pop(context),
                            },
                            child: const Text('OK', style: TextStyle(fontSize: 20,color: Colors.orange),),
                          ),
                        ],
                      ),
                    ),
                  icon: FaIcon(FontAwesomeIcons.powerOff, color: Colors.red,),
                  label: Text('Log Out', style: TextStyle(fontSize: 20, color: Colors.black),),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: (width - 40) * 0.65 ,
                        height: 80.0,
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 45.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Weight',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    '${this.currentWeight} kg',
                                    style: TextStyle(
                                      fontSize: 23.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Height',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '${this._user.height} cm',
                                      style: TextStyle(
                                        fontSize: 23.0,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () => {
                                _controller..text = this._user.height.toString(),
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) => StatefulBuilder(
                                        builder: (context, setState) {
                                          return AlertDialog(
                                            title: const Text('Current height:'),
                                            content: Container(
                                              child: Row (
                                                //mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text('Your current height:    '),
                                                  Container(
                                                    width: 100,
                                                    child: TextField(
                                                      keyboardType: TextInputType.numberWithOptions(
                                                        decimal: true,
                                                        signed: false,
                                                      ),
                                                      inputFormatters: <TextInputFormatter> [
                                                        FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
                                                      ],
                                                      controller: _controller,
                                                      decoration: InputDecoration(
                                                        border: OutlineInputBorder(),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => _clearData(context),
                                                child: const Text('Cancel', style: TextStyle(fontSize: 20 ,color: Colors.orange),),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  if (_controller.text.isEmpty == false)
                                                  {
                                                    _updateHeight(double.parse(_controller.text));
                                                    _clearData(context);
                                                  }
                                                },
                                                child: const Text('Update', style: TextStyle(fontSize: 20, color: Colors.orange),),
                                              ),
                                            ],
                                          );
                                        }
                                    )
                                ),
                              },
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          width: (width - 40) * 0.3,
                          height: 80.0,
                          decoration: BoxDecoration(
                            color: Colors.pink[50],
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Goal',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '${this._user.desireWeight} kg',
                                style: TextStyle(
                                  fontSize: 23.0,
                                  color: Colors.pinkAccent,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () => {
                          _controller..text = this._user.desireWeight.toString(),
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      title: const Text('Goal:'),
                                      content: Container(
                                        child: Row (
                                          //mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Your goal:    '),
                                            Container(
                                              width: 100,
                                              child: TextField(
                                                keyboardType: TextInputType.numberWithOptions(
                                                  decimal: true,
                                                  signed: false,
                                                ),
                                                inputFormatters: <TextInputFormatter> [
                                                  FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                                                ],
                                                controller: _controller,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => _clearData(context),
                                          child: const Text('Cancel', style: TextStyle(fontSize: 20 ,color: Colors.orange),),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            if (_controller.text.isEmpty == false)
                                            {
                                              _updateGoal(double.parse(_controller.text));
                                              _clearData(context);
                                            }
                                          },
                                          child: const Text('Update', style: TextStyle(fontSize: 20, color: Colors.orange),),
                                        ),
                                      ],
                                    );
                                  }
                              )
                          ),
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: bmiColor,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Your BMI is: ", style: TextStyle(fontSize: 20),),
                            Text("$bmi", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                            Text(" ($bmiKind)", style: TextStyle(fontSize: 20),)
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 15)),
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          height: 60,
                          child: Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 38)
                              ),
                              Icon(FontAwesomeIcons.idCard),
                              Padding(
                                  padding: EdgeInsets.only(left: 38)
                              ),
                              Text("${this._user.name}", style: TextStyle(fontSize: 20),),
                            ],
                          ),
                        ),
                        onTap: () => {
                          _controller..text = this._user.name.toString(),
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      title: const Text('Name:'),
                                      content: Container(
                                        child: Row (
                                          //mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Your name:    '),
                                            Container(
                                              width: 150,
                                              child: TextField(
                                                keyboardType: TextInputType.name,
                                                controller: _controller,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => _clearData(context),
                                          child: const Text('Cancel', style: TextStyle(fontSize: 20 ,color: Colors.orange),),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            if (_controller.text.isEmpty == false)
                                            {
                                              _updateName(_controller.text);
                                              _clearData(context);
                                            }
                                          },
                                          child: const Text('Update', style: TextStyle(fontSize: 20, color: Colors.orange),),
                                        ),
                                      ],
                                    );
                                  }
                              )
                          ),
                        },
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 15)),
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          height: 60,
                          child: Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 38)
                              ),
                              Icon(FontAwesomeIcons.calendar),
                              Padding(
                                  padding: EdgeInsets.only(left: 38)
                              ),
                              Text("${DateFormat.yMMMd().format(this._user.dateOfBirth)}", style: TextStyle(fontSize: 20),),
                            ],
                          ),
                        ),
                        onTap: () => {
                          _updateDateOfBirth(context, this._user.dateOfBirth)
                        },
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 15)),
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          height: 60,
                          child: Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 38)
                              ),
                              Icon(FontAwesomeIcons.phone),
                              Padding(
                                  padding: EdgeInsets.only(left: 38)
                              ),
                              Text("${this._user.phoneNumber}", style: TextStyle(fontSize: 20),),
                            ],
                          ),
                        ),
                        onTap: () => {
                          _controller..text = this._user.phoneNumber.toString(),
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      title: const Text('Phone number:'),
                                      content: Container(
                                        child: Row (
                                          //mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Your phone number:    '),
                                            Container(
                                              width: 120,
                                              child: TextField(
                                                keyboardType: TextInputType.numberWithOptions(
                                                  decimal: true,
                                                  signed: false,
                                                ),
                                                inputFormatters: <TextInputFormatter> [
                                                  FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                                                ],
                                                controller: _controller,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => _clearData(context),
                                          child: const Text('Cancel', style: TextStyle(fontSize: 20 ,color: Colors.orange),),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            if (_controller.text.isEmpty == false)
                                            {
                                              _updatePhoneNumber(_controller.text);
                                              _clearData(context);
                                            }
                                          },
                                          child: const Text('Update', style: TextStyle(fontSize: 20, color: Colors.orange),),
                                        ),
                                      ],
                                    );
                                  }
                              )
                          ),
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}