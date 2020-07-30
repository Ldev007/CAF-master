import 'package:firebase_ex/Authenticate/screens/Screen_3.dart';
import 'package:flutter/material.dart';

class ScreenTwo extends StatefulWidget {
  ScreenTwo({Key key, String title}) : super(key: key);

  _ScreenTwoState createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Step 2 of 8',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 60,
        ),
        child: Column(children: [
          Text(
            'What\'s your Gender ?',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'fonts//Roboto-Bold.ttf',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 37,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.grey[100],
                padding: EdgeInsets.all(31),
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ScreenThree())),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.account_box,
                      color: Colors.black,
                    ),
                    Text(
                      'Female',
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 30,
              ),
              RaisedButton(
                color: Colors.grey[100],
                padding: EdgeInsets.only(
                  top: 31,
                  bottom: 31,
                  right: 35.5,
                  left: 35.5,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ScreenThree())),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.account_circle,
                    ),
                    Text(
                      'Male',
                    )
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}