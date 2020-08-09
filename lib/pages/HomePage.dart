import 'package:firebase_ex/pages/Gym.dart';
import 'HomeScreen.dart';
import 'DietChart.dart';
import 'AddButtonTemp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ex/ProgressBar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, String title}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> selections = [true, false, false, false, false];
  static PageController _pageController =
      PageController(initialPage: 0, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(248, 239, 232, 1),
//          appBar: AppBar(
//            elevation: 0,
//            backgroundColor: Colors.white24,
//            titleSpacing: 300,
//            title: IconButton(
//              onPressed: () =>
//                  Navigator.pushNamed(context, '/profile_page'),
//              icon: Icon(
//                Icons.account_circle,
//                color: Colors.black,
//              ),
//            ),
//          ),
          body: Stack(
            children: <Widget>[
              PageView(
                controller: _pageController,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                allowImplicitScrolling: true,
                children: <Widget>[
                  HomeScreen(),
                  DietChart(),
                  AddButtonTemp(),
                  GymDetail(),
                  CircleProgressBar(foregroundColor: Colors.black54, value: 50),
                ],
              ),
              Align(
                alignment: Alignment(0, 0.92),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.065,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(48, 67, 120, 1),
                  ),
                  child: ToggleButtons(
                    splashColor: Colors.yellow,
                    borderRadius: BorderRadius.circular(20),
                    fillColor: Colors.transparent,
                    borderColor: Colors.transparent,
                    onPressed: (int index) {
                      setState(() {
                        if (index == 0) {
                          selections[1] = false;
                          selections[2] = false;
                          selections[3] = false;
                          selections[4] = false;
                        } else if (index == 1) {
                          selections[0] = false;
                          selections[2] = false;
                          selections[3] = false;
                          selections[4] = false;
                        } else if (index == 2) {
                          selections[0] = false;
                          selections[1] = false;
                          selections[3] = false;
                          selections[4] = false;
                        } else if (index == 3) {
                          selections[0] = false;
                          selections[1] = false;
                          selections[2] = false;
                          selections[4] = false;
                        } else {
                          selections[0] = false;
                          selections[1] = false;
                          selections[2] = false;
                          selections[3] = false;
                        }
                      });
                    },
                    isSelected: selections,
                    children: <Widget>[
                      IconButton(
                        onPressed: () => _pageController.animateToPage(0,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn),
                        icon: Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _pageController.animateToPage(1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn),
                        icon: Icon(
                          Icons.restaurant,
                          //Icons.local_dining,//Icons.free_breakfast,//Icons.fastfood,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _pageController.animateToPage(2,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn),
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _pageController.animateToPage(3,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn),
                        icon: Icon(
                          Icons.store,
//                          Icons.trending_up,
                          //Icons.show_chart,//Icons.score,//Icons.fitness_center,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _pageController.animateToPage(4,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn),
                        icon: Icon(
                          Icons.equalizer, //Icons.assessment,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/profile_page'),
                  icon: Icon(
                    Icons.account_circle,
                    color: Color.fromRGBO(48, 67, 120, 1),
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
