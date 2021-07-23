import 'package:health/components/Header.dart';
import 'package:health/components/tab_view_base.dart';
import 'package:flutter/material.dart';

class Foods extends StatelessWidget {
  final String _tabVet = "Vegetarian";
  final String _tabNonVet = "NonVegetarian";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              flexibleSpace: Header(
                'Food',
                rightSide: Container(
                  height: 35.0,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  margin: EdgeInsets.only(right: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: Text(
                      'Supporter',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
              bottom: TabBar(
                tabs: <Widget>[
                  Container(
                    height: 30.0,
                    child: Tab(
                      text: _tabNonVet,
                    ),
                  ),
                  Container(
                    height: 30.0,
                    child: Tab(
                      text: _tabVet,
                    ),
                  ),
                ],
                labelColor: Colors.black87,
                unselectedLabelColor: Colors.grey[400],
                indicatorWeight: 4.0,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Color.fromRGBO(215, 225, 255, 1.0),
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                TabViewBase(
                  tabName: _tabNonVet,
                ),
                TabViewBase(
                  tabName: _tabVet,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}