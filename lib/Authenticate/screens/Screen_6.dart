import 'package:firebase_ex/Authenticate/screens/Screen_7.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ex/styling.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'images/tum1.jpg',
  'images/tum2.jpg',
  'images/tum3.jpg',
  'images/tum4.jpg',
  'images/tum5.jpg',
  'images/tum6.jpg',
  'images/tum7.jpg',
];

class ScreenSix extends StatefulWidget {
  final String userid;
  final String goal;
  final String gender;
  final String age;
  final String height;
  final String weight;
  ScreenSix(
      {Key key,
      String title,
      this.age,
      this.goal,
      this.userid,
      this.gender,
      this.height,
      this.weight})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ScreenSixState();
  }
}

class _ScreenSixState extends State<ScreenSix> {
  static int i = 0;
  Color ctrlButtonColor = CustomStyle.light_bn_color;
  Color ctrlIconColor = CustomStyle.light_bn_txt_Color;

  //Carousel controller mainly used for controlling the scrolling
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

  //Carousel Design
  final List<Widget> imageSliders = imgList
      .map(
        (item) => Container(
          child: Container(
            margin: EdgeInsets.all(CustomStyle.verticalFractions * 0.54),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                  Radius.circular(CustomStyle.verticalFractions * 0.54)),
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    item,
                    fit: BoxFit.fitWidth,
                    width: CustomStyle.verticalFractions * 107.87,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CustomStyle.light_bn_color,
                        width: CustomStyle.verticalFractions * 0.26,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: CustomStyle.verticalFractions * 9.924,
                      horizontal: CustomStyle.verticalFractions * 2.157,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
      .toList();
  String currentfat;

  @override
  Widget build(BuildContext context) {
    print(CustomStyle.verticalFractions);
    print("screen 6");
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
        widget.weight);

    //Main Widget
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: CustomStyle.fab_eb_color,
          child: Icon(
            Icons.arrow_forward_ios,
            color: CustomStyle.fab_icon_eb_color,
          ),
          onPressed: () => {
                currentfat = choices[i],
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ScreenSeven(
                            userid: widget.userid,
                            goal: widget.goal,
                            gender: widget.gender,
                            age: widget.age,
                            height: widget.height,
                            weight: widget.weight,
                            currentfat: currentfat))),
              }),
      appBar: AppBar(
        title: Text('Step 6 of 8', style: CustomStyle.appBar_Title),
        backgroundColor: CustomStyle.appBar_color,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(top: CustomStyle.verticalFractions * 7), //92.7
          child: Column(
            children: <Widget>[
              Text(
                'Estimate your current body fat',
                style: TextStyle(
                  color: CustomStyle.page_header.color,
                  fontSize: CustomStyle.page_header.fontSize - 6,
                  fontWeight: CustomStyle.page_header.fontWeight,
                ),
              ),
              SizedBox(
                height: CustomStyle.verticalFractions * 4.854,
              ),
              Stack(
                children: <Widget>[
                  CarouselSlider(
                    items: imageSliders,
                    options: CarouselOptions(
                      //Change the subtitle on scroll action
                      onScrolled: (index) {
                        int ind = index.round();
                        switch (ind) {
                          case 0:
                            setState(() {
                              i = 0;
                            });
                            break;
                          case 1:
                            setState(() {
                              i = 1;
                            });
                            break;
                          case 2:
                            setState(() {
                              i = 2;
                            });
                            break;
                          case 3:
                            setState(() {
                              i = 3;
                            });
                            break;
                          case 4:
                            setState(() {
                              i = 4;
                            });
                            break;
                          case 5:
                            setState(() {
                              i = 5;
                            });
                            break;
                          case 6:
                            setState(() {
                              i = 6;
                            });
                            break;
                          case 7:
                            setState(() {
                              i = 7;
                            });
                            break;
                          case 8:
                            setState(() {
                              i = 8;
                            });
                            break;
                          default:
                            i = 0;
                            break;
                        }
                      },
                      enlargeCenterPage: true,
                      height: CustomStyle.verticalFractions * 25,
                      enableInfiniteScroll: false,
                    ),
                    carouselController: _controller,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: CustomStyle.verticalFractions * 28.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RaisedButton(
                          padding: EdgeInsets.all(
                              CustomStyle.verticalFractions * 2.2), //27
                          shape: CircleBorder(),
                          color: ctrlButtonColor,
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
                            color: ctrlIconColor,
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
                          padding: EdgeInsets.all(
                              CustomStyle.verticalFractions * 2.3),
                          color: ctrlButtonColor,
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
                            color: ctrlIconColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: CustomStyle.verticalFractions * 1.294,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
