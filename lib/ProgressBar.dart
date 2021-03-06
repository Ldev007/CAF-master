import 'dart:math' as Math;
import 'dart:ui';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/LeaderBoard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'styling.dart';
import 'package:sortedmap/sortedmap.dart';
import 'package:fit_kit/fit_kit.dart';

class CircleProgressBar extends StatefulWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final double value;

  CircleProgressBar({
    Key key,
    @required this.backgroundColor,
    @required this.foregroundColor,
    @required this.value,
  }) : super(key: key);
  final double x = 0.4;

  _CircleProgressBarState createState() =>
      _CircleProgressBarState(backgroundColor: this.backgroundColor, foregroundColor: this.foregroundColor, value: this.value);
}

class _CircleProgressBarState extends State<CircleProgressBar> with TickerProviderStateMixin {
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
  int steps_ran = 0;
  double total = 1000;
  String uid = "";
  double calories = 0.0;
  double targetcal = 2000;
  bool paint = false;
  List<int> target_steps = [2000, 5000, 7000, 8000, 10000, 15000, 20000];

  //Leaderboard
  var dat = [110, 130, 125, 80, 50];
  var len = 0;
  var axis = [0.0];
  var points = [
    DataPoint<double>(value: 0),
  ];

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
    DocumentSnapshot ds = await Firestore.instance.collection('UserData').document(uid).get();
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
    final items = results.entries.expand((entry) => [entry.key, ...entry.value]).toList();
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
    double x = 2000; //(int.parse(testcount.toString()[0]) + 1) * 1000.toDouble();
    for (int i = 0; i < target_steps.length; i++) {
      if (target_steps[i] > testcount) {
        x = target_steps[i].toDouble();
        break;
      }
    }
    setState(() {
//      print("testcount"+testcount.toString());
      //targetcal=+300;
      calories = calories + (testcount * 0.04);
      targetcal = (int.parse(calories.toString()[0]) + 2) * 100.toDouble();
      total = x;
      steps = testcount / x;
      steps_ran = testcount.toInt();
      // print("wgetcv"+total.toString());
//      print("steps"+steps.toString());
      _animation(testcount);
    });

//    final item = items[index];
  }

  _animation(testcount) {
//    print("tracker       "+steps.toString());
    print("calories" + steps_ran.toString());
    double x = 0.0;
    x = steps;
//  print("eygugcyu7wq"+anime.value.toString());
    animeCont = AnimationController(duration: Duration(seconds: 2), vsync: this);
    anime = Tween<double>(begin: 0, end: steps).animate(animeCont)
      ..addListener(() {
        setState(() {});
      });
    print('Steps : ' + steps.toString());

    setState(() {
      paint = true;
    });
    animeCont.forward();
    updatesteps(testcount);
  }

  updatesteps(testcount) async {
    CollectionReference collectionReference = Firestore.instance.collection('UserData');
    // collectionReference.document(uid).updateData({'Steps': testcount});
    DocumentReference ds = collectionReference.document(uid).collection('excercise').document('steps');
    DateTime dda = DateTime(now.year, now.month, now.day);
    var fulldate = DateTime.parse(dda.toString());
//    print(moonLanding.month);
    var month = fulldate.month;
    var date = fulldate.day;
    var year = fulldate.year;
    var dates = "";
    if (date < 10) {
      dates = "0" + date.toString();
    } else {
      dates = date.toString();
    }
    ds.setData({
      year.toString(): {
        month.toString(): {dates: testcount}
      }
    }, merge: true);
    var xaxis = [0.0];
    var data = [
      DataPoint<double>(value: 0),
    ];

    DocumentSnapshot dsnap =
        await Firestore.instance.collection('UserData').document(uid).collection('excercise').document('steps').get();
    Map<String, dynamic> stepsdata = dsnap.data[year.toString()][month.toString()];
//    print(test);
    var map = new SortedMap(Ordering.byKey());
    map.addAll(stepsdata);

    // map.forEach((element, value) {
    //
    // });
    map.forEach((element, value) {
      data.add(DataPoint<double>(value: value.toDouble()));
      len = len + 2;
      xaxis.add(len.toDouble());
//      print(element);
    });
//     var test = [0,];
//     for(int i=map.length;i>0;i++){
//       test.add()
//     }

//    print(xaxis);
//    print(data);
    setState(() {
      axis = xaxis;
      points = data;
    });
  }

  _CircleProgressBarState({
    @required this.backgroundColor,
    @required this.foregroundColor,
    @required this.value,
  }) : super();

  String title = "Tracking";

  @override
  Widget build(BuildContext context) {
    final backgroundColor = this.backgroundColor;
    final foregroundColor = this.foregroundColor;
    return Container(
      decoration: BoxDecoration(
        gradient: CustomStyle.gradientBGColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            title,
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w600,
              fontSize: 30,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                //CENTER TITLE MODIFICATION DONE
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: [
                          CustomPaint(
                            child: Container(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width * 0.40,
                              height: MediaQuery.of(context).size.height * 0.4,
                            ),
                            painter: PaintProgressBar(
                              bkgColor: backgroundColor,
                              frgColor: foregroundColor,
                              percentage: paint ? anime.value : 0.0,
                            ),
                          ),
                          Container(
                            width: CustomStyle.verticalFractions * 18.48,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    steps_ran.round().toString(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: CustomStyle.verticalFractions * 5, //70
                                        color: CustomStyle.light_bn_color,
                                        fontFamily: 'fonts/Anton-Regular.ttf'),
                                  ),
                                  SizedBox(
                                    width: CustomStyle.verticalFractions * 2.258, //22
                                    // height: 45,
                                    child: Text('/',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          height: CustomStyle.verticalFractions * 0.205, //2
                                          fontSize: CustomStyle.verticalFractions * 3.593, //35
                                          color: CustomStyle.light_bn_color,
                                          fontFamily: 'fonts/Anton-Regular.ttf',
                                        )),
                                  ),
                                  Text(
                                    total.round().toString(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      height: CustomStyle.verticalFractions * 0.297, //2.9
                                      fontSize: CustomStyle.verticalFractions * 2.4, //254
                                      color: CustomStyle.light_bn_color,
                                      fontFamily: 'fonts/Anton-Regular.ttf',
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
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
                                  SizedBox(width: CustomStyle.verticalFractions * 1.078), //10
                                  Icon(
                                    Icons.fiber_manual_record,
                                    color: Color.fromRGBO(192, 196, 228, 0.5),
                                    size: CustomStyle.verticalFractions * 2.157, //20
                                  ),
                                  SizedBox(width: CustomStyle.verticalFractions * 2.157), //20
                                  Text(
                                    'Calories Burnt',
                                    style: TextStyle(
                                      color: Colors.white, //Color.fromRGBO(192, 196, 228, 0.5),
                                      fontSize: CustomStyle.verticalFractions * 2.804, //26
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: CustomStyle.verticalFractions * 2.157), //20
                              Padding(
                                padding: EdgeInsets.only(right: CustomStyle.verticalFractions * 2.157), //20
                                child: Text(
                                  calories.toStringAsPrecision(5) + ' cal',
                                  style: TextStyle(
                                    fontSize: CustomStyle.verticalFractions * 3.236, //30
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
                                    size: CustomStyle.verticalFractions * 2.157, //20
                                  ),
                                  SizedBox(width: CustomStyle.verticalFractions * 1.078), //10
                                  Text(
                                    'Target Calories',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: CustomStyle.verticalFractions * 2.804, //26
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: CustomStyle.verticalFractions * 2.157), //20
                              Padding(
                                padding: EdgeInsets.only(right: CustomStyle.verticalFractions * 7.011), //65
                                child: Text(
                                  '$targetcal kcal',
                                  style: TextStyle(
                                    fontSize: CustomStyle.verticalFractions * 3.236, //30
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
                  flex: 2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Color.fromRGBO(0, 0, 0, 0.0),
                          padding: EdgeInsets.only(
                            bottom: CustomStyle.verticalFractions * 8.5, //10
                          ),
                          width: CustomStyle.verticalFractions * 21.574,
                          //200
                          child: Leaderboard(
                            steps: 500,
                            dataf: points,
                            xaxiss: axis,
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

                // SizedBox(height: 10),

                //BOTTOM WIDGET
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     height: MediaQuery.of(context).size.height * 0.15,
                //     child: Row(
                //       children: <Widget>[
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
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Draws the progress bar.
class PaintProgressBar extends CustomPainter {
  double percentage, strokeWidth, customRadius;
  Color bkgColor;
  Color frgColor;
  Color shadowColor;

  PaintProgressBar({
    @required this.bkgColor,
    @required this.frgColor,
    @required this.percentage,
    this.strokeWidth,
    this.customRadius,
    this.shadowColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final Size constrainedSize = size - Offset(this.strokeWidth, this.strokeWidth);
    final shortestSide = Math.min(constrainedSize.width, constrainedSize.height);
    final foregroundPaint = Paint()
      ..color = this.frgColor
      ..strokeWidth = strokeWidth ?? CustomStyle.verticalFractions * 1.8 //30
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final radius = (shortestSide / 2);

    // Start at the top. 0 radians represents the right edge
    final double startAngle = -(2 * Math.pi * 0.25);
    final double sweepAngle = (2 * Math.pi * (this.percentage ?? 0));

    // Don't draw the background if we don't have a background color
    print('Background color : ' + bkgColor.toString() + '\n Foreground color: ' + this.frgColor.toString());

    if (shadowColor != null) {
      final paintShadow = Paint()
        ..strokeWidth = strokeWidth * 1.2
        ..strokeCap = StrokeCap.round
        ..color = shadowColor
        ..style = PaintingStyle.stroke
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10);
      canvas.drawCircle(center, radius + 2, paintShadow);
    }

    if (this.bkgColor != null) {
      final backgroundPaint = Paint()
        ..color = this.bkgColor
        ..strokeWidth = strokeWidth ?? CustomStyle.verticalFractions * 1.5 //30
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

    print(this.percentage);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = (oldDelegate as PaintProgressBar);
    return oldPainter.percentage != this.percentage ||
        oldPainter.bkgColor != this.bkgColor ||
        oldPainter.frgColor != this.frgColor ||
        oldPainter.strokeWidth != this.strokeWidth;
  }
}
