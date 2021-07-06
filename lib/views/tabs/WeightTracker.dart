import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health/controllers/Header.dart';
import 'package:health/models/weight.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


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
  double _desireWeight = 0.0;
  late TextEditingController _controller;
  DateTime _currentDate =  DateTime.now();
  final firebaseUser = FirebaseAuth.instance.currentUser;
  List<Weight> _list = [];
  late TooltipBehavior _tooltipBehavior;

  double roundDouble(double value, int places){
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  Future<void> _addToList(Weight weight) async {
    await FirebaseFirestore.instance.collection('User').doc(firebaseUser!.uid)
        .collection('WeightHistory').doc('${weight.id}').set(weight.toMap());
    _getCurrentWeight();
  }

  Future<void> _updateWeight(String id , double weight, DateTime dateTime) async {
    await FirebaseFirestore.instance.collection('User').doc(firebaseUser!.uid)
        .collection('WeightHistory').doc('$id').update({
      'weight' : weight,
      'dateTime' : dateTime
    });
    _getCurrentWeight();
  }

  Future<void> _updateDesireWeight(double weight) async {
    await FirebaseFirestore.instance.collection('User')
        .doc(firebaseUser!.uid).update({
      'desireWeight' : weight,
    });
    _getDesireWeight();
  }

  Future<void> _removeFromList(String id) async {
    await FirebaseFirestore.instance.collection('User').doc(firebaseUser!.uid)
        .collection('WeightHistory').doc('$id').delete();
    _getCurrentWeight();
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

  Future<void> _getCurrentWeight() async {
    _list.clear();
    final query = FirebaseFirestore.instance
        .collection("User")
        .doc(firebaseUser!.uid)
        .collection('WeightHistory')
        .orderBy('dateTime', descending: true);

    await query.get().then((QuerySnapshot snapshot) async {
      setState(() {
        if (snapshot.docs.isEmpty == false)
          {
            this._currentWeight = snapshot.docs[0]['weight'];
            this._currentWeightTime = snapshot.docs[0]['dateTime'].toDate();
            snapshot.docs.forEach((element) {
              _list.add(new Weight(weight: element['weight'], dateTime: element['dateTime'].toDate()));
            });
          }
        else {
          this._currentWeight = 0.0;
          this._currentWeightTime = DateTime.now();
        }
      });
    });
  }

  Future<void> _getDesireWeight() async {
    final document = FirebaseFirestore.instance
        .collection("User")
        .doc(firebaseUser!.uid);

    await document.get().then((snapshot) async {
      setState((){
        this._desireWeight = snapshot.get('desireWeight').toDouble();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _getDesireWeight();
    _getCurrentWeight();
  }

  @override
  Widget build(BuildContext context) {
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
                            Text('CURRENT WEIGHT', style: TextStyle(fontSize: 23),),
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
                        child: GestureDetector(
                          child: Column(
                            children: [
                              Text('DESIRE WEIGHT', style: TextStyle(fontSize: 23),),
                              Text('${this._desireWeight} kg', style: TextStyle(fontSize: 30, color: Colors.pinkAccent),),
                              Text('${(roundDouble((this._desireWeight - this._currentWeight),2)).abs()} kg difference remain', style: TextStyle(fontSize: 18),),
                            ],
                          ),
                          onTap: () => {
                            _controller..text = this._desireWeight.toString(),
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => StatefulBuilder(
                                    builder: (context, setState) {
                                      return AlertDialog(
                                        title: const Text('Desire weight:'),
                                        content: Container(
                                          child: Row (
                                            //mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('Your desire weight:    '),
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
                                            child: const Text('Cancel', style: TextStyle(fontSize: 20 ,color: Colors.pinkAccent),),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              if (_controller.text.isEmpty == false)
                                              {
                                                _updateDesireWeight(double.parse(_controller.text));
                                                _clearData(context);
                                              }
                                            },
                                            child: const Text('Update', style: TextStyle(fontSize: 20, color: Colors.pinkAccent),),
                                          ),
                                        ],
                                      );
                                    }
                                )
                            ),
                          },
                        )
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
                            Text('HISTORY WEIGHT DEVELOPMENT', style: TextStyle(fontSize: 23),),
                            Container(
                              height: 170,
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
                                                                        _openDatePickerWithDate(context, setState, _currentDate);
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
                                                      child: const Text('Cancel', style: TextStyle(fontSize: 20,color: Colors.pinkAccent),),
                                                    ),
                                                    TextButton(
                                                      onPressed: () => {
                                                        _removeFromList(streamSnapshot.data!.docs[index].id),
                                                        Navigator.pop(context),
                                                      },
                                                      child: const Text('OK' ,style: TextStyle( fontSize: 20,color: Colors.pinkAccent),),
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    child: SfCartesianChart(
                      tooltipBehavior: _tooltipBehavior,
                      title: ChartTitle(text:'WEIGHT DEVELOPMENT CHART',textStyle: TextStyle(fontFamily: 'PatrickHand', fontSize: 20)),
                      borderColor: Colors.pink, borderWidth: 1,
                      backgroundColor: Colors.pink[50],
                      primaryXAxis: DateTimeAxis(
                          majorGridLines: MajorGridLines(width: 0),
                          edgeLabelPlacement: EdgeLabelPlacement.shift,
                          intervalType: DateTimeIntervalType.days),
                      series: <ChartSeries< Weight, DateTime>>[
                        LineSeries<Weight, DateTime>(
                          name: 'weight',
                          dataSource: _list,
                          dataLabelSettings: DataLabelSettings(isVisible: true), enableTooltip: true,
                          xValueMapper: (Weight weight, _) => weight.dateTime,
                          yValueMapper: (Weight weight, _) => weight.weight,
                        )
                      ],
                      ),
                    ),
                  Padding(padding: EdgeInsets.only(bottom: 100)),
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

