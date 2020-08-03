import 'package:flutter/material.dart';
import 'Screen_2.dart';
import 'package:firebase_ex/styling.dart';

class ScreenOne extends StatefulWidget {
  final String userid;
  ScreenOne({Key key, String title, this.userid}) : super(key: key);

  _ScreenOneState createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  @override
  Widget build(BuildContext context) {
    print(widget.userid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomStyle.appBar_color,
        elevation: 0,
        title: Text(
          'Step 1 of 8',
          style: CustomStyle.appBar_Title,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 70,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'What\'s your goal ?',
                style: CustomStyle.page_header,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              RaisedButton(
                color: CustomStyle.light_bn_color,
                splashColor: Colors.transparent,
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () => {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ScreenTwo(userid: widget.userid, goal: "Get Fitter"),
                    ),
                  ),
                },
                padding: EdgeInsets.only(
                  top: CustomStyle.verticalFractions * 3.78, //35
                  left: CustomStyle.verticalFractions * 3.235, //30
                  right: CustomStyle.verticalFractions * 17.26, //160
                  bottom: CustomStyle.verticalFractions * 3.78, //35
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Get Fitter', style: CustomStyle.button_header),
                    SizedBox(
                      height: 3,
                    ),
                    Text('Tone up & \'feel healthy',
                        style: CustomStyle.button_footer)
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: CustomStyle.light_bn_color,
                splashColor: Colors.transparent,
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ScreenTwo(
                            userid: widget.userid, goal: "Gain Muscle"))),
                padding: EdgeInsets.only(
                  top: CustomStyle.verticalFractions * 3.78, //35
                  left: CustomStyle.verticalFractions * 3.235, //30
                  right: CustomStyle.verticalFractions * 17.75, //160
                  bottom: CustomStyle.verticalFractions * 3.78, //35
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Gain Muscle', style: CustomStyle.button_header),
                    SizedBox(
                      height: 3,
                    ),
                    Text('Build mass & strength',
                        style: CustomStyle.button_footer)
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: CustomStyle.light_bn_color,
                splashColor: Colors.transparent,
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ScreenTwo(
                            userid: widget.userid, goal: "Lose Weight"))),
                padding: EdgeInsets.only(
                  top: CustomStyle.verticalFractions * 3.78, //35
                  left: CustomStyle.verticalFractions * 3.235, //30
                  right: CustomStyle.verticalFractions * 14.7, //110
                  bottom: CustomStyle.verticalFractions * 3.78, //35
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Lose weight', style: CustomStyle.button_header),
                    SizedBox(
                      height: 3,
                    ),
                    Text('Get motivated & energized',
                        style: CustomStyle.button_footer)
                  ],
                ),
              ),
              SizedBox(height: 20),
              //TEMPORARY BUTTON FOR DIRECT NAVIGATION
              RaisedButton(
                child:
                    Text('TEMPORARY BUTTON', style: CustomStyle.button_header),
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 50),
                onPressed: () {
                  Navigator.pushNamed(context, "/home_page");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
