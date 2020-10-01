import 'package:flutter/material.dart';
import 'package:firebase_ex/pages/progress.dart';
import 'package:firebase_ex/pages/specialprograms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../styling.dart';
import 'bodyparts.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, String title}) : super(key: key);

  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

//COLOR PROPS
final Color darkPurple = CustomStyle.light_bn_color;

//MULTIPLIER SHORTCUTS
final double vf = CustomStyle.verticalFractions;

class _HomeScreenState extends State<HomeScreen> {
  String name = "";
  void initState() {
    super.initState();
    fetch();
  }

  void fetch(
      {bool isWaterInput = false, double amount = 0, String metric}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("username");

    if (isWaterInput) {
      double currAmount;

      metric == "Glasses" ? amount = amount * 0.147 : amount = amount;

      prefs.getDouble('waterIntake') != null
          ? currAmount = prefs.getDouble('waterIntake')
          : currAmount = 0;

      prefs.setDouble('waterIntake', currAmount + amount);

      // print(prefs.getDouble('waterIntake'));
    }
  }

  String obj = 'Glasses';
  FocusNode fNodeForDialog;
  Color colr = CustomStyle.light_bn_color;
  TextEditingController cont = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // appBar: AppBar(
      //      elevation: 0,
      //      backgroundColor: Colors.transparent,
      //      title:Text(
      //        'Hello',
      //        style: TextStyle(
      //          color: Colors.grey[700],
      //          fontWeight: FontWeight.w600,
      //          fontSize: 30,
      //        ),
      //      ),
      //    ),
      body: Padding(
        padding: EdgeInsets.all(vf * 2.053), //20
        child: new ListView(
          children: <Widget>[
            Text(
              'Hello',
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w600,
                fontSize: vf * 3.08, //30
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: vf * 0.821), //8
              child: Text(
                name,
                style: TextStyle(
                  // color: Colors.black,
                  // fontWeight: FontWeight.w600,
                  // fontSize: 40,
                  color: darkPurple,
                  fontWeight: FontWeight.bold,
                  decorationThickness: vf * 0.086,
                  decorationColor: darkPurple,
                  fontSize: vf * 3.593, //35
                ),
              ),
            ),

            progress(),
            // Padding(
            //   padding: EdgeInsets.only(left: 10, top: 20, right: 0, bottom: 5),
            //   child: Text(
            //     'Continue',
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontWeight: FontWeight.w500,
            //       fontSize: 20,
            //     ),
            //   ),
            // ),
            // lastused(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: vf * 1.026, //10
                    top: vf * 2.053, //20
                    right: 0,
                    bottom: vf * 0.513, //5
                  ),
                  child: Text(
                    'Special Programs',
                    style: TextStyle(
                      color: darkPurple,
                      fontWeight: FontWeight.bold,
                      decorationThickness: vf * 0.086,
                      decorationColor: darkPurple,
                      fontSize: vf * 2.258, //22
                    ),
                  ),
                ),
                RaisedButton(
                  elevation: vf * 0.513, //5
                  padding: EdgeInsets.symmetric(
                    vertical: vf * 0.821, //8
                    horizontal: vf * 1.54, //15
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(vf * 1.232), //12
                      side: BorderSide(
                        color: CustomStyle.light_bn_color,
                        width: vf * 0.102, //1
                      )),
                  onPressed: () {
                    return showDialog(
                      context: context,
                      builder: (context) => StatefulBuilder(
                          builder: (context, StateSetter setState) {
                        return SimpleDialog(
                          contentPadding: EdgeInsets.only(
                            top: vf * 5.133, //50
                            bottom: vf * 2.053, //20
                            left: vf * 3.08, //30
                            right: vf * 3.08, //30
                          ),
                          title: Text('Enter the amount below',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: vf * 2.566, //25
                                fontWeight: FontWeight.bold,
                                color: CustomStyle.light_bn_color,
                              )),
                          children: [
                            TextField(
                              cursorWidth: vf * 0.154, //1.5
                              keyboardType: TextInputType.number,
                              controller: cont,
                              style: TextStyle(
                                fontSize: vf * 1.848, //18
                                color: CustomStyle.light_bn_color,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                suffixText: obj,
                                suffixStyle: TextStyle(
                                    color: CustomStyle.light_bn_color),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: CustomStyle.light_bn_color),
                                  borderRadius:
                                      BorderRadius.circular(vf * 1.232), //12
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: vf * 0.154, //1.5
                                      color: CustomStyle.light_bn_color),
                                  borderRadius:
                                      BorderRadius.circular(vf * 1.232), //12
                                ),
                              ),
                              cursorColor: CustomStyle.light_bn_color,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: obj,
                                  items: [
                                    DropdownMenuItem(
                                        child: Text(
                                          'Glasses',
                                          style: TextStyle(
                                              color: colr,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        value: 'Glasses'),
                                    DropdownMenuItem(
                                        child: Text('Litres',
                                            style: TextStyle(
                                                color: colr,
                                                fontWeight: FontWeight.bold)),
                                        value: 'Litres')
                                  ],
                                  onChanged: (val) {
                                    obj = val;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: vf * 1.54), //15
                            Align(
                              alignment: Alignment.bottomRight,
                              child: RaisedButton(
                                padding: EdgeInsets.symmetric(
                                  horizontal: vf * 3.593, //35
                                  vertical: vf * 1.232, //12
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                  vf * 0.821, //8
                                )),
                                color: CustomStyle.light_bn_color,
                                onPressed: () {
                                  fetch(
                                      isWaterInput: true,
                                      amount: double.parse(cont.text),
                                      metric: obj);
                                  Navigator.pop(context);
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    backgroundColor: CustomStyle.light_bn_color,
                                    content: Text(
                                        '${cont.text} Litres water added to target intake'),
                                    duration: Duration(seconds: 5),
                                  ));
                                },
                                child: Text('ADD',
                                    style: TextStyle(
                                      fontSize: vf * 1.54, //15
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            Text(
                              '1 Glass = 0.147 Litres',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: CustomStyle.light_bn_color),
                            )
                          ],
                        );
                      }),
                    );
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'images/water-glass.png',
                        width: vf * 4.62, //45
                        height: vf * 4.62, //45
                      ),
                      FittedBox(
                        child: Text(
                          'Drank Water ?\nAdd here',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: vf * 1.54, //15
                          ),
                        ),
                      ),
                      SizedBox(width: vf * 1.026), //10
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: vf * 1.026), //10
            specialprograms(),
            Padding(
              padding: EdgeInsets.only(
                left: vf * 1.026, //10
                top: vf * 2.053, //20
                right: 0,
                bottom: 0,
              ),
              child: Text(
                'Area of focus',
                style: TextStyle(
                  color: darkPurple,
                  fontWeight: FontWeight.bold,
                  decorationThickness: vf * 0.086,
                  decorationColor: darkPurple,
                  fontSize: vf * 2.258, //22
                ),
              ),
            ),
            parts(),
          ],
        ),
      ),
    );
  }
}
