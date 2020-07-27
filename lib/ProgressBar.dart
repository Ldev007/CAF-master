import 'dart:math' as Math;
import 'dart:ui';
import 'pages/LeaderBoard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

  _CircleProgressBarState createState() => _CircleProgressBarState(
      foregroundColor: this.foregroundColor, value: this.value);
}

class _CircleProgressBarState extends State<CircleProgressBar>
    with SingleTickerProviderStateMixin {
  final Color backgroundColor;
  final Color foregroundColor;
  final double value;
  static Animation<double> anime;
  static AnimationController animeCont;
  static int dur_min = 32;
  static int dur_sec = 50;
  static int calories = 320;
  @override
  void initState() {
    super.initState();

    animeCont =
        AnimationController(duration: Duration(seconds: 20), vsync: this);
    anime = Tween<double>(begin: 0, end: 0.5).animate(animeCont)
      ..addListener(() {
        setState(() {
          print(2 * Math.pi * anime.value);
        });
      });

    animeCont.forward();
  }

  _CircleProgressBarState({
    this.backgroundColor,
    @required this.foregroundColor,
    @required this.value,
  }) : super();

  @override
  Widget build(BuildContext context) {
    final backgroundColor = this.backgroundColor;
    final foregroundColor = this.foregroundColor;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Colors.blue[100],
                Colors.blue[600],
                Colors.blue[800],
              ],
            ),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.menu, color: Colors.white),
                    SizedBox(width: 125),
                    Text('RUNNING',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.grey[300],
                          letterSpacing: 3.0,
                        ))
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
                          color: Color.fromRGBO(0, 0, 0, 0.1)),
                      child: OutlineButton(
                        color: Colors.black87,
                        shape: CircleBorder(side: BorderSide()),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Icon(Icons.calendar_today, color: Colors.white),
                        onPressed: () {
                          print('Calendar Button pressed');
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
                        percentage: anime.value,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(0, 0, 0, 0.1)),
                      child: OutlineButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        onPressed: () {
                          print('Location Button Pressed');
                        },
                        shape: CircleBorder(side: BorderSide()),
                        child: Icon(Icons.location_on, color: Colors.white),
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox(width: 10),
                              Icon(
                                Icons.timer,
                                color: Colors.grey[200],
                                size: 20,
                              ),
                              SizedBox(width: 20),
                              Text(
                                'DURATION',
                                style: TextStyle(
                                  color: Colors.grey[100],
                                  fontSize: 26,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Text(
                              '$dur_min:$dur_sec min',
                              style: TextStyle(
                                fontSize: 30,
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
                                color: Colors.grey[200],
                                size: 20,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'CALORIES',
                                style: TextStyle(
                                  color: Colors.grey[200],
                                  fontSize: 26,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.only(right: 65),
                            child: Text(
                              '$calories kcal',
                              style: TextStyle(
                                fontSize: 30,
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
              Expanded(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Color.fromRGBO(0, 0, 0, 0.0),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        height: 150,
                        width: 200,
                        child: Leaderboard(),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Color.fromRGBO(0, 0, 0, 0.0),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        height: 150,
                        width: 200,
                        child: Leaderboard(),
                      ),
                    ),
                  ],
                ),
              ),

              //BOTTOM WIDGET
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            OutlineButton(
                              color: Colors.transparent,
                              onPressed: () {
                                print('EDIT button clicked');
                              },
                              child: Text(
                                'EDIT',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white60,
                                    letterSpacing: 1.5),
                              ),
                            ),
                            OutlineButton(
                              color: Colors.grey[500],
                              onPressed: () {
                                print('Plus button clicked');
                              },
                              child: Icon(Icons.add, color: Colors.white60),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: OutlineButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.only(top: 10),
                                onPressed: () {
                                  print('LV Button Pressed');
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(Icons.crop_free),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(300),
                                          bottomRight: Radius.circular(300),
                                        ),
                                      ),
                                      width: 85,
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: OutlineButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.only(top: 10),
                                onPressed: () {
                                  print('LV Button Pressed');
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(Icons.crop_free),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.orange[300],
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(300),
                                          bottomRight: Radius.circular(300),
                                        ),
                                      ),
                                      width: 83,
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: OutlineButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.only(top: 10),
                                onPressed: () {
                                  print('LV Button Pressed');
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(Icons.crop_free),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.red[300],
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(300),
                                              bottomRight:
                                                  Radius.circular(300))),
                                      width: 85,
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: OutlineButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.only(top: 10),
                                onPressed: () {
                                  print('LV Button Pressed');
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(Icons.crop_free),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blue[300],
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(300),
                                          bottomRight: Radius.circular(300),
                                        ),
                                      ),
                                      width: 85,
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: OutlineButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.only(top: 10),
                                onPressed: () {
                                  print('LV Button Pressed');
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(Icons.crop_free),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.purple[300],
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(300),
                                          bottomRight: Radius.circular(300),
                                        ),
                                      ),
                                      width: 85,
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
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
  final double percentage;
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
        Colors.black,
        Colors.blue,
        Colors.deepPurple
      ]).createShader(Rect.fromCircle(center: center, radius: shortestSide / 2))
      ..color = this.foregroundColor
      ..strokeWidth = 30
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
        ..strokeWidth = 30
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
