import 'dart:async';

import 'package:firebase_ex/Bluetooth/prov/providers.dart';
import 'package:firebase_ex/ProgressBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../styling.dart';

class IndividualDevice extends StatefulWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final double value;

  IndividualDevice({
    Key key,
    @required this.backgroundColor,
    @required this.foregroundColor,
    @required this.value,
  }) : super(key: key);
  final double x = 0.4;

  @override
  _IndividualDeviceState createState() =>
      _IndividualDeviceState(backgroundColor: this.backgroundColor, foregroundColor: this.foregroundColor, value: this.value);
}

class _IndividualDeviceState extends State<IndividualDevice> with SingleTickerProviderStateMixin {
  //DATA
  bool shouldPaint = true;
  Animation<double> animeObj;
  AnimationController animeCont;
  int reps = 0, sets = 0;
  int setinrep = 5;
  double calories=0.0;
  double cal = 0.6;
  Color backgroundColor;

  Color foregroundColor;

  double value;

  double vf = CustomStyle.verticalFractions;

  double fifteen, twentyFive, seventeen;

  String title = 'Live Status';

  bool paint;

  Color buttonColor = Colors.black.withOpacity(0.5);
  Color inkSplashColor = CustomStyle.light_bn_txt_Color;

  Color iTextColor = Colors.white;

  int count = 0;
  bool up=false;
  String stopwatchtime= "00:00";
  final dur = const Duration(seconds: 1);
  var stopw = Stopwatch();
//CONSTRUCTOR
  _IndividualDeviceState({
    @required this.backgroundColor,
    @required this.foregroundColor,
    @required this.value,
  }) : super();

  //METHODS
  @override
  void initState() {
    super.initState();
    print('init');
    fifteen = vf * 1.54;
    twentyFive = vf * 2.566;
    seventeen = vf * 1.745;
    _read();
  }

  void _read() {
    //PUT THE READ LOGIC HERE TO READ DATA FROM SENSOR AND STORE IT IN REPS VARIABLE AND SETS VARIABLE TOO

    print('inside read');
    // reps = 5;
    _animate(reps);
    setState(() {
      paint = true;
    });
  }

  void _animate(count) {
    double ratio = count/10;
    animeCont = AnimationController(duration: Duration(seconds: 2), vsync: this);
    animeObj = Tween<double>(begin: 0, end: ratio).animate(animeCont)
      ..addListener(() {
        setState(() {});
      });
    // print(animeObj.value);
    animeCont.forward();
  }
  void setcounter(int cm){
    if (cm >= 15 && cm <= 21) {
      up = true;
      // count++;
    }
    // if (cm >= 80)
    else if(cm>=5 && cm<=8){//&& cm <= 101
      if (up) {
        count++;
        setState(() {
          if(reps==setinrep-1){
            sets = sets+1;
            reps=0;
            count=0;
          }
          else {
            reps = count;
          }
          calories = sets>0?((reps+(sets*setinrep))*cal):(reps*cal);
        });
        print(count);
        up = false;
      }
    }

  }

