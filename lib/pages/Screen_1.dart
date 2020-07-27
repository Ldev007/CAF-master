import 'package:flutter/material.dart';


class ScreenOne extends StatefulWidget {
  ScreenOne({Key key, String title}) : super(key: key);

  _ScreenOneState createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Step 1 of 8',
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 60,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'What\'s your goal ?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 27,
                      fontFamily: 'fonts/Roboto-Bold.ttf'),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  splashColor: Colors.transparent,
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () => Navigator.pushNamed(context, '/second_screen'),
                  color: Colors.grey[100],
                  padding: EdgeInsets.only(
                    top: 25,
                    left: 30,
                    right: 130,
                    bottom: 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Text(
                          'Get Fitter',
                          style: TextStyle(
                            fontFamily: 'fonts/Roboto-Bold.ttf',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        'Tone up & \'feel healthy',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'fonts/Roboto-Light.ttf',
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  splashColor: Colors.transparent,
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.grey[100],
                  onPressed: () =>  Navigator.pushNamed(context, '/second_screen'),
                  padding: EdgeInsets.only(
                    top: 25,
                    left: 32,
                    right: 130,
                    bottom: 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Text(
                          'Gain Muscle',
                          style: TextStyle(
                            fontFamily: 'fonts/Roboto-Bold.ttf',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        'Build mass & strength',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'fonts/Roboto-Light.ttf',
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  splashColor: Colors.transparent,
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.grey[100],
                  onPressed: () => Navigator.pushNamed(context, '/second_screen'),
                  padding: EdgeInsets.only(
                    top: 25,
                    left: 28,
                    right: 110,
                    bottom: 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Text(
                          'Lose weight',
                          style: TextStyle(
                            fontFamily: 'fonts/Roboto-Bold.ttf',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        'Get motivated & energized',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'fonts/Roboto-Light.ttf',
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ),
                //TEMPORARY BUTTON FOR DIRECT NAVIGATION
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 50),
                  onPressed: (){Navigator.pushNamed(context, "/profile_page");},
                ),
              ],
            ),
          ),
        ),
        );
  }
}