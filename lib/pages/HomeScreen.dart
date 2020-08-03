import 'package:flutter/material.dart';
import 'package:firebase_ex/pages/progress.dart';
import 'package:firebase_ex/pages/specialprograms.dart';
import 'bodyparts.dart';
import 'lastused.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, String title}) : super(key: key);

  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: new ListView(
        children: <Widget>[
          Text(
            'This week Progress',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          progress(),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 20, right: 0, bottom: 5),
            child: Text(
              'Continue',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
          lastused(),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 20, right: 0, bottom: 5),
            child: Text(
              'Special Programs',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
          specialprograms(),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 20, right: 0, bottom: 0),
            child: Text(
              'Area of focus',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
          parts(),
        ],
      ),
    );
  }
}
