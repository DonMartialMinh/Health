
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health/components/detail_exercise_card.dart';
import 'package:health/models/exercise.dart';

import 'fit_image_card.dart';

class ExerciseListPage extends StatefulWidget {
  List<Exercise> list;
  String title;
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "";

  ExerciseListPage({required this.list, required this.title});

  @override
  State <StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }

}
@override
class _MyAppState extends State<ExerciseListPage> {
  List<Widget> generateCard(BuildContext context, double width, List<Exercise> exercises, String filter) {
    List<Widget> _list = [];
    exercises.forEach((exercise) {
      if (exercise.title.toLowerCase().contains(filter.trim().toLowerCase()))
        {
          Widget element = Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: GestureDetector(
              child: FitImageCard(
                exercise: exercise,
                tag: '${exercise.id}',
                imageWidth: width,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return DetailExerciseCard(exercise: exercise, tag: '${exercise.id}',);
                    },
                  ),
                );
              },
            ),
          );
          _list.add(element);
        }
    });
    return _list;
  }

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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: this.generateCard(context, _cardWidth, widget.list, widget.searchQuery
            ),
          ),
          padding: EdgeInsets.only(bottom: 20),
        )
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

