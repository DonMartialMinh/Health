import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health/components/Header.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:health/models/weight.dart';
import 'package:intl/intl.dart';


class WeightTracker extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WeightTracker();
  }
}

class _WeightTracker extends State<WeightTracker> {
  double _currentWeight = 0.0;
  DateTime _currentWeightTime = DateTime.now();
  double _desireWeight = 67.5;
  late TextEditingController _controller;

  DateTime _currentDate =  DateTime.now();
  final firebaseUser = FirebaseAuth.instance.currentUser;

  List<Weight> _list = [
  ];

  double roundDouble(double value, int places){
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  Future<void> _addToList(Weight weight) async {
    await FirebaseFirestore.instance.collection('User').doc(firebaseUser!.uid)
        .collection('WeightHistory').doc('${weight.id}').set(weight.toMap());
    _getData();
  }

  Future<void> _updateWeight(String id , double weight, DateTime dateTime) async {
    await FirebaseFirestore.instance.collection('User').doc(firebaseUser!.uid)
        .collection('WeightHistory').doc('$id').update({
      'weight' : weight,
      'dateTime' : dateTime
    });
    _getData();
  }

  Future<void> _removeFromList(String id) async {
    await FirebaseFirestore.instance.collection('User').doc(firebaseUser!.uid)
        .collection('WeightHistory').doc('$id').delete();
    _getData();
  }

  void _clearData(BuildContext context) {
    setState(() {
      _controller.clear();
      _currentDate = DateTime.now();
      Navigator.pop(context);
    });
  }

  Future<void> _openDatePicker(BuildContext context, setState) async {
    final DateTime temp = (await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: new DateTime(DateTime.now().year - 1),
        lastDate: new DateTime(DateTime.now().year + 1)))!;
    setState(() {
      _currentDate = temp;
    });
  }

  Future<void> _openDatePickerWithDate(BuildContext context, setState, DateTime datetime) async {
    final DateTime temp = (await showDatePicker(
        context: context,
        initialDate: datetime,
        firstDate: new DateTime(DateTime.now().year - 1),
        lastDate: new DateTime(DateTime.now().year + 1)))!;
    setState(() {
      _currentDate = temp;
    });
  }

