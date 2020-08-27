import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ex/styling.dart';
import 'package:flutter/material.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Leaderboard extends StatefulWidget {
  final Color bg_color;
  final int steps;
  final double width;
  final dataf;
  final List xaxiss;
  Leaderboard({Key key, this.bg_color, this.steps, this.width,this.dataf,this.xaxiss})
      : super(key: key);
  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {

  var dat=[110,130,125,80,50];
  var len = 0;
  var xaxis =[0.0];
  var data=[DataPoint<double>(value: 0),];
  DateTime now = DateTime.now();
//  var data = [
//    DataPoint<double>(value: 100),
//    DataPoint<double>(value: 110),
//    DataPoint<double>(value: 130),
//    DataPoint<double>(value: 125),
//    DataPoint<double>(value: 80),
//    DataPoint<double>(value: 50),
//  ];

  @override
  void initState() {
    print("leader");
    print(widget.dataf);
    print(widget.xaxiss);
    //fetch();
  }
  fetch() async{
//    CollectionReference collectionReference =
//    Firestore.instance.collection('UserData');
//    DocumentReference dr = collectionReference
//        .document(widget.uid)
//        .collection('excercise')
//        .document('steps');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("uid");
  print(uid);
    DocumentSnapshot ds =
    await Firestore.instance.collection('UserData').document(uid)
        .collection('excercise')
        .document('steps').get();
    DateTime dda = DateTime(now.year, now.month, now.day);
    var fulldate = DateTime.parse(dda.toString());
//    print(moonLanding.month);
    var month = fulldate.month;
    var date = fulldate.day;
    var year = fulldate.year;

    var test= ds.data[year.toString()][month.toString()];
    print(test);
    test.forEach((element,value) {
      data.add(DataPoint<double>(value: value.toDouble()));
      len=len+2;
      xaxis.add(len.toDouble());
    print(element);
    });
    print(xaxis);
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: BezierChart(
          bezierChartScale: BezierChartScale.CUSTOM,
          xAxisCustomValues: widget.xaxiss,
          series: [
            BezierLine(
                lineColor: Colors.white,
                dataPointFillColor: CustomStyle.light_bn_color,
                dataPointStrokeColor: CustomStyle.light_bn_txt_Color,
                data: widget.dataf,
            ),
          ],
          config: BezierChartConfig(
            snap: false,
            verticalIndicatorStrokeWidth: 2.0,
            verticalIndicatorColor: CustomStyle.light_bn_txt_Color,
            showVerticalIndicator: true,
            stepsYAxis: widget.steps,
            startYAxisFromNonZeroValue: true,
            displayYAxis: true,
            updatePositionOnTap: true,
            xAxisTextStyle: TextStyle(color: Colors.transparent),
            yAxisTextStyle:
            TextStyle(color: Color.fromRGBO(192, 196, 228, 0.5)),
//            backgroundColor: Colors.blue,
//            bubbleIndicatorColor: Colors.blue,
//            xLinesColor: Colors.white,
          ),
        ),
      ),
    );
  }
}


//
//class Leaderboard extends StatelessWidget {
//  final Color bg_color;
//  final int steps;
//  final double width;
//  Leaderboard({Key key, this.bg_color, this.steps, this.width})
//      : super(key: key);
//  var dat=[100,110,130,125,80,50];
//  var x=[];
//  var data = [
//    DataPoint<double>(value: 100),
//    DataPoint<double>(value: 110),
//    DataPoint<double>(value: 130),
//    DataPoint<double>(value: 125),
//    DataPoint<double>(value: 80),
//    DataPoint<double>(value: 50),
//  ];
//
//  @override
//  void initState() {
//    print("tracker");
//    dat.forEach((element) {
//      x.add(DataPoint<double>(value: element.toDouble()));
//    });
//    print(dat);
//  }
//  @override
//  Widget build(BuildContext context) {
//    return Center(
//      child: Container(
//        child: BezierChart(
//          bezierChartScale: BezierChartScale.CUSTOM,
//          xAxisCustomValues: const [0, 4, 5, 8, 9, 10],
//          series: [
//            BezierLine(
//              lineColor: Colors.white,
//              dataPointFillColor: CustomStyle.light_bn_color,
//              dataPointStrokeColor: CustomStyle.light_bn_txt_Color,
//              data: data
//            ),
//          ],
//          config: BezierChartConfig(
//            snap: false,
//            verticalIndicatorStrokeWidth: 2.0,
//            verticalIndicatorColor: CustomStyle.light_bn_txt_Color,
//            showVerticalIndicator: true,
//            stepsYAxis: steps,
//            startYAxisFromNonZeroValue: true,
//            displayYAxis: true,
//            updatePositionOnTap: true,
//            xAxisTextStyle: TextStyle(color: Colors.transparent),
//            yAxisTextStyle:
//                TextStyle(color: Color.fromRGBO(192, 196, 228, 0.5)),
////            backgroundColor: Colors.blue,
////            bubbleIndicatorColor: Colors.blue,
////            xLinesColor: Colors.white,
//          ),
//        ),
//      ),
//    );
//  }
//}
