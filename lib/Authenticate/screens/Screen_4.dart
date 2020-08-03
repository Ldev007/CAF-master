import 'package:firebase_ex/Authenticate/screens/Screen_5.dart';
import 'package:firebase_ex/styling.dart';
import 'package:flutter/material.dart';

class ScreenFour extends StatefulWidget {
  final String userid;
  final String goal;
  final String gender;
  final String age;
  ScreenFour(
      {Key key, String title, this.gender, this.userid, this.goal, this.age})
      : super(key: key);

  _ScreenFourState createState() => _ScreenFourState();
}

class _ScreenFourState extends State<ScreenFour> {
  bool buttn_state = false;
  Color buttn_color = CustomStyle.fab_db_color;
  Color icon_color = CustomStyle.fab_icon_db_color;
  String hint_text = '175';
  int max_len = 3;

  final List<bool> forToggleButton = [false, true];
  static String suff = 'CM';
  String height;
  @override
  Widget build(BuildContext context) {
    print("screen 4");
    print(widget.userid + widget.goal + widget.gender);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomStyle.appBar_color,
        title: Text('Step 4 of 8', style: CustomStyle.appBar_Title),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (buttn_state == true) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ScreenFive(
                        userid: widget.userid,
                        goal: widget.goal,
                        gender: widget.gender,
                        age: widget.age,
                        height: height)));
          } else {
            return null;
          }
        },
        backgroundColor: buttn_color,
        child: Icon(
          Icons.arrow_forward_ios,
          color: icon_color,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: CustomStyle.verticalFractions * 8.1),
        child: Center(
          child: Column(
            children: <Widget>[
              Text('How tall are you ?', style: CustomStyle.page_header),
              SizedBox(height: CustomStyle.verticalFractions * 5.94),
              SizedBox(
                width: CustomStyle.verticalFractions * 22, //175
                height: CustomStyle.verticalFractions * 7.6, //70
                child: TextField(
                  onChanged: (value) {
                    height = value;
                    setState(() {
                      if ((height.length >= 1 &&
                              int.parse(height) < 272 &&
                              int.parse(height) > 100 &&
                              suff.compareTo('CM') == 0) ||
                          (height.length >= 1 &&
                              double.parse(height) < 8.92 &&
                              double.parse(height) > 1.79 &&
                              suff.compareTo('FT') == 0)) {
                        buttn_state = true;
                        buttn_color = CustomStyle.fab_eb_color;
                        icon_color = CustomStyle.fab_icon_eb_color;
                      } else {
                        buttn_state = false;
                        buttn_color = CustomStyle.fab_db_color;
                        icon_color = CustomStyle.fab_icon_db_color;
                      }
                    });
                  },
                  maxLength: max_len, //3
                  decoration: InputDecoration(
                    counterText: '',
                    suffixText: suff,
                    suffixStyle: TextStyle(
                      fontSize: CustomStyle.verticalFractions * 1.8, //16.686
                      color: CustomStyle.light_bn_color,
                    ),
                    hintText: hint_text,
                    hintStyle: TextStyle(
                      color: CustomStyle.light_bn_txt_Color,
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                  cursorColor: CustomStyle.light_bn_txt_Color,
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
                borderColor: CustomStyle.toggle_Border_Color,
                selectedBorderColor: CustomStyle.toggle_Border_Color,
                selectedColor: CustomStyle.light_bn_txt_Color,
                splashColor: Colors.transparent,
                constraints: BoxConstraints(
                  minWidth: CustomStyle.verticalFractions * 10.79, //100
                  minHeight: CustomStyle.verticalFractions * 3.78, //35
                ),
                borderRadius: BorderRadius.circular(
                    CustomStyle.verticalFractions * 3.245), //30
                children: <Widget>[
                  Text('FT',
                      style: TextStyle(color: CustomStyle.light_bn_color)),
                  Text('CM',
                      style: TextStyle(color: CustomStyle.light_bn_color)),
                ],
                onPressed: (int index) {
                  setState(() {
                    if (index == 0) {
                      suff = 'FT';
                      hint_text = '5';
                      max_len = 4;
                      forToggleButton[0] = true;
                      forToggleButton[1] = false;
                    } else {
                      suff = 'CM';
                      hint_text = '175';
                      max_len = 3;
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
