import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ex/Database/database.dart';
import 'package:firebase_ex/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenEight extends StatefulWidget {
  final String userid;
  final String goal;
  final String gender;
  final String age;
  final String height;
  final String weight;
  final String currentfat;
  final String targetfat;
  final String title;
  ScreenEight(
      {Key key,
      this.age,
      this.goal,
      this.userid,
      this.gender,
      this.height,
      this.weight,
      this.currentfat,
      this.targetfat,
      this.title})
      : super(key: key);

  @override
  _ScreenEightState createState() => _ScreenEightState();
}

class _ScreenEightState extends State<ScreenEight>
    with SingleTickerProviderStateMixin {
  static String _choice = 'I rarely/never exercise';
  static double _dig = 0;
  Future upadteuser(String uid, String goal, String gender, String age,
      String height, String weight, String currentfat, String targetfat) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("seen", true);
    String email = prefs.getString("useremail");
    Map<String, dynamic> demodata = {
      "uid": uid,
      "Goal": goal,
      "Gender": gender,
      "Age": age,
      "Height": height,
      "Weight": weight,
      "CurrentFat": currentfat,
      "TargetFat": targetfat,
      "gym": "noentry",
      "calories":0,
    };
    CollectionReference collectionReference =
        Firestore.instance.collection('UserData');
    collectionReference.document(uid).setData(demodata);
    print("data added");
    prefs.setString("uid", uid); //set on screen 8
    prefs.setBool("inside", false); //set on screen 8

//    DatabaseService d;
//    d.updateUserData(uid,goal,gender,age,height,weight,currentfat,targetfat);
  }

  String oftenex;

//Notifications related variables
  FlutterLocalNotificationsPlugin notifPlugin;
  var initSettingsAndroid;
  var initSettingsIOS;
  var initSettings;

  @override
  void initState() {
    _showDailyAtTime();
  }

  //Notification Scheduler
  Future<void> _showDailyAtTime() async {
    initSettingsAndroid = new AndroidInitializationSettings('my_icon');
    initSettingsIOS = new IOSInitializationSettings();
    initSettings =
        new InitializationSettings(initSettingsAndroid, initSettingsIOS);

    notifPlugin = new FlutterLocalNotificationsPlugin();
    notifPlugin.initialize(initSettings, onSelectNotification: (String tmp) {
      showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("Notification Clicked ! Check the payload below.."),
          content: new Text(tmp),
        ),
      );
    });
    var time = Time(04, 20, 0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await notifPlugin.showDailyAtTime(
        0,
        'show daily title',
        'Daily notification shown at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
        time,
        platformChannelSpecifics);
  }

  String _toTwoDigitString(int value) {
    return value.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    print("screen 8");
    print(widget.userid +
        " " +
        widget.goal +
        " " +
        widget.gender +
        " " +
        widget.age +
        " " +
        widget.height +
        " " +
        widget.weight +
        " " +
        widget.currentfat +
        " " +
        widget.targetfat);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: CustomStyle.fab_eb_color,
          splashColor: Colors.transparent,
          child: Icon(
            Icons.arrow_forward_ios,
            color: CustomStyle.fab_icon_eb_color,
          ),
          onPressed: () => {
            Navigator.pushNamed(context, '/home_page'),
            upadteuser(
                widget.userid,
                widget.goal,
                widget.gender,
                widget.age,
                widget.height,
                widget.weight,
                widget.currentfat,
                widget.targetfat),
          },
        ),
        appBar: AppBar(
          backgroundColor: CustomStyle.light_bn_color,
          centerTitle: true,
          title: Text('Step 8 of 8', style: CustomStyle.appBar_Title),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            bottom: 400,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'How often do you exercise ?',
                style: CustomStyle.page_header,
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 65,
                ),
                child: Text(
                  _choice,
                  style: TextStyle(
                    fontFamily: 'fonts/Roboto-Light.ttf',
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: CustomStyle.light_bn_color,
                  ),
                ),
              ),
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 4.5,
                  tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 3),
                  inactiveTickMarkColor: Colors.black,
                  thumbColor: CustomStyle.tracker_thumb_color,
                  trackShape: RoundedRectSliderTrackShape(),
                  activeTrackColor: CustomStyle.active_tracker_color,
                  inactiveTrackColor: CustomStyle.inactive_tracker_color,
                  overlayColor: CustomStyle.tracker_overlay_color,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 25,
                    left: 25,
                  ),
                  child: Slider(
                    value: _dig,
                    divisions: 4,
                    min: 0,
                    max: 40,
                    onChanged: (double value) {
                      setState(() {
                        _dig = value;
                        if (_dig == 10) {
                          _choice = 'I exercise 1-3 times a week';
                        } else if (_dig == 20) {
                          _choice = 'I exercise 3-5 times a week';
                        } else if (_dig == 30) {
                          _choice = 'I exercise 6-7 times a week';
                        } else if (_dig == 0) {
                          _choice = 'I rarely/never exercise';
                        } else {
                          _choice = 'I exercise several times a week';
                        }
                      });
                    },
                  ),
                ),
              ),
              ListTile(
                leading: Text(
                  'BEGINNER',
                  style: TextStyle(
                    fontFamily: 'fonts/Roboto-Light.ttf',
                    fontSize: 14,
                    color: CustomStyle.light_bn_color,
                  ),
                ),
                trailing: Text(
                  'ADVANCED',
                  style: TextStyle(
                    fontFamily: 'fonts/Roboto-Light.ttf',
                    fontSize: 14,
                    color: CustomStyle.light_bn_color,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
