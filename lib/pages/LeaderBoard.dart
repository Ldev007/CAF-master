import 'package:flutter/material.dart';
import 'package:bezier_chart/bezier_chart.dart';

class Leaderboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width * 0.9,
        child: BezierChart(
          bezierChartScale: BezierChartScale.CUSTOM,
          xAxisCustomValues: const [0, 4, 5, 8, 9, 10],
          series: [
            BezierLine(
              data: const [
                DataPoint<double>(value: 10, xAxis: 0),
                DataPoint<double>(value: 110, xAxis: 4),
                DataPoint<double>(value: 130, xAxis: 5),
                DataPoint<double>(value: 125, xAxis: 8),
                DataPoint<double>(value: 80, xAxis: 9),
                DataPoint<double>(value: 50, xAxis: 10),
              ],
            ),
          ],
          config: BezierChartConfig(
            pinchZoom: true,
            contentWidth: 100,
            verticalIndicatorStrokeWidth: 2.0,
            verticalIndicatorColor: Colors.black26,
            showVerticalIndicator: true,
            stepsYAxis: 45,
            displayYAxis: true,
            footerHeight: 12,
          ),
        ),
      ),
    );
  }
}
