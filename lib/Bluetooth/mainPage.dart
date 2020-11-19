import 'package:firebase_ex/Bluetooth/individualDevice.dart';
import 'package:firebase_ex/styling.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BTmain extends StatefulWidget {
  @override
  _BTmainState createState() => _BTmainState();
}

class _BTmainState extends State<BTmain> {
  double vf = CustomStyle.verticalFractions;
  double ten, twenty, eighteen;

  @override
  void initState() {
    super.initState();
    ten = vf * 1.026; //10
    twenty = vf * 2.053; //20
    eighteen = vf * 1.848; //18
  }

  _setValues(String nameOfDevice, Widget customcustWidget) async {
    SharedPreferences inst = await SharedPreferences.getInstance();

    List<String> sm = inst.getStringList(nameOfDevice);
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    if (sm == null) {
      String reps = '', sets = '', weight = '', oneSetEqualsReps = '';

      return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Dialog(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: vf * 4.106, //40
                vertical: vf * 5.133, //50
              ),
              height: vf * 46.201, //450
              child: Column(
                children: [
                  Text(
                    'Enter the target values below',
                    style: TextStyle(
                      fontSize: vf * 2.258, //22
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: vf * 3.08), //30
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Enter target number of reps',
                                labelStyle: TextStyle(color: CustomStyle.light_bn_color, fontSize: eighteen), //18
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomStyle.light_bn_txt_Color),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomStyle.light_bn_color),
                                ),
                              ),
                              onSaved: (val) => reps = val,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Enter value of 1 set',
                                hintText: '1 set = how many reps ?',
                                labelStyle: TextStyle(color: CustomStyle.light_bn_color, fontSize: eighteen), //18
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomStyle.light_bn_txt_Color),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomStyle.light_bn_color),
                                ),
                              ),
                              onSaved: (val) => oneSetEqualsReps = val,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Enter target number of sets',
                                labelStyle: TextStyle(color: CustomStyle.light_bn_color, fontSize: eighteen), //18
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomStyle.light_bn_txt_Color),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomStyle.light_bn_color),
                                ),
                              ),
                              onSaved: (val) => sets = val,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Enter target weight in KGS/LBS',
                                labelStyle: TextStyle(color: CustomStyle.light_bn_color, fontSize: eighteen), //18
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomStyle.light_bn_txt_Color),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomStyle.light_bn_color),
                                ),
                              ),
                              onSaved: (val) => weight = val,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: twenty), //20
                      ElevatedButton(
                        onPressed: () {
                          _formKey.currentState.save();

                          if (reps == '' || oneSetEqualsReps == '' || sets == '' || weight == '') {
                            return showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      contentTextStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                      content: Text('Enter all values and try again'),
                                    ));
                          }

                          List<String> list = List<String>();
                          list.add(reps);
                          list.add(oneSetEqualsReps);
                          list.add(sets);
                          list.add(weight);

                          inst.setStringList(nameOfDevice, list);

                          print('Values have been set successfully !');

                          return Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => customcustWidget),
                          );
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: eighteen, //18
                            letterSpacing: 0.5,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(CustomStyle.light_bn_color),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(
                              horizontal: twenty, //20
                              vertical: ten, //ten
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  _containerGenerator({ImageProvider<Object> img, String name, Widget custwidget}) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ten,
        vertical: ten,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ten),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(2, 3),
            blurRadius: 3,
          ),
        ],
      ),
      height: vf * 25.667, //250
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ImageIcon(
            img,
            size: vf * 15.4, //150
          ),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Text(name),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () async {
                SharedPreferences inst = await SharedPreferences.getInstance();

                List<String> sm = inst.getStringList(name);
                if (sm == null) {
                  _setValues(name, custwidget);
                }
                else Navigator.push(context, MaterialPageRoute(builder: (context)=>custwidget));
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: CustomStyle.gradientBGColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'AVAILABLE DEVICES',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: vf * 4.106, //40
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(blurRadius: 1.8, offset: Offset(1, 1.5))]),
                ),
                SizedBox(height: vf * 10.266), //100
                Container(
                  height: vf * 70, //682
                  child: GridView.count(
                    childAspectRatio: 1 / 1.3,
                    crossAxisCount: 2,
                    children: [
                      _containerGenerator(
                          img: AssetImage('images/BTTMP.png'),
                          name: 'Bench Press',
                          custwidget: IndividualDevice(
                            value: 50,
                            backgroundColor: Color.fromRGBO(25, 58, 52, 0.5),
                            foregroundColor: Color.fromRGBO(0, 221, 172, 1),
                          )),
                      _containerGenerator(
                          img: AssetImage('images/BTTMP.png'),
                          name: 'Chest Press',
                          custwidget: IndividualDevice(
                            value: 50,
                            backgroundColor: Color.fromRGBO(25, 58, 52, 0.5),
                            foregroundColor: Color.fromRGBO(0, 221, 172, 1),
                          )),
                      _containerGenerator(
                          img: AssetImage('images/BTTMP.png'),
                          name: 'Weight Lifting',
                          custwidget: IndividualDevice(
                            value: 50,
                            backgroundColor: Color.fromRGBO(25, 58, 52, 0.5),
                            foregroundColor: Color.fromRGBO(0, 221, 172, 1),
                          )),
                      _containerGenerator(
                          img: AssetImage('images/BTTMP.png'),
                          name: 'Curl Bench',
                          custwidget: IndividualDevice(
                            value: 50,
                            backgroundColor: Color.fromRGBO(25, 58, 52, 0.5),
                            foregroundColor: Color.fromRGBO(0, 221, 172, 1),
                          )),
                      _containerGenerator(
                        img: AssetImage('images/BTTMP.png'),
                        name: 'Biceps Pull',
                        custwidget: IndividualDevice(
                          value: 50,
                          backgroundColor: Color.fromRGBO(25, 58, 52, 0.5),
                          foregroundColor: Color.fromRGBO(0, 221, 172, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
