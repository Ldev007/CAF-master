import 'package:flutter/material.dart';
import 'package:firebase_ex/pages/progress.dart';
import 'package:firebase_ex/pages/specialprograms.dart';
import '../styling.dart';
import 'bodyparts.dart';
import 'lastused.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, String title}) : super(key: key);

  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}
//COLOR PROPS
final Color darkPurple = CustomStyle.light_bn_color;

//MULTIPLIER SHORTCUTS
final double vf = CustomStyle.verticalFractions;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 30, right: 20, bottom: 20),
      child: new ListView(
        children: <Widget>[
          Text(
            'Hello',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 30,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child:Text(
              'Prince',
              style: TextStyle(
                // color: Colors.black,
                // fontWeight: FontWeight.w600,
                // fontSize: 40,
                color: darkPurple,
                fontWeight: FontWeight.bold,
                decorationThickness: vf * 0.086,
                decorationColor: darkPurple,
                fontSize: 40,
              ),
            ),
          ),

          progress(),
          // Padding(
          //   padding: EdgeInsets.only(left: 10, top: 20, right: 0, bottom: 5),
          //   child: Text(
          //     'Continue',
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontWeight: FontWeight.w500,
          //       fontSize: 20,
          //     ),
          //   ),
          // ),
          // lastused(),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 20, right: 0, bottom: 5),
            child: Text(
              'Special Programs',
              style: TextStyle(
                color: darkPurple,
                fontWeight: FontWeight.bold,
                decorationThickness: vf * 0.086,
                decorationColor: darkPurple,
                fontSize: 22,
              ),
            ),
          ),
          specialprograms(),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 20, right: 0, bottom: 0),
            child: Text(
              'Area of focus',
              style: TextStyle(
                color: darkPurple,
                fontWeight: FontWeight.bold,
                decorationThickness: vf * 0.086,
                decorationColor: darkPurple,
                fontSize: 22,
              ),
            ),
          ),
          parts(),
        ],
      ),
    );
  }
}
