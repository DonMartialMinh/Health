import 'package:flutter/material.dart';

class ListComponent extends StatelessWidget {
  String content;
  int index;
  Color color;
  ListComponent ({required this.index, required this.content, required this.color});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      leading: CircleAvatar(
        child: Text('${index + 1}', style: TextStyle(fontSize: 22, color: Colors.white),),
        backgroundColor: color,
      ),
      title: Text(content, style: TextStyle(fontSize: 20,fontFamily: 'PatrickHand'),),
    );
  }
}
