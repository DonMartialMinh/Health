import 'package:flutter/material.dart';
import 'package:health/components/Header.dart';

class Section extends StatelessWidget {
  final List<Widget> horizontalList;

  Section({required this.horizontalList});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: this.horizontalList
            ),
          )
        ],
      ),
    );
  }
}

