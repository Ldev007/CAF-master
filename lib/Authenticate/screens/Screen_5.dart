import 'package:firebase_ex/Authenticate/screens/Screen_6.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ex/styling.dart';

class ScreenFive extends StatefulWidget {
  final String userid;
  final String goal;
  final String gender;
  final String age;
  final String height;
  ScreenFive(
      {Key key,
      String title,
      this.age,
      this.goal,
      this.userid,
      this.gender,
      this.height})
      : super(key: key);

  _ScreenFiveState createState() => _ScreenFiveState();
}

class _ScreenFiveState extends State<ScreenFive> {
  final List<bool> forToggleButton = [false, true];
  static String suff = 'KG';
  static Color buttonColor = CustomStyle.fab_db_color;
  Color iconColor = CustomStyle.fab_icon_db_color;
  static bool buttonState = false;
  int maxLen = 3;
  String hintText = '55';

  String weight;
  @override
  Widget build(BuildContext context) {
    print("screen 5");
    print(widget.userid +
        " " +
        widget.goal +
        " " +
        widget.gender +
        " " +
        widget.age +
        " " +
        widget.height);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomStyle.appBar_color,
        title: Text('Step 5 of 8', style: CustomStyle.appBar_Title),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (buttonState == true) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ScreenSix(
                        userid: widget.userid,
                        goal: widget.goal,
                        gender: widget.gender,
                        age: widget.age,
                        height: widget.height,
                        weight: weight)));
          } else {
            return null;
          }
        },
        backgroundColor: buttonColor,
        child: Icon(
          Icons.arrow_forward_ios,
          color: iconColor,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: CustomStyle.verticalFractions * 8.1, //75
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Text('How much do you weigh?', style: CustomStyle.page_header),
              SizedBox(
                height: CustomStyle.verticalFractions * 5.94, //55
              ),
              SizedBox(
                width: CustomStyle.verticalFractions * 24, //175
                height: CustomStyle.verticalFractions * 7.56, //70
                child: TextField(
                  onChanged: (value) {
                    weight = value;
                    setState(() {
                      if ((weight.length <= 3 &&
                              int.parse(weight) < 635 &&
                              int.parse(weight) >= 10 &&
                              suff.compareTo('KG') == 0) ||
                          (weight.length <= 4 &&
                              int.parse(weight) < 1400 &&
                              int.parse(weight) >= 10 &&
                              suff.compareTo('LB') == 0)) {
                        buttonState = true;
                        buttonColor = CustomStyle.fab_eb_color;
                        iconColor = CustomStyle.fab_icon_eb_color;
                      } else {
                        buttonState = false;
                        buttonColor = CustomStyle.fab_db_color;
                        iconColor = CustomStyle.fab_icon_db_color;
                      }
                    });
                  },
                  maxLength: maxLen, //3
                  decoration: InputDecoration(
                    counterText: '',
                    suffixText: suff,
                    suffixStyle: TextStyle(
                      fontSize: CustomStyle.verticalFractions * 2.16, //20
                    ),
                    hintText: hintText,
                    hintStyle: TextStyle(
                      color: CustomStyle.light_bn_txt_Color,
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.white,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: CustomStyle.verticalFractions * 9.17, //85
                    color: CustomStyle.light_bn_color,
                  ),
                ),
              ),
              SizedBox(
                height: CustomStyle.verticalFractions * 1.62, //15
              ),
              ToggleButtons(
                fillColor: CustomStyle.toggle_Fill_Color,
                selectedBorderColor: CustomStyle.toggle_Border_Color,
                borderColor: CustomStyle.toggle_Border_Color,
                selectedColor: CustomStyle.toggle_Sel_txt_Color,
                splashColor: Colors.transparent,
                constraints: BoxConstraints(
                  minWidth: CustomStyle.verticalFractions * 10.79, //100
                  minHeight: CustomStyle.verticalFractions * 3.78, //35
                ),
                borderRadius: BorderRadius.circular(30),
                children: <Widget>[
                  Text('LB'),
                  Text('KG'),
                ],
                onPressed: (int index) {
                  setState(() {
                    if (index == 0) {
                      suff = 'LB';
                      hintText = '121';
                      maxLen = 4;
                      forToggleButton[0] = true;
                      forToggleButton[1] = false;
                    } else {
                      suff = 'KG';
                      hintText = '55';
                      maxLen = 3;
                      forToggleButton[1] = true;
                      forToggleButton[0] = false;
                    }
                  });
                },
                isSelected: forToggleButton,
              )
            ],
          ),
        ),
      ),
    );
  }
}
