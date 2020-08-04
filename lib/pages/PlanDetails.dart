import 'package:flutter/material.dart';
import 'dart:math';
import 'package:firebase_ex/styling.dart';

class Plandetails extends StatefulWidget {
  Plandetails({Key key, String title}) : super(key: key);

  _PlandetailsState createState() {
    return _PlandetailsState();
  }
}

class _PlandetailsState extends State<Plandetails>
    with TickerProviderStateMixin {
  static AnimationController card_cont_1,
      card_cont_2,
      card_cont_3,
      card_cont_4,
      card_cont_5;
  static CurvedAnimation curve1, curve2, curve3, curve4, curve5;
  static Color raised_button_color = Colors.blue[700];
  static double op1 = 0.0, op2 = 1;
  static double icon_size = 35;

  @override
  void initState() {
    super.initState();

//CONTROLLER INITIALIZATIONS

    card_cont_1 = AnimationController(
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    card_cont_2 = AnimationController(
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    card_cont_3 = AnimationController(
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    card_cont_4 = AnimationController(
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    card_cont_5 = AnimationController(
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

//CURVES INITIALIZATIONS

    curve1 = CurvedAnimation(
        parent: card_cont_1, curve: Curves.fastLinearToSlowEaseIn);
    curve2 = CurvedAnimation(
        parent: card_cont_2, curve: Curves.fastLinearToSlowEaseIn);
    curve3 = CurvedAnimation(
        parent: card_cont_3, curve: Curves.fastLinearToSlowEaseIn);
    curve4 = CurvedAnimation(
        parent: card_cont_4, curve: Curves.fastLinearToSlowEaseIn);
    curve5 = CurvedAnimation(
        parent: card_cont_5, curve: Curves.fastLinearToSlowEaseIn);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
      children: <Widget>[
        //CARD-1
        Container(
          padding: EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
              color: CustomStyle.light_bn_color,
              borderRadius: BorderRadius.circular(15),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: CustomStyle.light_bn_txt_Color,
                    offset: Offset.fromDirection(10.8, -20),
                    blurRadius: 15)
              ]),
          child: Column(
            children: <Widget>[
              Text(
                'PLAN - 1',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: CustomStyle.light_bn_txt_Color,
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ScaleTransition(
                        alignment: Alignment.bottomLeft,
                        scale: curve1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.filter_vintage,
                                color: CustomStyle.light_bn_txt_Color,
                              ),
                              onPressed: () {
                                print("1");
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.find_in_page,
                                color: CustomStyle.light_bn_txt_Color,
                              ),
                              onPressed: () {
                                print("2");
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: CustomStyle.light_bn_txt_Color,
                              ),
                              onPressed: () {
                                print("3");
                              },
                            ),
                          ],
                        ),
                      ),
                      RotationTransition(
                        turns: card_cont_1,
                        child: IconButton(
                          icon: Icon(
                            Icons.scatter_plot,
                            color: CustomStyle.light_bn_txt_Color,
                          ),
                          onPressed: () {
                            print("4");
                            card_cont_1.forward();
                            if (card_cont_1.isCompleted) {
                              card_cont_1.reverse();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 30),

        //CARD - 2
        Container(
            padding: EdgeInsets.only(top: 50),
            decoration: BoxDecoration(
                color: CustomStyle.light_bn_color,
                borderRadius: BorderRadius.circular(15),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: CustomStyle.light_bn_txt_Color,
                      offset: Offset.fromDirection(10.8, -20),
                      blurRadius: 15)
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  'PLAN - 2',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: CustomStyle.light_bn_txt_Color,
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ScaleTransition(
                          alignment: Alignment.bottomLeft,
                          scale: curve2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.filter_vintage),
                                onPressed: () {
                                  print("1");
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.find_in_page),
                                onPressed: () {
                                  print("2");
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  print("3");
                                },
                              ),
                            ],
                          ),
                        ),
                        RotationTransition(
                          turns: card_cont_2,
                          child: IconButton(
                            icon: Icon(Icons.scatter_plot),
                            onPressed: () {
                              print("4");
                              card_cont_2.forward();
                              if (card_cont_2.isCompleted) {
                                card_cont_2.reverse();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
        SizedBox(height: 30),

        //CARD - 3
        Container(
          padding: EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
              color: CustomStyle.light_bn_color,
              borderRadius: BorderRadius.circular(15),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: CustomStyle.light_bn_txt_Color,
                    offset: Offset.fromDirection(10.8, -20),
                    blurRadius: 15)
              ]),
          child: Column(
            children: <Widget>[
              Text(
                'PLAN - 3',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: CustomStyle.light_bn_txt_Color,
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ScaleTransition(
                        alignment: Alignment.bottomLeft,
                        scale: curve3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.filter_vintage),
                              onPressed: () {
                                print("1");
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.find_in_page),
                              onPressed: () {
                                print("2");
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              onPressed: () {
                                print("3");
                              },
                            ),
                          ],
                        ),
                      ),
                      RotationTransition(
                        turns: card_cont_3,
                        child: IconButton(
                          icon: Icon(Icons.scatter_plot),
                          onPressed: () {
                            print("4");
                            card_cont_3.forward();
                            if (card_cont_3.isCompleted) {
                              card_cont_3.reverse();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 30),

        //CARD - 4
        Container(
          padding: EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
              color: CustomStyle.light_bn_color,
              borderRadius: BorderRadius.circular(15),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: CustomStyle.light_bn_txt_Color,
                    offset: Offset.fromDirection(10.8, -20),
                    blurRadius: 15)
              ]),
          child: Column(
            children: <Widget>[
              Text(
                'PLAN - 4',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: CustomStyle.light_bn_txt_Color,
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ScaleTransition(
                        alignment: Alignment.bottomLeft,
                        scale: curve4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.filter_vintage),
                              onPressed: () {
                                print("1");
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.find_in_page),
                              onPressed: () {
                                print("2");
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              onPressed: () {
                                print("3");
                              },
                            ),
                          ],
                        ),
                      ),
                      RotationTransition(
                        turns: card_cont_4,
                        child: IconButton(
                          icon: Icon(Icons.scatter_plot),
                          onPressed: () {
                            print("4");
                            card_cont_4.forward();
                            if (card_cont_4.isCompleted) {
                              card_cont_4.reverse();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 30),

        //CARD - 5
        Container(
          padding: EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
              color: CustomStyle.light_bn_color,
              borderRadius: BorderRadius.circular(15),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: CustomStyle.light_bn_txt_Color,
                    offset: Offset.fromDirection(10.8, -20),
                    blurRadius: 15)
              ]),
          child: Column(
            children: <Widget>[
              Text(
                'PLAN - 5',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: CustomStyle.light_bn_txt_Color,
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ScaleTransition(
                        alignment: Alignment.bottomLeft,
                        scale: curve5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.filter_vintage),
                              onPressed: () {
                                print("1");
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.find_in_page),
                              onPressed: () {
                                print("2");
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              onPressed: () {
                                print("3");
                              },
                            ),
                          ],
                        ),
                      ),
                      RotationTransition(
                        turns: card_cont_5,
                        child: IconButton(
                          icon: Icon(Icons.scatter_plot),
                          onPressed: () {
                            print("4");
                            card_cont_5.forward();
                            if (card_cont_5.isCompleted) {
                              card_cont_5.reverse();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _scalingFun() {
    return;
  }

  @override
  void dispose() {
    card_cont_2.dispose();
    card_cont_1.dispose();
    super.dispose();
  }
}
