import 'package:firebase_ex/Authenticate/screens/Screen_8.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class ScreenSeven extends StatefulWidget {
  ScreenSeven({Key key, String title}) : super(key: key);

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
                            color: Colors.black,
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

  @override
  Widget build(BuildContext context) {

    //Main Widget
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.transparent,
        child:Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ScreenEight())),
      ),
      appBar: AppBar(title: Text('Step 7 of 8')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            children: <Widget>[
              Text(
                'What\'s your body fat target ?',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'fonts/Roboto-Bold.ttf',
                ),
              ),
              SizedBox(
                height: 25,
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
                    padding: EdgeInsets.only(top: 70),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Opacity(
                            opacity: 0.7,
                            child: RaisedButton(
                              padding: EdgeInsets.all(22),
                              shape: CircleBorder(),
                              color: Colors.black87,
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
                                color: Colors.white60,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Opacity(
                            opacity: 0.7,
                            child: RaisedButton(
                              padding: EdgeInsets.all(22),
                              color: Colors.black87,
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
                                color: Colors.white70,
                              ),
                            ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'BODY FAT: ',
                    style: TextStyle(
                      letterSpacing: 1,
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      fontFamily: 'Roboto-Light.ttf',
                    ),
                  ),
                  Text(
                    choices[i],
                    style: TextStyle(
                      letterSpacing: 1,
                      fontFamily: 'Roboto-Bold.ttf',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}