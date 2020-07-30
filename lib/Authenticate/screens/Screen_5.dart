import 'package:firebase_ex/Authenticate/screens/Screen_6.dart';
import 'package:flutter/material.dart';

class ScreenFive extends StatefulWidget {
  final String userid;
  final String goal;
  final String gender;
  final String age;
  final String height;
  ScreenFive({Key key, String title,this.age,this.goal,this.userid,this.gender,this.height}) : super(key: key);

  _ScreenFiveState createState() => _ScreenFiveState();
}

class _ScreenFiveState extends State<ScreenFive> {
  final List<bool> forToggleButton = [false, false];
  static String suff = '';
  static Color buttn_color = Colors.grey;
  static bool buttn_state = false;
  String weight;
  @override
  Widget build(BuildContext context) {
    print("screen 5");
    print(widget.userid+" "+widget.goal+" "+widget.gender+" "+widget.age+" "+widget.height);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('Step 5 of 8'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(buttn_state == true){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ScreenSix(userid:widget.userid,goal:widget.goal,gender:widget.gender,age:widget.age,height:widget.height,weight:weight)));
          }
          else{
            return null;
          }
          },
        backgroundColor: Colors.black54,
        child: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey[200],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 75,
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'How much do you weigh?',
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: 'fonts/Roboto-Bold.ttf',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 55,
              ),
              SizedBox(
                width: 175,
                height: 70,
                child: TextField(
                  onChanged: (value){
                    weight= value;
                    setState(() {
                      if(value.length == 3){
                        buttn_state = true;
                        buttn_color = Colors.black54;
                      }
                      else{
                        buttn_state = false;
                        buttn_color = Colors.grey;
                      }
                    });
                  },
                  maxLength: 3,
                  decoration: InputDecoration(
                    suffixText: suff,
                    suffixStyle: TextStyle(
                      fontSize: 20,
                    ),
                    hintText: '55',
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
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
                    fontSize: 85,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ToggleButtons(
                splashColor: Colors.transparent,
                constraints: BoxConstraints(
                  minWidth: 100,
                  minHeight: 35,
                ),
                borderRadius: BorderRadius.circular(30),
                children: <Widget>[
                  Text('LBS'),
                  Text('KG'),
                ],
                onPressed: (int index) {
                  setState(() {
                    if (index == 0) {
                      suff = 'LBS';
                      forToggleButton[0] = true;
                      forToggleButton[1] = false;
                    } else {
                      suff = 'KGS';
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