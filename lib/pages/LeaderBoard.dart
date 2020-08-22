import 'package:firebase_ex/styling.dart';
import 'package:flutter/material.dart';
import 'package:bezier_chart/bezier_chart.dart';

class Leaderboard extends StatelessWidget {
  final Color bg_color;
  final int steps;
  final double width;
  Leaderboard({Key key, this.bg_color, this.steps, this.width})
      : super(key: key);
  var data = [
    DataPoint<double>(value: 100, xAxis: 0),
    DataPoint<double>(value: 110, xAxis: 4),
    DataPoint<double>(value: 130, xAxis: 5),
    DataPoint<double>(value: 125, xAxis: 8),
    DataPoint<double>(value: 80, xAxis: 9),
    DataPoint<double>(value: 50, xAxis: 10),
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: BezierChart(
          bezierChartScale: BezierChartScale.CUSTOM,
          xAxisCustomValues: const [0, 4, 5, 8, 9, 10],
          series: [
            BezierLine(
              lineColor: Colors.white,
              dataPointFillColor: CustomStyle.light_bn_color,
              dataPointStrokeColor: CustomStyle.light_bn_txt_Color,
              data: data
            ),
          ],
          config: BezierChartConfig(
            snap: false,
            verticalIndicatorStrokeWidth: 2.0,
            verticalIndicatorColor: CustomStyle.light_bn_txt_Color,
            showVerticalIndicator: true,
            stepsYAxis: steps,
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
