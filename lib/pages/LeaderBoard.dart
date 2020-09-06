//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ex/styling.dart';
import 'package:flutter/material.dart';
import 'package:bezier_chart/bezier_chart.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class Leaderboard extends StatefulWidget {
  final Color bg_color;
  final int steps;
  final double width;
  final dataf;
  final List xaxiss;
  Leaderboard(
      {Key key, this.bg_color, this.steps, this.width, this.dataf, this.xaxiss})
      : super(key: key);
  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  var xaxis = [0.0];
  var data = [
    DataPoint<double>(value: 0),
  ];

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
