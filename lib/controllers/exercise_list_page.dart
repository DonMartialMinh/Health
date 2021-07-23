
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health/controllers/detail_exercise_card.dart';
import 'package:health/models/exercise.dart';

import 'exercise_card.dart';

class ExerciseListPage extends StatefulWidget {
  String kind;
  String category;
  String title;
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "";

  ExerciseListPage({required this.kind,required this.category, required this.title});

  @override
  State <StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }

}
@override
class _MyAppState extends State<ExerciseListPage> {

  Widget build(BuildContext context) {
    double _cardWidth = MediaQuery.of(context).size.width ;
    // TODO: implement build
    return SafeArea(child: Scaffold (
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          //leading: widget._isSearching ? const BackButton() : Container(),
          title: widget._isSearching ? _buildSearchField() : Text('${this.widget.title}'),
          actions: _buildActions(),
        ),
        body: Container(
          //height: 230,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(widget.kind)
                .where('difficult', isEqualTo: widget.category)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (!streamSnapshot.hasData) {
                return Container();
              }
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 30),
                scrollDirection: Axis.vertical,
                itemCount:  streamSnapshot.data!.docs.length,
                itemBuilder: (ctx, index) =>
                (streamSnapshot.data!.docs[index]['title'].toLowerCase().contains(widget.searchQuery.trim().toLowerCase())) ? Container(
                  margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: ExerciseCard(
                    exercise: new Exercise(
                      title: streamSnapshot.data!.docs[index]['title'],
                      time: streamSnapshot.data!.docs[index]['time'],
                      difficult: streamSnapshot.data!.docs[index]['difficult'],
                      image: streamSnapshot.data!.docs[index]['image'],
                      effect: streamSnapshot.data!.docs[index]['effect'],
                      caution: streamSnapshot.data!.docs[index]['caution'],
                      steps: streamSnapshot.data!.docs[index]['steps'].cast<String>(),
                    ),
                    imageWidth: _cardWidth,
                  ),
                ) : Container(),
              );
            },
          ),
        )
    ));
  }
  Widget _buildSearchField() {
    return TextField(
      controller: widget._searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 20.0),
      onChanged: (query) => update(query),
    );
  }

  List<Widget> _buildActions() {
    if (widget._isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (widget._searchQueryController == null ||
                widget._searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      widget._isSearching = true;
    });
  }

  void update(String newQuery) {
    if (newQuery != widget.searchQuery)
      {
        setState(() {
          widget.searchQuery = newQuery;
          //updateList(newQuery);
        });
      }
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      widget._isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      widget._searchQueryController.clear();
      update("");
    });
  }
}