  Future<dynamic> _getData() async {
    final query = FirebaseFirestore.instance
        .collection("User")
        .doc(firebaseUser!.uid)
        .collection('WeightHistory')
        .orderBy('dateTime', descending: true).limit(1);

    await query.get().then((QuerySnapshot snapshot) async {
      setState(() {
        if (snapshot.docs.isEmpty == false)
          {
            this._currentWeight = snapshot.docs[0]['weight'];
            this._currentWeightTime = snapshot.docs[0]['dateTime'].toDate();
          }
        else {
          this._currentWeight = 0.0;
          this._currentWeightTime = DateTime.now();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    //_getData();
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(
                    'Weight',
                    rightSide: Container(
                      height: 35.0,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      margin: EdgeInsets.only(right: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: Text(
                          'Tracker',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Row(
                    children: [
                      Container(
                        width: 20,
                      ),
                      Expanded(child: Container(
                        decoration: BoxDecoration(
                          color: Colors.pink[50],
                          border: Border.all(
                            color: Colors.pinkAccent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text('CURRENT WEIGHT', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Text('${this._currentWeight} kg', style: TextStyle(fontSize: 30),),
                            Text('${DateFormat.yMMMd().format(this._currentWeightTime)}', style: TextStyle(fontSize: 18),)
                          ],
                        ),
                      )),
                      Container(
                        width: 15,
                      ),
                      Expanded(child: Container(
                        decoration: BoxDecoration(
                          color: Colors.pink[50],
                          border: Border.all(
                            color: Colors.pinkAccent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text('DESIRE WEIGHT', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Text('${this._desireWeight} kg', style: TextStyle(fontSize: 30, color: Colors.pinkAccent),),
                            Text('${(roundDouble((this._desireWeight - this._currentWeight),2)).abs()} kg difference remain', style: TextStyle(fontSize: 18),),
                          ],
                        ),
                      )),
                      Container(
                        width: 20,
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  Row(
                    children: [
                      Container(
                        width: 20,
                      ),
                      Expanded(child: Container(
                        decoration: BoxDecoration(
                          color: Colors.pink[50],
                          border: Border.all(
                            color: Colors.pinkAccent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text('HISTORY WEIGHT DEVELOPMENT', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Container(
                              height: 200,
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance.collection('User')
                                    .doc(firebaseUser!.uid).collection('WeightHistory')
                                    .orderBy('dateTime', descending: true).snapshots(),
                                builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                                  if (!streamSnapshot.hasData){
                                    return Container();
                                  }
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: streamSnapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onLongPress: () => {
                                            _currentDate = streamSnapshot.data!.docs[index]['dateTime'].toDate(),
                                            _controller..text = streamSnapshot.data!.docs[index]['weight'].toString(),
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) => StatefulBuilder(
                                                    builder: (context, setState) {
                                                      return AlertDialog(
                                                        title: const Text('Update your weight:'),
                                                        content: Container(
                                                          height: 150,
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Row (
                                                                //mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Text('Your weight:    '),
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
                                                              Padding(padding: EdgeInsets.only(top:10)),
                                                              Row (
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Text(DateFormat.yMMMd().format(_currentDate), style: TextStyle(fontSize: 20),),
                                                                  IconButton(
                                                                      icon: Icon(Icons.calendar_today),
                                                                      onPressed: () {
                                                                        _openDatePickerWithDate(context, setState, streamSnapshot.data!.docs[index]['dateTime'].toDate());
                                                                      }
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () => _clearData(context),
                                                            child: const Text('Cancel', style: TextStyle(fontSize: 20 ,color: Colors.pinkAccent),),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              if (_controller.text.isEmpty == false)
                                                              {
                                                                _updateWeight(streamSnapshot.data!.docs[index].id, double.parse(_controller.text), _currentDate);
                                                                _clearData(context);
                                                              }
                                                            },
                                                            child: const Text('OK', style: TextStyle(fontSize: 20, color: Colors.pinkAccent),),
                                                          ),
                                                        ],
                                                      );
                                                    }
                                                )
                                            ),
                                          },
                                          leading: Text('${DateFormat.yMMMd().format(streamSnapshot.data!.docs[index]['dateTime'].toDate())}', style: TextStyle(fontSize: 15)),
                                          title: Center(child: Text('${streamSnapshot.data!.docs[index]['weight']} kg', style: TextStyle(fontSize: 25))),
                                          trailing: IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () => showDialog(
                                                context: context,
                                                builder: (BuildContext context) => AlertDialog(
                                                  title: const Text('Delete'),
                                                  content: const Text('Are you sure want to delete?'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () => Navigator.pop(context, 'Cancel'),
                                                      child: const Text('Cancel', style: TextStyle(color: Colors.pinkAccent),),
                                                    ),
                                                    TextButton(
                                                      onPressed: () => {
                                                        _removeFromList(streamSnapshot.data!.docs[index].id),
                                                        Navigator.pop(context),
                                                      },
                                                      child: const Text('OK', style: TextStyle(color: Colors.pinkAccent),),
                                                    ),
                                                  ],
                                                )
                                            ),
                                          ),
                                        );
                                      }
                                  );
                                },
                              )
                            )
                          ],
                        ),
                      )),
                      Container(
                        width: 20,
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  Center(
                    child: Text('WEIGHT DEVELOPMENT CHART', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width*0.9,
                    height: 300,
                    child: LineChart(
                      LineChartData(
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                              spots: [
                                FlSpot(2, 65.2),
                                FlSpot(3, 63.5),
                                FlSpot(4, 67.8),
                                FlSpot(5, 72.1),
                                FlSpot(6, 75.4),
                                FlSpot(7, 78.4),
                                FlSpot(8, 70.2),
                              ]
                          )
                        ]
                    ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.pinkAccent,
            onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      title: const Text('Add your new weight:'),
                      content: Container(
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row (
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Your current weight:    '),
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
                            Padding(padding: EdgeInsets.only(top:10)),
                            Row (
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(DateFormat.yMMMd().format(_currentDate), style: TextStyle(fontSize: 20),),
                                IconButton(
                                    icon: Icon(Icons.calendar_today),
                                    onPressed: () {
                                      _openDatePicker(context, setState);
                                    }
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => _clearData(context),
                          child: const Text('Cancel', style: TextStyle(fontSize: 20 ,color: Colors.pinkAccent),),
                        ),
                        TextButton(
                          onPressed: () {
                            if (_controller.text.isEmpty == false)
                              {
                                _addToList(new Weight(dateTime: _currentDate, weight: double.parse(_controller.text)));
                                _clearData(context);
                              }
                          },
                          child: const Text('OK', style: TextStyle(fontSize: 20, color: Colors.pinkAccent),),
                        ),
                      ],
                    );
                  }
                )
            ),
          ),
        )
    );
  }
}