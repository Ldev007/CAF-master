import 'dart:math' as Math;
import 'dart:ui';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/LeaderBoard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'styling.dart';
import 'package:fit_kit/fit_kit.dart';

class CircleProgressBar extends StatefulWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final double value;

  CircleProgressBar({
    Key key,
    this.backgroundColor,
    @required this.foregroundColor,
    @required this.value,
  }) : super(key: key);
  final double x = 0.4;

  _CircleProgressBarState createState() => _CircleProgressBarState(
      foregroundColor: this.foregroundColor, value: this.value);
}

class _CircleProgressBarState extends State<CircleProgressBar>
    with TickerProviderStateMixin {
  final Color backgroundColor;
  final Color foregroundColor;
  final double value;
  double anistart = 0.0;
  double aniend = 0.0;
  static Animation<double> anime;
  static AnimationController animeCont;
  static int dur_min = 32;
  static int dur_sec = 50;
  Map<DataType, List<FitData>> results = Map();
  DateTime now = DateTime.now();
  bool permissions = true;
  String result = '';
  double steps = 0;
  double total = 1000;
  String uid = "";
  double calories = 0.0;
  double targetcal = 2000;
  bool paint = false;

  //Leaderboard
  var dat=[110,130,125,80,50];
  var len = 0;
  var axis =[0.0];
  var points=[DataPoint<double>(value: 0),];

  @override
  void initState() {
    super.initState();
    print("tracker");
    read();
  }

  hasPermissions() async {
    try {
      permissions = await FitKit.hasPermissions(DataType.values);
    } catch (e) {
      result = 'hasPermissions: $e';
    }

    if (!mounted) return;

    setState(() {});
  }

  read() async {
    results.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString("uid");
    DocumentSnapshot ds =
        await Firestore.instance.collection('UserData').document(uid).get();
    calories += ds.data['calories'];
//    print("read"+" "+now.toString()+"    "+DateTime(now.year, now.month, now.day).toString()+"==========");
//    print("inside read");
    try {
      permissions = await FitKit.requestPermissions(DataType.values);
//      print("permissions"+permissions.toString());
      if (!permissions) {
        result = 'requestPermissions: failed';
      } else {
        for (DataType type in DataType.values) {
          try {
            results[type] = await FitKit.read(
              type,
              dateFrom: DateTime(now.year, now.month, now.day),
              dateTo: now,
            );
          } on UnsupportedException catch (e) {
            results[e.dataType] = [];
          }
        }

        result = 'readAll: success';
      }
    } catch (e) {
      result = 'readAll: $e';
    }
    bool docount = false;
    double testcount = 0;
    final items =
        results.entries.expand((entry) => [entry.key, ...entry.value]).toList();
    items.forEach((element) {
      if (element is DataType) {
//        print("=================="+element.toString()+"============================");
        if (element == DataType.STEP_COUNT) {
          docount = true;
          testcount = 0;
        } else {
          docount = false;
        }
      } else if (element is FitData) {
//        print(element.value.runtimeType);
        if (docount) {
          testcount = testcount + element.value;
        }
      }
    });
    double x=(int.parse(testcount.toString()[0])+1)*1000.toDouble();

    setState(() {
//      print("testcount"+testcount.toString());
      //targetcal=+300;
      calories = calories + (testcount * 0.04);
      targetcal=(int.parse(calories.toString()[0])+2)*100.toDouble();
      total=x;
      steps = testcount / x;
//      print("steps"+steps.toString());
      _animation(testcount);
    });

//    final item = items[index];
  }

  _animation(testcount) {
//    print("tracker       "+steps.toString());
    print("calories" + calories.toString());
    double x = 0.0;
    x = steps;
//  print("eygugcyu7wq"+anime.value.toString());
    animeCont =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    anime = Tween<double>(begin: 0, end: steps).animate(animeCont)
      ..addListener(() {
        setState(() {});
      });
//  print(anime.value);

    setState(() {
      paint = true;
    });
    animeCont.forward();
    updatesteps(testcount);
  }

  updatesteps(testcount) async {
    CollectionReference collectionReference =
        Firestore.instance.collection('UserData');
    collectionReference.document(uid).updateData({'Steps': testcount});
    DocumentReference ds = collectionReference
        .document(uid)
        .collection('excercise')
        .document('steps');
    DateTime dda = DateTime(now.year, now.month, now.day);
    var fulldate = DateTime.parse(dda.toString());
//    print(moonLanding.month);
    var month = fulldate.month;
    var date = fulldate.day;
    var year = fulldate.year;
    ds.setData({
      year.toString(): {
        month.toString(): {date.toString(): testcount}
      }
    },merge:true);



    var xaxis =[0.0];
    var data=[DataPoint<double>(value: 0),];


    DocumentSnapshot dsnap = await Firestore.instance.collection('UserData').document(uid)
        .collection('excercise')
        .document('steps').get();
    var stepsdata= dsnap.data[year.toString()][month.toString()];
//    print(test);
    stepsdata.forEach((element,value) {
      data.add(DataPoint<double>(value: value.toDouble()));
      len=len+2;
      xaxis.add(len.toDouble());
//      print(element);
    });
//    print(xaxis);
//    print(data);
    setState(() {
      axis = xaxis;
      points=data;
    });
  }

  _CircleProgressBarState({
    this.backgroundColor,
    @required this.foregroundColor,
    @required this.value,
  }) : super();

  String title = "TRACK";

  @override
  Widget build(BuildContext context) {
    final backgroundColor = this.backgroundColor;
    final foregroundColor = this.foregroundColor;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: CustomStyle.verticalFractions * 3.236),
          //30
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color.fromRGBO(192, 196, 228, 1),
                Color.fromRGBO(141, 148, 206, 1),
                Color.fromRGBO(38, 53, 95, 1),
                Color.fromRGBO(28, 39, 69, 1),
              ],
            ),
          ),
          // color: Color.fromRGBO(48, 67, 120, 0.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: CustomStyle.verticalFractions * 2.157), //20
                child: Row(
                  children: <Widget>[
//                    Icon(Icons.menu, color: Colors.blue),
                    SizedBox(width: CustomStyle.verticalFractions * 17.2), //125
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: CustomStyle.verticalFractions * 2.696, //25
                        color: CustomStyle.light_bn_color,
                        letterSpacing:
                            CustomStyle.verticalFractions * 0.323, //3.0
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(48, 67, 120, 0.4)),
                      child: OutlineButton(
                        color: Colors.white70,
                        shape: CircleBorder(side: BorderSide()),
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              CustomStyle.verticalFractions * 2.157, //20
                          vertical: CustomStyle.verticalFractions * 2.157, //20
                        ),
                        child: Icon(Icons.calendar_today,
                            color: Color.fromRGBO(192, 196, 228, 1)),
                        onPressed: () {
//                          print('Calendar Button pressed');
                        },
                      ),
                    ),
                    CustomPaint(
                            child: Container(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width * 0.40,
                              height: MediaQuery.of(context).size.height * 0.4,
                            ),
                            foregroundPainter: CircleProgressBarPainter(
                              backgroundColor: backgroundColor,
                              foregroundColor: foregroundColor,
                              percentage: paint ? anime.value : 0.0,
                            ),
                          ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(48, 67, 120, 0.4)),
                      child: OutlineButton(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              CustomStyle.verticalFractions * 2.157, //20
                          vertical: CustomStyle.verticalFractions * 2.157, //20
                        ),
                        onPressed: () {
//                          print('Location Button Pressed');
                        },
                        shape: CircleBorder(side: BorderSide()),
                        child: Icon(Icons.location_on,
                            color: Color.fromRGBO(192, 196, 228, 1)),
                        color: Color.fromRGBO(48, 67, 120, 0.2),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(48, 67, 120, 0.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(
                                    width: CustomStyle.verticalFractions *
                                        1.078), //10
                                Icon(
                                  Icons.fiber_manual_record,
                                  color: Color.fromRGBO(192, 196, 228, 0.5),
                                  size: CustomStyle.verticalFractions *
                                      2.157, //20
                                ),
                                SizedBox(
                                    width: CustomStyle.verticalFractions *
                                        2.157), //20
                                Text(
                                  'Calories Burned',
                                  style: TextStyle(
                                    color: Color.fromRGBO(192, 196, 228, 0.5),
                                    fontSize: CustomStyle.verticalFractions *
                                        2.804, //26
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    CustomStyle.verticalFractions * 2.157), //20
                            Padding(
                              padding: EdgeInsets.only(
                                  right: CustomStyle.verticalFractions *
                                      2.157), //20
                              child: Text(
                                calories.toStringAsPrecision(5)+' cal',
                                style: TextStyle(
                                  fontSize: CustomStyle.verticalFractions *
                                      3.236, //30
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.fiber_manual_record,
                                  color: Color.fromRGBO(192, 196, 228, 0.5),
                                  size: CustomStyle.verticalFractions *
                                      2.157, //20
                                ),
                                SizedBox(
                                    width: CustomStyle.verticalFractions *
                                        1.078), //10
                                Text(
                                  'Target CALORIES',
                                  style: TextStyle(
                                    color: Color.fromRGBO(192, 196, 228, 0.5),
                                    fontSize: CustomStyle.verticalFractions *
                                        2.804, //26
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                                height:
                                    CustomStyle.verticalFractions * 2.157), //20
                            Padding(
                              padding: EdgeInsets.only(
                                  right: CustomStyle.verticalFractions *
                                      7.011), //65
                              child: Text(
                                '$targetcal kcal',
                                style: TextStyle(
                                  fontSize: CustomStyle.verticalFractions *
                                      3.236, //30
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Color.fromRGBO(0, 0, 0, 0.0),
                        padding: EdgeInsets.symmetric(
                          vertical: CustomStyle.verticalFractions * 1.078, //10
                        ),
                        height: CustomStyle.verticalFractions * 16.181,
                        //150
                        width: CustomStyle.verticalFractions * 21.574,
                        //200
                        child: Leaderboard(
                          steps: 55,
                          dataf:points,
                          xaxiss:axis,
                        ),
                      ),
                    ),
//                    SizedBox(width: CustomStyle.verticalFractions * 1.078), //10
//                    Expanded(
//                      flex: 1,
//                      child: Container(
//                        color: Color.fromRGBO(0, 0, 0, 0.0),
//                        padding: EdgeInsets.symmetric(
//                          vertical: CustomStyle.verticalFractions * 1.078, //10
//                        ),
//                        height: CustomStyle.verticalFractions * 16.181, //150
//                        width: CustomStyle.verticalFractions * 21.574, //200
//                        child: Leaderboard(
//                          steps: 55,
//                          width: 150,
//                        ),
//                      ),
//                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              //BOTTOM WIDGET
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Row(
                    children: <Widget>[
//                      Padding(
//                        padding: EdgeInsets.only(left: 10),
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            OutlineButton(
//                              color: Colors.transparent,
//                              onPressed: () {
//                                print('EDIT button clicked');
//                              },
//                              child: Text(
//                                'EDIT',
//                                style: TextStyle(
//                                    fontSize: 15,
//                                    color: Colors.blue60,
//                                    letterSpacing: 1.5),
//                              ),
//                            ),
//                            OutlineButton(
//                              color: Colors.grey[500],
//                              onPressed: () {
//                                print('Plus button clicked');
//                              },
//                              child: Icon(Icons.add, color: Colors.blue60),
//                            )
//                          ],
//                        ),
//                      ),
//                      Expanded(
//                        flex: 1,
//                        child: ListView(
//                          padding: EdgeInsets.symmetric(
//                              horizontal:
//                                  CustomStyle.verticalFractions * 2.157), //20
//                          scrollDirection: Axis.horizontal,
//                          children: <Widget>[
//                            Container(
//                              margin: EdgeInsets.symmetric(
//                                  horizontal: CustomStyle.verticalFractions *
//                                      1.078), //10
//                              decoration: BoxDecoration(
//                                color: Color.fromRGBO(192, 196, 228, 0.35),
//                                borderRadius: BorderRadius.circular(10),
//                              ),
//                              child: OutlineButton(
//                                shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(
//                                      CustomStyle.verticalFractions *
//                                          1.078), //10
//                                ),
//                                padding: EdgeInsets.only(
//                                  top: CustomStyle.verticalFractions *
//                                      1.078, //10
//                                ),
//                                onPressed: () {
//                                  print('LV Button Pressed');
//                                  setState(() {
//                                    title = "RUNNING";
//                                  });
//                                },
//                                child: Column(
//                                  mainAxisAlignment:
//                                      MainAxisAlignment.spaceBetween,
//                                  children: <Widget>[
//                                    Icon(Icons.crop_free),
//                                    Container(
//                                      decoration: BoxDecoration(
//                                        color: Colors.yellow,
//                                        borderRadius: BorderRadius.only(
//                                          bottomLeft: Radius.circular(
//                                              CustomStyle.verticalFractions *
//                                                  32.362), //300
//                                          bottomRight: Radius.circular(
//                                              CustomStyle.verticalFractions *
//                                                  32.362), //300
//                                        ),
//                                      ),
//                                      width: CustomStyle.verticalFractions *
//                                          9.169, //85
//                                      height: CustomStyle.verticalFractions *
//                                          0.539, //5
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            ),
//                            Container(
//                              decoration: BoxDecoration(
//                                color: Color.fromRGBO(192, 196, 228, 0.35),
//                                borderRadius: BorderRadius.circular(
//                                    CustomStyle.verticalFractions * 1.078), //10
//                              ),
//                              margin: EdgeInsets.symmetric(
//                                  horizontal: CustomStyle.verticalFractions *
//                                      1.078), //10
//                              child: OutlineButton(
//                                shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(
//                                      CustomStyle.verticalFractions *
//                                          1.078), //10
//                                ),
//                                padding: EdgeInsets.only(
//                                    top: CustomStyle.verticalFractions *
//                                        1.078), //10
//                                onPressed: () {
//                                  print('LV Button Pressed');
//                                  setState(() {
//                                    title = "CHEST";
//                                  });
//                                },
//                                child: Column(
//                                  mainAxisAlignment:
//                                      MainAxisAlignment.spaceBetween,
//                                  children: <Widget>[
//                                    Icon(Icons.crop_free),
//                                    Container(
//                                      decoration: BoxDecoration(
//                                        color: Colors.orange[300],
//                                        borderRadius: BorderRadius.only(
//                                          bottomLeft: Radius.circular(
//                                              CustomStyle.verticalFractions *
//                                                  32.362), //300
//                                          bottomRight: Radius.circular(
//                                              CustomStyle.verticalFractions *
//                                                  32.362), //300
//                                        ),
//                                      ),
//                                      width: CustomStyle.verticalFractions *
//                                          9.169, //85
//                                      height: CustomStyle.verticalFractions *
//                                          0.539, //5
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            ),
//                            Container(
//                              decoration: BoxDecoration(
//                                color: Color.fromRGBO(192, 196, 228, 0.35),
//                                borderRadius: BorderRadius.circular(
//                                    CustomStyle.verticalFractions * 1.078), //10
//                              ),
//                              margin: EdgeInsets.symmetric(
//                                  horizontal: CustomStyle.verticalFractions *
//                                      1.078), //10
//                              child: OutlineButton(
//                                shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(
//                                      CustomStyle.verticalFractions *
//                                          1.078), //10
//                                ),
//                                padding: EdgeInsets.only(
//                                  top: CustomStyle.verticalFractions *
//                                      1.078, //10
//                                ),
//                                onPressed: () {
//                                  print('LV Button Pressed');
//                                  setState(() {
//                                    title = "BACK";
//                                  });
//                                },
//                                child: Column(
//                                  mainAxisAlignment:
//                                      MainAxisAlignment.spaceBetween,
//                                  children: <Widget>[
//                                    Icon(Icons.crop_free),
//                                    Container(
//                                      decoration: BoxDecoration(
//                                        color: Colors.red[300],
//                                        borderRadius: BorderRadius.only(
//                                          bottomLeft: Radius.circular(
//                                            CustomStyle.verticalFractions *
//                                                32.362, //300
//                                          ),
//                                          bottomRight: Radius.circular(
//                                            CustomStyle.verticalFractions *
//                                                32.362, //300
//                                          ),
//                                        ),
//                                      ),
//                                      width: CustomStyle.verticalFractions *
//                                          9.169, //85
//                                      height: CustomStyle.verticalFractions *
//                                          0.539, //5
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            ),
//                            Container(
//                              decoration: BoxDecoration(
//                                color: Color.fromRGBO(192, 196, 228, 0.35),
//                                borderRadius: BorderRadius.circular(
//                                  CustomStyle.verticalFractions * 1.078, //10
//                                ),
//                              ),
//                              margin: EdgeInsets.symmetric(
//                                horizontal:
//                                    CustomStyle.verticalFractions * 1.078, //10
//                              ),
//                              child: OutlineButton(
//                                shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(
//                                    CustomStyle.verticalFractions * 1.078, //10
//                                  ),
//                                ),
//                                padding: EdgeInsets.only(
//                                  top: CustomStyle.verticalFractions *
//                                      1.078, //10
//                                ),
//                                onPressed: () {
//                                  print('LV Button Pressed');
//                                  setState(() {
//                                    title = "ARMS";
//                                  });
//                                },
//                                child: Column(
//                                  mainAxisAlignment:
//                                      MainAxisAlignment.spaceBetween,
//                                  children: <Widget>[
//                                    Icon(Icons.crop_free),
//                                    Container(
//                                      decoration: BoxDecoration(
//                                        color: Colors.blue[300],
//                                        borderRadius: BorderRadius.only(
//                                          bottomLeft: Radius.circular(
//                                            CustomStyle.verticalFractions *
//                                                32.362, //300
//                                          ),
//                                          bottomRight: Radius.circular(
//                                            CustomStyle.verticalFractions *
//                                                32.362, //300
//                                          ),
//                                        ),
//                                      ),
//                                      width: CustomStyle.verticalFractions *
//                                          9.169, //85
//                                      height: CustomStyle.verticalFractions *
//                                          0.539, //5
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            ),
//                            Container(
//                              decoration: BoxDecoration(
//                                  color: Color.fromRGBO(192, 196, 228, 0.35),
//                                  borderRadius: BorderRadius.circular(
//                                    CustomStyle.verticalFractions * 1.078, //10
//                                  )),
//                              margin: EdgeInsets.symmetric(
//                                horizontal:
//                                    CustomStyle.verticalFractions * 1.078, //10
//                              ),
//                              child: OutlineButton(
//                                shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(
//                                    CustomStyle.verticalFractions * 1.078, //10
//                                  ),
//                                ),
//                                padding: EdgeInsets.only(
//                                    top: CustomStyle.verticalFractions *
//                                        1.078), //10
//                                onPressed: () {
//                                  print('LV Button Pressed');
//                                  setState(() {
//                                    title = "LEGS";
//                                  });
//                                },
//                                child: Column(
//                                  mainAxisAlignment:
//                                      MainAxisAlignment.spaceBetween,
//                                  children: <Widget>[
//                                    Icon(Icons.crop_free),
//                                    Container(
//                                      decoration: BoxDecoration(
//                                        color: Colors.blue[300],
//                                        borderRadius: BorderRadius.only(
//                                          bottomLeft: Radius.circular(
//                                            CustomStyle.verticalFractions *
//                                                32.362, //300
//                                          ),
//                                          bottomRight: Radius.circular(
//                                            CustomStyle.verticalFractions *
//                                                32.362, //300
//                                          ),
//                                        ),
//                                      ),
//                                      width: CustomStyle.verticalFractions *
//                                          9.169, //85
//                                      height: CustomStyle.verticalFractions *
//                                          0.539, //5
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            ),
//                            Container(
//                              decoration: BoxDecoration(
//                                color: Color.fromRGBO(192, 196, 228, 0.35),
//                                borderRadius: BorderRadius.circular(
//                                  CustomStyle.verticalFractions * 1.078, //10
//                                ),
//                              ),
//                              margin: EdgeInsets.symmetric(
//                                horizontal:
//                                    CustomStyle.verticalFractions * 1.078, //10
//                              ),
//                              child: OutlineButton(
//                                shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(
//                                    CustomStyle.verticalFractions * 1.078, //10
//                                  ),
//                                ),
//                                padding: EdgeInsets.only(
//                                  top: CustomStyle.verticalFractions *
//                                      1.078, //10
//                                ),
//                                onPressed: () {
//                                  print('LV Button Pressed');
//                                  setState(() {
//                                    title = "ABS";
//                                  });
//                                },
//                                child: Column(
//                                  mainAxisAlignment:
//                                      MainAxisAlignment.spaceBetween,
//                                  children: <Widget>[
//                                    Icon(Icons.crop_free),
//                                    Container(
//                                      decoration: BoxDecoration(
//                                        color: Colors.blue[300],
//                                        borderRadius: BorderRadius.only(
//                                          bottomLeft: Radius.circular(
//                                            CustomStyle.verticalFractions *
//                                                32.362, //300
//                                          ),
//                                          bottomRight: Radius.circular(
//                                            CustomStyle.verticalFractions *
//                                                32.362, //300
//                                          ),
//                                        ),
//                                      ),
//                                      width: CustomStyle.verticalFractions *
//                                          9.169, //85
//                                      height: CustomStyle.verticalFractions *
//                                          0.539, //5
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            ),
//                            Container(
//                              decoration: BoxDecoration(
//                                color: Color.fromRGBO(192, 196, 228, 0.35),
//                                borderRadius: BorderRadius.circular(
//                                  CustomStyle.verticalFractions * 1.078, //10
//                                ),
//                              ),
//                              margin: EdgeInsets.symmetric(
//                                horizontal:
//                                    CustomStyle.verticalFractions * 1.078, //10
//                              ),
//                              child: OutlineButton(
//                                shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(
//                                    CustomStyle.verticalFractions * 1.078, //10
//                                  ),
//                                ),
//                                padding: EdgeInsets.only(
//                                  top: CustomStyle.verticalFractions *
//                                      1.078, //10
//                                ),
//                                onPressed: () {
//                                  print('LV Button Pressed');
//                                  setState(() {
//                                    title = "YOGA";
//                                  });
//                                },
//                                child: Column(
//                                  mainAxisAlignment:
//                                      MainAxisAlignment.spaceBetween,
//                                  children: <Widget>[
//                                    Icon(Icons.crop_free),
//                                    Container(
//                                      decoration: BoxDecoration(
//                                        color: Colors.purple[300],
//                                        borderRadius: BorderRadius.only(
//                                          bottomLeft: Radius.circular(
//                                            CustomStyle.verticalFractions *
//                                                32.362, //300
//                                          ),
//                                          bottomRight: Radius.circular(
//                                            CustomStyle.verticalFractions *
//                                                32.362, //300
//                                          ),
//                                        ),
//                                      ),
//                                      width: CustomStyle.verticalFractions *
//                                          9.169, //85
//                                      height: CustomStyle.verticalFractions *
//                                          0.539, //5
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
//                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Draws the progress bar.
class CircleProgressBarPainter extends CustomPainter {
  double percentage;
  final double strokeWidth;
  final Color backgroundColor;
  final Color foregroundColor;

  CircleProgressBarPainter({
    this.backgroundColor,
    @required this.foregroundColor,
    @required this.percentage,
    double strokeWidth,
  }) : this.strokeWidth = strokeWidth ?? 6;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final Size constrainedSize =
        size - Offset(this.strokeWidth, this.strokeWidth);
    final shortestSide =
        Math.min(constrainedSize.width, constrainedSize.height);
    final foregroundPaint = Paint()
      ..shader = LinearGradient(colors: [
        Colors.yellowAccent,
        Colors.cyanAccent[100],
      ]).createShader(Rect.fromCircle(center: center, radius: shortestSide / 2))
      ..color = this.foregroundColor
      ..strokeWidth = CustomStyle.verticalFractions * 1.8 //30
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final radius = (shortestSide / 2);

    // Start at the top. 0 radians represents the right edge
    final double startAngle = -(2 * Math.pi * 0.25);
    final double sweepAngle = (2 * Math.pi * (this.percentage ?? 0));

    // Don't draw the background if we don't have a background color
    if (this.backgroundColor != null) {
      final backgroundPaint = Paint()
        ..color = this.backgroundColor
        ..strokeWidth = CustomStyle.verticalFractions * 3.236 //30
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(center, radius, backgroundPaint);
    }

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = (oldDelegate as CircleProgressBarPainter);
    return oldPainter.percentage != this.percentage ||
        oldPainter.backgroundColor != this.backgroundColor ||
        oldPainter.foregroundColor != this.foregroundColor ||
        oldPainter.strokeWidth != this.strokeWidth;
  }
}
