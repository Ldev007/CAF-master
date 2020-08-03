import 'package:flutter/material.dart';
import 'package:firebase_ex/styling.dart';

class DietChart extends StatefulWidget {
  DietChart({Key key, String title}) : super(key: key);

  _DietChartState createState() => _DietChartState();
}

class _DietChartState extends State<DietChart> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.5,
            child: ImageIcon(
              AssetImage(
                "images/sub_plans.png",
              ),
              color: CustomStyle.light_bn_color,
            ),
          ),
        ),
      ),
    );
  }
}
