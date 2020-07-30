import 'package:firebase_ex/Authenticate/screens/Screen_4.dart';
import 'package:flutter/material.dart';

class ScreenThree extends StatefulWidget {
  ScreenThree({Key key, String title}) : super(key: key);

  _ScreenThreeState createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ScreenFour())),
        child: Icon(
          Icons.arrow_forward_ios,
          color: Colors.black54,
        ),
        splashColor: Colors.transparent,
        backgroundColor: Colors.grey[100],
      ),
      appBar: AppBar(
        title: Text('Step 3 of 8'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 55,
        ),
        child: Column(
          children: <Widget>[
            Text(
              'How old are you ?',
              style: TextStyle(
                fontFamily: 'Roboto-Bold.ttf',
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: '0',
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
          ],
        ),
      ),
    );
  }
}