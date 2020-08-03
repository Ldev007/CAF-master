import 'package:firebase_ex/Authenticate/screens/Screen_3.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ex/styling.dart';

class ScreenTwo extends StatefulWidget {
  final String userid;
  final String goal;
  ScreenTwo({Key key, String title, this.userid, this.goal}) : super(key: key);

  _ScreenTwoState createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  @override
  Widget build(BuildContext context) {
    print("screen 2");
    print(widget.userid + widget.goal);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomStyle.appBar_color,
        title: Text(
          'Step 2 of 8',
          style: CustomStyle.appBar_Title,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: CustomStyle.verticalFractions * 7, //65
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('What\'s your Gender ?', style: CustomStyle.page_header),
            SizedBox(
              height: CustomStyle.verticalFractions * 5, //46
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: CustomStyle.light_bn_color,
                  padding: EdgeInsets.symmetric(
                      horizontal: CustomStyle.verticalFractions * 6.9,
                      vertical: CustomStyle.verticalFractions * 3.25),
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ScreenThree(
                              userid: widget.userid,
                              goal: widget.goal,
                              gender: "Female"))),
                  child: Column(
                    children: <Widget>[
                      ImageIcon(
                        AssetImage('images/woman.jpg'),
                        size: CustomStyle.verticalFractions * 3.78, //35
                        color: CustomStyle.light_bn_txt_Color,
                      ),
                      Text('Female', style: CustomStyle.button_footer)
                    ],
                  ),
                ),
                SizedBox(
                  width: CustomStyle.verticalFractions * 3.25, //30
                ),
                RaisedButton(
                  color: CustomStyle.light_bn_color,
                  padding: EdgeInsets.symmetric(
                      horizontal: CustomStyle.verticalFractions * 8,
                      vertical: CustomStyle.verticalFractions * 3.25),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ScreenThree(
                              userid: widget.userid,
                              goal: widget.goal,
                              gender: "Male"))),
                  child: Column(
                    children: <Widget>[
                      ImageIcon(
                        AssetImage('images/man.png'),
                        size: CustomStyle.verticalFractions * 3.78,
                        color: CustomStyle.light_bn_txt_Color,
                      ),
                      Text('Male', style: CustomStyle.button_footer)
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            RaisedButton(
              color: CustomStyle.light_bn_color,
              padding: EdgeInsets.symmetric(
                  horizontal: CustomStyle.verticalFractions * 5.8,
                  vertical: CustomStyle.verticalFractions * 3.25),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ScreenThree(
                          userid: widget.userid,
                          goal: widget.goal,
                          gender: "Male"))),
              child: Column(
                children: <Widget>[
                  ImageIcon(
                    AssetImage('images/trans.png'),
                    size: CustomStyle.verticalFractions * 3.78,
                    color: CustomStyle.light_bn_txt_Color,
                  ),
                  Text('Transgender', style: CustomStyle.button_footer)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
