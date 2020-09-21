import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddButtonTemp extends StatelessWidget {
  void initState() {
//    print(anistart);
//    print(aniend);
    print("add");
//    hasPermissions();
  }

  Future<List<String>> fetch() async {
    CollectionReference collectionReference =
        Firestore.instance.collection('food');
    Map<String, dynamic> m = {};
    List<String> temp = [];
    collectionReference.snapshots().listen((snapshot) {
      List data;
      data = snapshot.documents;
      data.forEach((element) {
        m[element.documentID.toString()] = element.data;
        Map<String, dynamic> x = element.data;
        x.forEach((key, value) {
          temp.add(key.toString());
        });
      });
    });
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetch(),
        builder: (context, snapshot) {
          print(snapshot.data.toString());
          return Scaffold(
              appBar: AppBar(title: Text("Search app"), actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch(snapshot.data));
              },
            )
          ]));
        });
  }
}

class DataSearch extends SearchDelegate<String> {
  List<String> food_list = [];
  DataSearch(this.food_list);
  final recent = [
    "bhopal",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
    throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? recent
        : food_list.where((p) => p.toString().toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.location_city),
        title: RichText(
            text: TextSpan(
                text: suggestions[index].substring(0, query.length),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                  text: suggestions[index].substring(query.length),
                  style: TextStyle(color: Colors.grey))
            ])),
      ),
      itemCount: suggestions.length,
    );
    throw UnimplementedError();
  }
}