  void statimer(){
      Timer(dur, keeprunning);
  }
  void keeprunning(){
    if(stopw.isRunning){
      statimer();
    }
    setState(() {
      stopwatchtime = (stopw.elapsed.inMinutes%60).toString().padLeft(2,"0")+":"+(stopw.elapsed.inSeconds%60).toString().padLeft(2,"0");
    });
  }
  void sta()
  {
    stopw.start();
  }
  @override
  Widget build(BuildContext context) {
    final backgroundColor = this.backgroundColor;
    final foregroundColor = this.foregroundColor;
    print('B : ' + backgroundColor.toString() + ', F : ' + foregroundColor.toString());
    return Consumer(
      builder: (context,watch,child){
        final userProvider = watch(Providers.userProvider);
        userProvider.addListener(() {
          setcounter(userProvider.getcm);
        });
        return Container(
          decoration: BoxDecoration(
            gradient: CustomStyle.gradientBGColor,
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.info_outline,
                    color: Colors.white,
                  ),
                  onPressed: () => showDialog(
                    barrierColor: Colors.black87,
                    context: context,
                    child: Dialog(
                      backgroundColor: Colors.grey[800],
                      insetPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.4,
                        padding: EdgeInsets.symmetric(horizontal: fifteen, vertical: fifteen),
                        child: PageView(
                          children: [
                            Column(
                              children: [
                                Text(
                                  'REPS',
                                  style: TextStyle(
                                    color: iTextColor,
                                    fontSize: twentyFive,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                SizedBox(height: vf * 5.133), //50
                                Text(
                                  'Reps counter is represented by cyan colored progress bar',
                                  style: TextStyle(
                                    color: iTextColor,
                                    fontSize: seventeen,
                                    letterSpacing: 1.5,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'STEPS',
                                  style: TextStyle(
                                    color: iTextColor,
                                    fontSize: twentyFive,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                SizedBox(height: vf * 5.133), //50
                                Text(
                                  'Steps counter is represented by lime green colored progress bar',
                                  style: TextStyle(
                                    color: iTextColor,
                                    fontSize: seventeen,
                                    letterSpacing: 1.5,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Calories & Weight',
                                  style: TextStyle(
                                    color: iTextColor,
                                    fontSize: twentyFive,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                SizedBox(height: vf * 5.133), //50
                                Text(
                                  'According to reps & sets done, calories burnt will be displayed below the progress bars. Your set target weight will be displayed beside the calories burnt.',
                                  style: TextStyle(
                                    color: iTextColor,
                                    fontSize: seventeen,
                                    letterSpacing: 1.5,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Timer',
                                  style: TextStyle(
                                    color: iTextColor,
                                    fontSize: twentyFive,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                SizedBox(height: vf * 5.133), //50
                                Text(
                                  'To keep track of time there\'s a timer at the right of progress bar',
                                  style: TextStyle(
                                    color: iTextColor,
                                    fontSize: seventeen,
                                    letterSpacing: 1.5,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Thanks !',
                                  style: TextStyle(
                                    color: iTextColor,
                                    fontSize: twentyFive,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                SizedBox(height: vf * 5.133), //50
                                Text(
                                  'Thanks for using our app. Hope it helped you in enhancing your fitness lifestyle.',
                                  style: TextStyle(
                                    color: iTextColor,
                                    fontSize: seventeen,
                                    letterSpacing: 1.5,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    RaisedButton(child: Text("start"),onPressed: (){
                      sta();
                      statimer();
                    },),
                    Expanded(
                      child: Container(
                        child: Stack(
                          children: [
                            Positioned(
                              top: -20,
                              left: MediaQuery.of(context).size.width / 4,
                              child: CustomPaint(
                                child: Container(
                                  color: Colors.transparent,
                                  width: MediaQuery.of(context).size.width * 0.49,
                                  height: MediaQuery.of(context).size.height * 0.4,
                                ),
                                foregroundPainter: PaintProgressBar(
                                  bkgColor: this.backgroundColor,
                                  frgColor: Color.fromRGBO(186, 247, 3, 1),
                                  percentage: paint ? animeObj.value : 0.0,
                                  strokeWidth: vf * 0.821, //8
                                  shadowColor: Color.fromRGBO(49, 77, 2, 1),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -20,
                              left: MediaQuery.of(context).size.width / 3.5,
                              child: CustomPaint(
                                child: Container(
                                  color: Colors.transparent,
                                  width: MediaQuery.of(context).size.width * 0.42,
                                  height: MediaQuery.of(context).size.height * 0.4,
                                ),
                                foregroundPainter: PaintProgressBar(
                                  bkgColor: this.backgroundColor,
                                  frgColor: Colors.cyanAccent,
                                  percentage: paint ? animeObj.value : 0.0,
                                  strokeWidth: vf * 0.821, //8
                                  shadowColor: Colors.cyan[900],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 158,
                              left: MediaQuery.of(context).size.width / 3.5,
                              child: Container(
                                width: CustomStyle.verticalFractions * 18.48,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        reps.toString(),
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: CustomStyle.verticalFractions * 4, //70
                                          color: Colors.cyanAccent,
                                          fontFamily: 'fonts/Anton-Regular.ttf',
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(1, 1),
                                              blurRadius: vf * 2.053, //20
                                              color: Colors.black38,
                                            )
                                          ],
                                        ),
                                      ),
                                      Text(
                                        sets.toString(),
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          height: CustomStyle.verticalFractions * 0.15, //2.9
                                          fontSize: CustomStyle.verticalFractions * 2.4, //254
                                          color: Color.fromRGBO(186, 247, 3, 1),
                                          fontFamily: 'fonts/Anton-Regular.ttf',
                                          shadows: [
                                            Shadow(
                                              offset: Offset(1, 1),
                                              blurRadius: vf * 2.053, //20
                                              color: Colors.black38,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.height * 0.315,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: vf * 3.08, //30
                                        vertical: vf * 0.821, //8
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(twentyFive),
                                          border: Border.all(
                                            color: Colors.cyanAccent,
                                          )),
                                      child: Text(
                                        'REPS',
                                        style: TextStyle(
                                          fontSize: fifteen, //15
                                          letterSpacing: 1.5,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.cyanAccent,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: vf * 5.133), //50
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: vf * 3.08, //30
                                        vertical: vf * 0.821, //8
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(twentyFive),
                                          border: Border.all(
                                            color: Color.fromRGBO(186, 247, 3, 1),
                                          )),
                                      child: Text(
                                        'SETS',
                                        style: TextStyle(
                                            color: Color.fromRGBO(186, 247, 3, 1),
                                            fontSize: fifteen, //15
                                            letterSpacing: 1.5,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Positioned(
                            //   top: 270,
                            //   child: Container(
                            //     width: MediaQuery.of(context).size.width,
                            //     padding: EdgeInsets.symmetric(
                            //       vertical: vf * 9.753, //95
                            //     ),
                            //     decoration: BoxDecoration(
                            //       color: Color.fromRGBO(48, 67, 120, 0.0),
                            //     ),
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //       children: <Widget>[
                            //         Column(
                            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //           children: <Widget>[
                            //             // SizedBox(height: CustomStyle.verticalFractions * 2.157), //20
                            //             Text(
                            //               '150',
                            //               style: TextStyle(
                            //                 fontSize: CustomStyle.verticalFractions * 2.3, //30
                            //                 color: Colors.white,
                            //                 fontWeight: FontWeight.bold,
                            //               ),
                            //             ),
                            //             // ImageIcon(
                            //             //   AssetImage('images/fire.png'),
                            //             //   color: Colors.orange,
                            //             //   size: 20,
                            //             // ),
                            //             Text(
                            //               'Cal',
                            //               style: TextStyle(
                            //                 color: Colors.white, //Color.fromRGBO(192, 196, 228, 0.5),
                            //                 fontSize: CustomStyle.verticalFractions * 1.7, //26
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //         Column(
                            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //           children: <Widget>[
                            //             // SizedBox(width: CustomStyle.verticalFractions * 7.8), //10
                            //             // SizedBox(height: CustomStyle.verticalFractions * 2.157), //20
                            //             Text(
                            //               '150',
                            //               style: TextStyle(
                            //                 fontSize: CustomStyle.verticalFractions * 2.2, //30
                            //                 color: Colors.white,
                            //                 fontWeight: FontWeight.bold,
                            //               ),
                            //             ),
                            //             // ImageIcon(
                            //             //   AssetImage('images/dumbbell.png'),
                            //             //   color: Colors.white,
                            //             //   size: 20,
                            //             // )
                            //             Text(
                            //               'lbs',
                            //               style: TextStyle(
                            //                 color: Colors.white,
                            //                 fontSize: CustomStyle.verticalFractions * 1.7, //26
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // Positioned(
                            //     top: 265,
                            //     left: MediaQuery.of(context).size.width * 0.87,
                            //     child: CustomPaint(
                            //       child: Container(
                            //         width: vf * 4.106, //40
                            //         height: vf * 4.106, //40
                            //         child: Center(
                            //             child: Text(
                            //           '5',
                            //           style: TextStyle(
                            //             color: Colors.white,
                            //             fontSize: vf * 2.053, //20
                            //             fontWeight: FontWeight.bold,
                            //           ),
                            //         )),
                            //       ),
                            //       foregroundPainter: PaintProgressBar(
                            //         frgColor: Colors.white.withOpacity(0.88),
                            //         bkgColor: Colors.black54,
                            //         percentage: animeObj.value,
                            //         strokeWidth: vf * 0.410, //4
                            //       ),
                            //     ))
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(stopwatchtime, style: TextStyle(fontSize: 50, color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 20,
                          children: [
                            FlatButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                              color: buttonColor,
                              splashColor: inkSplashColor,
                              onPressed: () => null,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ImageIcon(
                                    AssetImage('images/fire.png'),
                                    color: Colors.orange,
                                    size: 50,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(calories.toStringAsPrecision(2),
                                          style: TextStyle(
                                            fontSize: vf * 3, //18
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      SizedBox(width: 5),
                                      Text('KCAL',
                                          style: TextStyle(
                                            fontSize: vf * 1.6, //18
                                            color: Colors.white,
                                            height: 2,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            FlatButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                              onPressed: () => null,
                              color: buttonColor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ImageIcon(
                                    AssetImage('images/dumbbell.png'),
                                    color: Colors.white,
                                    size: 70,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '150',
                                        style: TextStyle(
                                          fontSize: vf * 3, //18
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'KGS',
                                        style: TextStyle(
                                          fontSize: vf * 1.6, //18
                                          color: Colors.white,
                                          height: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            FlatButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                              onPressed: () => null,
                              color: buttonColor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.mobile_screen_share,
                                    color: Colors.green,
                                    size: 50,
                                  ),
                                  Text('Machine Status'.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: vf * 1.848, //18
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text(
                                    "Everything seems fine",
                                    style: TextStyle(
                                      color: Colors.white,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            FlatButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                              onPressed: () => null,
                              color: buttonColor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.shutter_speed,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                  Text(
                                    'SPEED',
                                    style: TextStyle(
                                      fontSize: vf * 1.848, //18
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // child: Container(
                      //     padding: EdgeInsets.only(top: 100),
                      //     child:
                      //       ],
                      //     )
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
