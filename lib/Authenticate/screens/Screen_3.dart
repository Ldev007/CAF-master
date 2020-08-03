import 'package:firebase_ex/Authenticate/screens/Screen_4.dart';
import 'package:firebase_ex/styling.dart';
import 'package:flutter/material.dart';

class ScreenThree extends StatefulWidget {
  final String userid;
  final String goal;
  final String gender;
  ScreenThree({Key key, String title, this.goal, this.userid, this.gender})
      : super(key: key);

  _ScreenThreeState createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {
  String age;
  Color fab_color = CustomStyle.fab_db_color;
  Color icon_color = CustomStyle.light_bn_color;
  bool buttn_state = false;

  @override
  Widget build(BuildContext context) {
    print("screen 3");
    print(widget.userid + widget.goal + widget.gender);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (buttn_state == true) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ScreenFour(
                    userid: widget.userid,
                    goal: widget.goal,
                    gender: widget.gender,
                    age: age),
              ),
            );
          }
        },
        child: Icon(
          Icons.arrow_forward_ios,
          color: icon_color,
        ),
        splashColor: Colors.transparent,
        backgroundColor: fab_color,
      ),
      appBar: AppBar(
        title: Text('Step 3 of 8', style: CustomStyle.appBar_Title),
        centerTitle: true,
        backgroundColor: CustomStyle.appBar_color,
      ),
      body: Padding(
        padding:
            EdgeInsets.only(top: CustomStyle.verticalFractions * 5.94), //55
        child: Column(
          children: <Widget>[
            Text('How old are you ?', style: CustomStyle.page_header),
            SizedBox(
              height: CustomStyle.verticalFractions * 2.7, //25
            ),
            TextField(
              maxLength: 2,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: CustomStyle.light_bn_txt_Color),
                hintText: '0',
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                border: InputBorder.none,
              ),
              onChanged: (val) {
                age = val;
                setState(() {
                  if (int.parse(age) < 90 && int.parse(age) > 10) {
                    fab_color = CustomStyle.fab_eb_color;
                    icon_color = CustomStyle.fab_icon_eb_color;
                    buttn_state = true;
                  } else {
                    fab_color = CustomStyle.fab_db_color;
                    icon_color = CustomStyle.fab_icon_db_color;
                    buttn_state = false;
                  }
                });
              },
              keyboardType: TextInputType.number,
              cursorColor: CustomStyle.light_bn_txt_Color,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: CustomStyle.verticalFractions * 9.17, //85
                color: CustomStyle.light_bn_color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
