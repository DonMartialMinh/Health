import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health/components/Header.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:health/models/weight.dart';
import 'package:intl/intl.dart';


class WeightTracker extends StatefulWidget {
  double _currentWeight = 60.1;
  double _desireWeight = 67.5;


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WeightTracker();
  }


}

class _WeightTracker extends State<WeightTracker> {
  late TextEditingController _controller;
  DateTime _currentDate =  DateTime.now();
  late String _selectedDate;

  List<Weight> _list = [
  ];

  double roundDouble(double value, int places){
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  void _addToList(String weight, DateTime date) {
    setState(() {
      _list.insert(0, new Weight(weight: double.parse(weight), dateTime: date));
    });
  }

  void _updateWeight(int index, String weight, DateTime date) {
    setState(() {
      _list.removeAt(index);
      _list.insert(index, new Weight(weight: double.parse(weight), dateTime: date));
    });
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

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
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
                            Text('CURRENT WEIGHT', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Text('${widget._currentWeight} kg', style: TextStyle(fontSize: 30),),
                            Text('Date: 10/10/2000', style: TextStyle(fontSize: 18),)
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
                            Text('${widget._desireWeight} kg', style: TextStyle(fontSize: 30, color: Colors.pinkAccent),),
                            Text('${roundDouble((widget._desireWeight - widget._currentWeight),2)} kg to archive your goal', style: TextStyle(fontSize: 18),),
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
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _list.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onLongPress: () => {
                                        _currentDate = _list[index].dateTime,
                                        _controller..text = _list[index].weight.toString(),
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
                                                                    _openDatePickerWithDate(context, setState, _list[index].dateTime);
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
                                                              _updateWeight(index, _controller.text, _currentDate);
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
                                      leading: Text('${DateFormat.yMMMd().format(_list[index].dateTime)}', style: TextStyle(fontSize: 15)),
                                      title: Center(child: Text('${_list[index].weight}kg', style: TextStyle(fontSize: 25))),
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
                                                  setState((){
                                                    _list.removeAt(index);
                                                  }),
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
                              ),
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
                                _addToList(_controller.text, _currentDate);
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