import 'package:firebase_ex/pages/progress.dart';
import 'package:firebase_ex/pages/specialprograms.dart';
import 'package:flutter/material.dart';

import 'bodyparts.dart';
import 'lastused.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, String title}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> selections = [true, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
//          appBar: AppBar(
//            elevation: 0,
//            backgroundColor: Colors.white24,
//            titleSpacing: 300,
//            title: IconButton(
//              onPressed: () =>
//                  Navigator.pushNamed(context, '/profile_page'),
//              icon: Icon(
//                Icons.account_circle,
//                color: Colors.black,
//              ),
//            ),
//          ),
          body: Stack(
            children: <Widget>[
              Padding(
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
                        padding: EdgeInsets.only(
                            left: 10, top: 20, right: 0, bottom: 5),
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
                        padding: EdgeInsets.only(
                            left: 10, top: 20, right: 0, bottom: 5),
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
                        padding: EdgeInsets.only(
                            left: 10, top: 20, right: 0, bottom: 0),
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
                  )),
              Align(
                alignment: Alignment(0, 0.92),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                  ),
                  child: ToggleButtons(
                    selectedBorderColor: Colors.transparent,
                    fillColor: Colors.transparent,
                    borderColor: Colors.transparent,
                    onPressed: (int index) {
                      setState(() {
                        if (index == 0) {
                          selections[1] = false;
                          selections[2] = false;
                          selections[3] = false;
                          selections[4] = false;
                        } else if (index == 1) {
                          selections[0] = false;
                          selections[2] = false;
                          selections[3] = false;
                          selections[4] = false;
                        } else if (index == 2) {
                          selections[0] = false;
                          selections[1] = false;
                          selections[3] = false;
                          selections[4] = false;
                        } else if (index == 3) {
                          selections[0] = false;
                          selections[1] = false;
                          selections[2] = false;
                          selections[4] = false;
                        } else {
                          selections[0] = false;
                          selections[1] = false;
                          selections[2] = false;
                          selections[3] = false;
                        }
                      });
                    },
                    isSelected: selections,
                    children: <Widget>[
                      IconButton(
                        onPressed: () => null,
                        icon: Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () => null,
                        icon: Icon(
                          Icons.restaurant,
                          //Icons.local_dining,//Icons.free_breakfast,//Icons.fastfood,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/profile_page'),
                        icon: Icon(
                          Icons.trending_up,
                          //Icons.show_chart,//Icons.score,//Icons.fitness_center,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/tracker'),
                        icon: Icon(
                          Icons.equalizer, //Icons.assessment,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/profile_page'),
                  icon: Icon(
                    Icons.account_circle,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}