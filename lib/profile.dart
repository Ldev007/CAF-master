import 'package:firebase_ex/styling.dart';
import 'package:flutter/material.dart';
import 'pages/LeaderBoard.dart';
import 'pages/OverallStats.dart';
import 'pages/PlanDetails.dart';

void main() {
  runApp(
    Profile(
      title: 'Profile Page',
    ),
  );
}

class Profile extends StatefulWidget {
  Profile({Key key, String title}) : super(key: key);

  _ProfileState createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  static PageController _pageViewController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  static Color anim_box1_color = CustomStyle.light_bn_color,
      anim_box2_color = Colors.transparent,
      anim_box3_color = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 15),
                      title: Row(
                        children: <Widget>[
                          IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: CustomStyle.light_bn_color,
                              )),
                          SizedBox(width: 100),
                          Text(
                            'LOMASH DUBEY',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: CustomStyle.light_bn_color,
                            ),
                          ),
                          SizedBox(width: 80),
                          Icon(
                            Icons.notifications,
                            color: CustomStyle.light_bn_color,
                            size: 25,
                          ),
                          SizedBox(width: 35),
                          Icon(
                            Icons.more_horiz,
                            color: CustomStyle.light_bn_color,
                            size: 25,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          Icons.account_circle,
                          color: CustomStyle.light_bn_color,
                          size: 95,
                        ),
                        Column(
                          children: <Widget>[
                            Text('Current Weight :',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: CustomStyle.txt_color)),
                            SizedBox(height: 8),
                            Text('75 Kgs',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: CustomStyle.txt_color)),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text('Target Weight :',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: CustomStyle.txt_color)),
                            SizedBox(height: 8),
                            Text('50 Kgs',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: CustomStyle.txt_color)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: CustomStyle.verticalFractions * 5.393,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: BorderDirectional(
                        bottom: BorderSide(
                          width: 1,
                          color: CustomStyle.toggle_Border_Color,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.33,
                          child: Column(children: <Widget>[
                            IconButton(
                              padding: EdgeInsets.symmetric(horizontal: 60),
                              onPressed: () {
                                _pageViewController.animateToPage(0,
                                    duration: Duration(milliseconds: 900),
                                    curve: Curves.easeInSine);
                                setState(() {
                                  anim_box1_color = CustomStyle.light_bn_color;
                                  anim_box2_color = Colors.transparent;
                                  anim_box3_color = Colors.transparent;
                                });
                              },
                              icon: Icon(
                                Icons.trending_up,
                                color: CustomStyle.light_bn_color,
                              ),
                            ),
                            AnimatedContainer(
                              duration: Duration(milliseconds: 600),
                              color: anim_box1_color,
                              width: MediaQuery.of(context).size.width * 0.33,
                              height: 10,
                            ),
                          ]),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.33,
                          decoration: BoxDecoration(
                            border: BorderDirectional(
                              start: BorderSide(
                                  width: 1, color: CustomStyle.light_bn_color),
                              end: BorderSide(
                                  width: 1, color: CustomStyle.light_bn_color),
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                  splashColor: Colors.white60,
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          CustomStyle.verticalFractions *
                                              6.472), //60
                                  onPressed: () {
                                    _pageViewController.animateToPage(1,
                                        duration: Duration(milliseconds: 900),
                                        curve: Curves.easeIn);
                                    setState(() {
                                      anim_box2_color =
                                          CustomStyle.light_bn_color;
                                      anim_box1_color = Colors.transparent;
                                      anim_box3_color = Colors.transparent;
                                    });
                                  },
                                  icon: ImageIcon(
                                      AssetImage("images/sub_plans.png"),
                                      color: CustomStyle.light_bn_color)),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 600),
                                color: anim_box2_color,
                                width: MediaQuery.of(context).size.width * 0.33,
                                height: CustomStyle.verticalFractions * 1.078,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.33,
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        CustomStyle.verticalFractions * 6.472),
                                onPressed: () {
                                  _pageViewController.animateToPage(2,
                                      duration: Duration(milliseconds: 900),
                                      curve: Curves.easeIn);
                                  setState(() {
                                    anim_box3_color =
                                        CustomStyle.light_bn_color;
                                    anim_box1_color = Colors.transparent;
                                    anim_box2_color = Colors.transparent;
                                  });
                                },
                                icon: Icon(Icons.assignment_turned_in,
                                    color: CustomStyle.light_bn_color),
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 600),
                                color: anim_box3_color,
                                width: MediaQuery.of(context).size.width / 3,
                                height:
                                    CustomStyle.verticalFractions * 1.078, //10
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: PageView(
                physics: BouncingScrollPhysics(),
                controller: _pageViewController,
                onPageChanged: (pageIndex) {
                  setState(() {
                    if (pageIndex == 0) {
                      anim_box1_color = CustomStyle.light_bn_color;
                      anim_box2_color = Colors.transparent;
                      anim_box3_color = Colors.transparent;
                    } else if (pageIndex == 1) {
                      anim_box2_color = CustomStyle.light_bn_color;
                      anim_box1_color = Colors.transparent;
                      anim_box3_color = Colors.transparent;
                    } else if (pageIndex == 2) {
                      anim_box3_color = CustomStyle.light_bn_color;
                      anim_box1_color = Colors.transparent;
                      anim_box2_color = Colors.transparent;
                    }
                  });
                },
                allowImplicitScrolling: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      FittedBox(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: CustomStyle.light_bn_color),
                          padding: EdgeInsets.only(
                            top: CustomStyle.verticalFractions * 3.5, //32.445
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        CustomStyle.verticalFractions * 2.696),
                                child: Text('OVERALL :',
                                    style: CustomStyle.button_header),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Leaderboard(
                                bg_color: Colors.transparent,
                                steps: 20,
                                width: 300,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: CustomStyle.light_bn_color),
                        padding: EdgeInsets.only(
                          top: CustomStyle.verticalFractions * 3.5, //32.454
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: CustomStyle.verticalFractions *
                                      2.696), //25
                              child: Text('CURRENT :',
                                  style: CustomStyle.button_header),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Leaderboard(
                              bg_color: Colors.transparent,
                              steps: 20,
                              width: 300,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Plandetails(),
                  Overallstats(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
