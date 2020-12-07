import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_ex/Bluetooth/individualDevice.dart';
import 'package:firebase_ex/Bluetooth/prov/providers.dart';
import 'package:firebase_ex/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_riverpod/all.dart';
// import 'user.dart';
import 'package:firebase_ex/profile.dart';

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


    //bluetooth
    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    _deviceState = 0; // neutral

    enableBluetooth();

    // Listen for further state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
        if (_bluetoothState == BluetoothState.STATE_OFF) {
          _isButtonUnavailable = true;
        }
        getPairedDevices();
      });
    });
    //end here
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
              height: vf * 80.201, //450
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
                      RaisedButton(onPressed: () {
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
                        // style: ButtonStyle(
                        //   backgroundColor: MaterialStateProperty.all<Color>(CustomStyle.light_bn_color),
                        //   padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        //     EdgeInsets.symmetric(
                        //       horizontal: twenty, //20
                        //       vertical: ten, //ten
                        //     ),
                        //   ),
                        // ),
                      )
                      // ElevatedButton(
                      //   onPressed: () {
                      //     _formKey.currentState.save();
                      //
                      //     if (reps == '' || oneSetEqualsReps == '' || sets == '' || weight == '') {
                      //       return showDialog(
                      //           context: context,
                      //           builder: (context) => AlertDialog(
                      //                 contentTextStyle: TextStyle(
                      //                   fontSize: 15,
                      //                   color: Colors.black,
                      //                 ),
                      //                 content: Text('Enter all values and try again'),
                      //               ));
                      //     }
                      //
                      //     List<String> list = List<String>();
                      //     list.add(reps);
                      //     list.add(oneSetEqualsReps);
                      //     list.add(sets);
                      //     list.add(weight);
                      //
                      //     inst.setStringList(nameOfDevice, list);
                      //
                      //     print('Values have been set successfully !');
                      //
                      //     return Navigator.push(
                      //       context,
                      //       MaterialPageRoute(builder: (context) => customcustWidget),
                      //     );
                      //   },
                      //   child: Text(
                      //     'Submit',
                      //     style: TextStyle(
                      //       fontSize: eighteen, //18
                      //       letterSpacing: 0.5,
                      //     ),
                      //   ),
                      //   style: ButtonStyle(
                      //     backgroundColor: MaterialStateProperty.all<Color>(CustomStyle.light_bn_color),
                      //     padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      //       EdgeInsets.symmetric(
                      //         horizontal: twenty, //20
                      //         vertical: ten, //ten
                      //       ),
                      //     ),
                      //   ),
                      // )
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

  _containerGenerator({ImageProvider<Object> img, BluetoothDevice device,String name, Widget custwidget}) {
    return MaterialButton(
      onPressed: () async {
        SharedPreferences inst = await SharedPreferences.getInstance();

        List<String> sm = inst.getStringList(name);
        if (sm == null) {
          _setValues(name, custwidget);
        }
        else {
          _device = device;
          if(!_connected){
            _connect(custwidget);
            if(_connected) {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => custwidget));
            }
          }
          else{
            //remove _connceted=true !important
            // _connected=true;
            show('Cant Connect Please Try again');
          }
        }
      },
      child: Container(
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
            ),
          ],
        ),
      ),
    );
  }


  //bluetooth code here start
  // Initializing the Bluetooth connection state to be unknown
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  // Initializing a global key, as it would help us in showing a SnackBar later
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // Get the instance of the Bluetooth
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;

  // Track the Bluetooth connection with the remote device
  BluetoothConnection connection;

  int _deviceState;

  bool isDisconnecting = false;

  Map<String, Color> colors = {
    'onBorderColor': Colors.green,
    'offBorderColor': Colors.red,
    'neutralBorderColor': Colors.transparent,
    'onTextColor': Colors.green[700],
    'offTextColor': Colors.red[700],
    'neutralTextColor': Colors.blue,
  };

  // To track whether the device is still connected to Bluetooth
  bool get isConnected => connection != null && connection.isConnected;

  // Define some variables, which will be required later
  List<BluetoothDevice> _devicesList = [];
  BluetoothDevice _device;
  bool _connected = false;
  bool _isButtonUnavailable = false;


  @override
  void dispose() {
    // Avoid memory leak and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }

    super.dispose();
  }

  // Request Bluetooth permission from the user
  Future<void> enableBluetooth() async {
    // Retrieving the current Bluetooth state
    _bluetoothState = await FlutterBluetoothSerial.instance.state;

    // If the bluetooth is off, then turn it on first
    // and then retrieve the devices that are paired.
    if (_bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
      await getPairedDevices();
      return true;
    } else {
      await getPairedDevices();
    }
    return false;
  }

  // For retrieving and storing the paired devices
  // in a list.
  Future<void> getPairedDevices() async {
    List<BluetoothDevice> devices = [];

    // To get the list of paired devices
    try {
      devices = await _bluetooth.getBondedDevices();
    } on PlatformException {
      print("Error");
    }

    // It is an error to call [setState] unless [mounted] is true.
    if (!mounted) {
      return;
    }

    // Store the [devices] list in the [_devicesList] for accessing
    // the list outside this class
    setState(() {
      devices.forEach((element) {
        if(element.name[0]=='H'){
          _devicesList.add(element);
        }
        print(element.name.toString());
      });
      // _devicesList = devices;
    });
  }

  getdata() {
    // connection.
    connection.input.listen(_onDataReceived).onDone(() {
      // Example: Detect which side closed the connection
      // There should be `isDisconnecting` flag to show are we are (locally)
      // in middle of disconnecting process, should be set before calling
      // `dispose`, `finish` or `close`, which all causes to disconnect.
      // If we except the disconnection, `onDone` should be fired as result.
      // If we didn't except this (no flag set), it means closing by remote.
      if (isDisconnecting) {
        print('Disconnecting locally!');
      } else {
        print('Disconnected remotely!');
      }
      if (this.mounted) {
        setState(() {});
      }
    });
  }

  int count = 0;
  bool up=false;
  int reps=0;
  int sets=0;
  Map<int,int> m={};
  String remark="Go For IT";
  BuildContext contextglobal;
  // Now, its time to build the UI

  // Create the List of devices to be shown in Dropdown Menu
  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devicesList.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devicesList.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name),
          value: device,
        ));
      });
    }
    return items;
  }

  // Method to connect to bluetooth
  void _connect(Widget custwidget) async {
    setState(() {
      _isButtonUnavailable = true;
    });
    if (_device == null) {
      show('No device selected');
    } else {
      if (!isConnected) {
        await BluetoothConnection.toAddress(_device.address)
            .then((_connection) {
          print('Connected to the device');
          connection = _connection;
          setState(() {
            _connected = true;
          });
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => custwidget));
          // Navigator.of(context)
          //     .push(MaterialPageRoute(
          //   builder: (context) => IndividualDevice(),
          // ))
          //     .then((value) {
          //   _disconnect();
          // });

          connection.input.listen(_onDataReceived).onDone(() {
            if (isDisconnecting) {
              print('Disconnecting locally!');
            } else {
              print('Disconnected remotely!');
            }
            if (this.mounted) {
              setState(() {});
            }
          });
        }).catchError((error) {
          print('Cannot connect, exception occurred');
          //print(error);
        });
        show('Device connected');

        setState(() => _isButtonUnavailable = false);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => newwin()),
        // );
      }
    }
  }

  void _onDataReceived(Uint8List data) {

    // print("inside dsata"+data.toString());
    String x = "";
    // Allocate buffer for parsed data
    // x=x+String.fromCharCode(data[0]);
    int backspacesCounter = 0;
    data.forEach((byte) {
      // x=x+String.fromCharCode(byte);
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }
    // data.forEach((element) { })
    data.forEach((byte) {
      x = x + String.fromCharCode(byte);
    });
    if (x == '0') {
    } else {
      int cm = int.parse(x);
      print(cm);
      // userProvider.setCm(5);
      contextglobal.read(Providers.userProvider).setCm(cm);

      // count = count + cm;
      // print("gqhbaveq" + count.toString());
      // print(temp.runtimeType);


      // if (cm >= 15 && cm <= 21) {
      //   up = true;
      //   // count++;
      //   // count++;
      // }
      // // if (cm >= 80)
      // else if(cm>=5 && cm<=8){//&& cm <= 101
      //   if (up) {
      //     count++;
      //     setState(() {
      //       reps=count;
      //     });
      //     print(count);
      //     up = false;
      //   }
      // }

    }
  }

  // Method to disconnect bluetooth

  void _disconnect() async {
    setState(() {
      _isButtonUnavailable = true;
      _deviceState = 0;
    });

    await connection.close();
    show('Device disconnected');
    if (!connection.isConnected) {
      setState(() {
        _connected = false;
        _isButtonUnavailable = false;
      });
    }
  }
  void _reset() async{

    show('Reset Done');
  }
  // Method to send message,
  // for turning the Bluetooth device on
  void _sendOnMessageToBluetooth() async {
    connection.output.add(utf8.encode("1" + "\r\n"));
    await connection.output.allSent;
    show('Device Turned On');
    setState(() {
      _deviceState = 1; // device on
    });
  }

  // Method to send message,
  // for turning the Bluetooth device off
  void _sendOffMessageToBluetooth() async {
    connection.output.add(utf8.encode("0" + "\r\n"));
    await connection.output.allSent;
    show('Device Turned Off');
    setState(() {
      _deviceState = -1; // device off
    });
  }

  // Method to show a Snackbar,
  // taking message as the text
  Future show(
      String message, {
        Duration duration: const Duration(seconds: 3),
      }) async {
    await new Future.delayed(new Duration(milliseconds: 100));
    _scaffoldKey.currentState.showSnackBar(
      new SnackBar(
        content: new Text(
          message,
        ),
        duration: duration,
      ),
    );
  }
  //bluetooth code here end

  @override
  Widget build(BuildContext context) {
    contextglobal = context;
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
        child:
        SingleChildScrollView(
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



                // DropdownButton(
                //   items: _getDeviceItems(),
                //   onChanged: (value) =>
                //       setState(() => _device = value),
                //   value: _devicesList.isNotEmpty ? _device : null,
                // ),
                SizedBox(height: vf * 10.266), //100
                Container(
                  height: vf * 70, //682
                  child: _devicesList.isNotEmpty?GridView.builder(
                    itemCount: _devicesList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),//(orientation == Orientation.portrait) ? 2 : 3),
                    itemBuilder: (BuildContext context, int index) {
                      return  _containerGenerator(
                          img: AssetImage('images/BTTMP.png'),
                          device:_devicesList[index],
                          name: _devicesList[index].name,
                          custwidget: IndividualDevice(
                            value: 50,
                            backgroundColor: Color.fromRGBO(25, 58, 52, 0.5),
                            foregroundColor: Color.fromRGBO(0, 221, 172, 1),
                          ));
                      //   new Card(
                      //   child: new GridTile(
                      //     footer: new Text("foot"),
                      //     child: new Text(_devicesList[index].name), //just for testing, will fill with image later
                      //   ),
                      // );
                    },
                  ):Text("loading"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
