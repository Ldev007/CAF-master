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

  _setValues(String nameOfDevice) async {
    SharedPreferences inst = await SharedPreferences.getInstance();

    List<String> sm = inst.getStringList(nameOfDevice);
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    if (sm == null) {
      String reps = '', sets = '', weight = '', oneSetEqualsReps = '';

      return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Dialog(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
            height: 450,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Enter the target values below',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Enter target number of reps',
                        ),
                        onSaved: (val) => reps = val,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Enter value of 1 set',
                          hintText: '1 set = how many reps ?',
                        ),
                        onSaved: (val) => oneSetEqualsReps = val,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Enter target number of sets',
                        ),
                        onSaved: (val) => sets = val,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Enter target weight in KGS/LBS',
                        ),
                        onSaved: (val) => weight = val,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _formKey.currentState.save();

                    if (reps == '' ||
                        oneSetEqualsReps == '' ||
                        sets == '' ||
                        weight == '') {
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

                    Navigator.pop(context);
                  },
                  child: Text('Submit'),
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  _containerGenerator({ImageProvider<Object> img, String name, Widget widget}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(2, 3),
            blurRadius: 3,
          ),
        ],
      ),
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ImageIcon(
            img,
            size: 150,
          ),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Text(name),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                _setValues(name);
                return Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => widget,
                  ),
                );
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
        child: Container(
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
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(blurRadius: 1.8, offset: Offset(1, 1.5))]),
              ),
              SizedBox(height: 100),
              Container(
                height: vf * 70,
                child: GridView.count(
                  childAspectRatio: 1 / 1.3,
                  crossAxisCount: 2,
                  children: [
                    _containerGenerator(
                        img: AssetImage('images/BTTMP.png'),
                        name: 'Bench Press',
                        widget: IndividualDevice(
                          value: 50,
                          backgroundColor: Color.fromRGBO(25, 58, 52, 0.5),
                          foregroundColor: Color.fromRGBO(0, 221, 172, 1),
                        )),
                    _containerGenerator(
                        img: AssetImage('images/BTTMP.png'),
                        name: 'Chest Press',
                        widget: IndividualDevice(
                          value: 50,
                          backgroundColor: Color.fromRGBO(25, 58, 52, 0.5),
                          foregroundColor: Color.fromRGBO(0, 221, 172, 1),
                        )),
                    _containerGenerator(
                        img: AssetImage('images/BTTMP.png'),
                        name: 'Weight Lifting',
                        widget: IndividualDevice(
                          value: 50,
                          backgroundColor: Color.fromRGBO(25, 58, 52, 0.5),
                          foregroundColor: Color.fromRGBO(0, 221, 172, 1),
                        )),
                    _containerGenerator(
                        img: AssetImage('images/BTTMP.png'),
                        name: 'Curl Bench',
                        widget: IndividualDevice(
                          value: 50,
                          backgroundColor: Color.fromRGBO(25, 58, 52, 0.5),
                          foregroundColor: Color.fromRGBO(0, 221, 172, 1),
                        )),
                    _containerGenerator(
                      img: AssetImage('images/BTTMP.png'),
                      name: 'Biceps Pull',
                      widget: IndividualDevice(
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
    );
  }
}
