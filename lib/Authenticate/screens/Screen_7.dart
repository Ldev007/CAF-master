import 'package:firebase_ex/Authenticate/screens/Screen_8.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_ex/styling.dart';

class ScreenSeven extends StatefulWidget {
  final String userid;
  final String goal;
  final String gender;
  final String age;
  final String height;
  final String weight;
  final String currentfat;
  ScreenSeven(
      {Key key,
      String title,
      this.age,
      this.goal,
      this.userid,
      this.gender,
      this.height,
      this.weight,
      this.currentfat})
      : super(key: key);

  _ScreenSevenState createState() => _ScreenSevenState();
}

final List<String> imgList = [
  'images/tum1.jpg',
  'images/tum2.jpg',
  'images/tum3.jpg',
  'images/tum4.jpg',
  'images/tum5.jpg',
  'images/tum6.jpg',
  'images/tum7.jpg',
];

//Carousel Design & logic
final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: CustomStyle.light_bn_color,
                            width: 2.5,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 92, horizontal: 20.0),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

class _ScreenSevenState extends State<ScreenSeven> {
  Color ctrl_buttn_color = CustomStyle.light_bn_color;
  Color ctrl_icon_color = CustomStyle.light_bn_txt_Color;
  static int i = 0;
  final CarouselController _controller = CarouselController();
  static List<String> choices = [
    '4 - 9%',
    '9 - 14%',
    '14 - 19%',
    '19 - 24%',
    '24 - 29%',
    '29 - 34%',
    '34 - 39%',
    '39 - 44%',
    '44 - 54%',
  ];
  @override
  void initState() {
    super.initState();
  }

  String targetfat;
  @override
  Widget build(BuildContext context) {
    print("screen 7");
    print(widget.userid +
        " " +
        widget.goal +
        " " +
        widget.gender +
        " " +
        widget.age +
        " " +
        widget.height +
        " " +
        widget.weight +
        " " +
        widget.currentfat);
    //Main Widget
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: CustomStyle.fab_eb_color,
          splashColor: Colors.transparent,
          child: Icon(
            Icons.arrow_forward_ios,
            color: CustomStyle.fab_icon_eb_color,
          ),
          onPressed: () => {
                targetfat = choices[i],
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ScreenEight(
                            userid: widget.userid,
                            goal: widget.goal,
                            gender: widget.gender,
                            age: widget.age,
                            height: widget.height,
                            weight: widget.weight,
                            currentfat: widget.currentfat,
                            targetfat: targetfat))),
              }),
      appBar: AppBar(
          centerTitle: true,
          title: Text('Step 7 of 8', style: CustomStyle.appBar_Title),
          backgroundColor: CustomStyle.appBar_color),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: CustomStyle.verticalFractions * 10),
          child: Column(
            children: <Widget>[
              Text(
                'What\'s your body fat target ?',
                style: TextStyle(
                  fontSize: CustomStyle.page_header.fontSize - 6,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'fonts/Roboto-Bold.ttf',
                  color: CustomStyle.light_bn_color,
                ),
              ),
              SizedBox(
                height: 45,
              ),
              Stack(
                children: <Widget>[
                  CarouselSlider(
                    items: imageSliders,
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      height: 200,
                      enableInfiniteScroll: false,
                    ),
                    carouselController: _controller,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 200),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RaisedButton(
                          padding: EdgeInsets.all(22),
                          shape: CircleBorder(),
                          color: ctrl_buttn_color,
                          onPressed: () {
                            if (i == 0) {
                              return null;
                            } else {
                              _controller.previousPage();
                              setState(() {
                                i--;
                              });
                            }
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: ctrl_icon_color,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'BODY FAT: ',
                              style: TextStyle(
                                color: CustomStyle.light_bn_color,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                                fontFamily: 'Roboto-Light.ttf',
                              ),
                            ),
                            Text(
                              choices[i],
                              style: TextStyle(
                                color: CustomStyle.light_bn_color,
                                letterSpacing: 1,
                                fontFamily: 'Roboto-Bold.ttf',
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        RaisedButton(
                          padding: EdgeInsets.all(22),
                          color: ctrl_buttn_color,
                          shape: CircleBorder(),
                          onPressed: () {
                            if (i == imgList.length - 1) {
                              return null;
                            } else {
                              _controller.nextPage();
                              setState(() {
                                i++;
                              });
                            }
                          },
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: ctrl_icon_color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
