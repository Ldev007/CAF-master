import 'package:flutter/material.dart';
import 'dart:math';
import 'package:firebase_ex/styling.dart';

class Plandetails extends StatefulWidget {
  final Map<String,dynamic> plan;
  Plandetails({Key key, String title,this.plan}) : super(key: key);

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
  static double op1 = 0.0,
      op2 = 1;
  static double icon_size = 35;
  static int x = 1;
  final l=["est","tesgh"];
  @override
  void initState() {
    super.initState();
    print("plan" + x.toString());
    print(widget.plan);

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
    if (widget.plan == null) {
      return Text("loading");
    }
    else {
//      return ListView.builder(itemCount:l.length,itemBuilder: (BuildContext ctxt, int index) {
//        return new Text(l[index]+widget.plan.toString());
      return ListView.builder(itemCount: widget.plan.keys.toList().length,
          padding: EdgeInsets.fromLTRB(25, 30, 25, 30),

//          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
          itemBuilder: (BuildContext ctxt, int index) {
//        return new Text(l[index]+widget.plan.keys.toList()[index].toString());

            return Container(
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
                    widget.plan.keys.toList()[index].toString(),
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
                                    setState(() {
                                      x = 2;
                                    });
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
            );
          });
    }
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
