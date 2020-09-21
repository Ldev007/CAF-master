import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../styling.dart';

class exercise extends StatefulWidget {
  final program_name;
  final program_pic;

  exercise({
    this.program_name,
    this.program_pic,
  });

  @override
  _exerciseState createState() => _exerciseState();
}

class _exerciseState extends State<exercise> {
  //_excerciseState()

  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  UnityWidgetController _unityWidgetController;
  String curr_excercise = "Start";
  String next_excercise = "---";
  List<String> hiit = [
    "jumping_high_knees-s",
    "SQUADS-s",
    "plankrock-fd",
    "Jumpting_Squats-s",
    "legRaise-fu",
    "pushups-fd",
  ];
  List<String> pilates = [
    "theonehundred",
    "crossCrunches",
    "doublelegstrech",
    "teasser",
    "pendulum",
    "plankleglift",
    "plankrock",
    "hipdip"
  ];

  int _i = 1;
  double _progress = 0.0;
  bool _pause = false;
  bool _unitypause = false;
  bool isstarted = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        body: Column(children: <Widget>[
          LinearProgressIndicator(value: _progress),
          Stack(
            children: <Widget>[
              Container(
                height: 300,
                child: Card(
                  margin: const EdgeInsets.all(8),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: UnityWidget(
                    onUnityViewCreated: onUnityCreated,
                    isARScene: false,
                    onUnityMessage: onUnityMessage,
                  ),
                ),
              ),

              new Positioned(
                left:  CustomStyle.horizontalFractions*40,
                bottom: 5,
                child: InkWell(
                  child: Icon(
                    (_unitypause) ? Icons.play_arrow : Icons.pause,
                    color: Colors.white,
                    size: 50.0,
                  ),
                  onTap : () {
                    print("play");
                    setState(() {
                      if (_unitypause) {
                        _unityWidgetController.resume();
                      } else {
                        _unityWidgetController.pause();
                      }
                      _unitypause = !_unitypause;
                      _pause = true;
                    });
                  },
                ),
              ),
//                  Row(
//                    children: <Widget>[
//                      Text(curr_excercise),
//                      IconButton(
//                        iconSize: 40.0,
//                        icon: Icon(
//                          (_unitypause) ? Icons.play_arrow : Icons.pause,
//                          color: Colors.blue,
//                        ),
//                        onPressed: () {
//                          print("play");
//                          setState(() {
//                            if (_unitypause) {
//                              _unityWidgetController.resume();
//                            } else {
//                              _unityWidgetController.pause();
//                            }
//                            _unitypause = !_unitypause;
//                            _pause = true;
//                          });
//                        },
//                      ),
//                    ],
//                  ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              curr_excercise.toUpperCase(),
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              'Next: '+next_excercise.toUpperCase(),
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
                color: Colors.grey[300],
              ),
            ),
          ),
          isstarted? Padding(
            padding:
                EdgeInsets.only(left: 0.0, top: 10, right: 0.0, bottom: 0.0),
            child: IconButton(
              iconSize: 80.0,
              icon: Icon(
                (_pause) ? Icons.play_arrow : Icons.pause,
                color: Colors.blue,
              ),
              onPressed: () {
                print("play");
                setState(() {
                  if (_pause) {
                    _unitypause = false;
                    _unityWidgetController.resume();
                  }
                  _pause = !_pause;
                });
              },
            ),
          ):Padding(
            padding:
            EdgeInsets.only(left: 0.0, top: 10, right: 0.0, bottom: 0.0),
            child: IconButton(
              iconSize: 80.0,
              icon: Icon(Icons.play_circle_filled,
              color: Colors.blue,),
              onPressed: () {
                print("play");
                playexercise(hiit);
                setState(() {
                  isstarted = true;
                });
              },
            ),
          ),
//          Expanded(
//            child: Card(
//              color: Color(0xffb1c5cac),
//              elevation: 10,
//              child: Column(
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.only(top: 20),
//                    child: Text("Rotation speed:",style: TextStyle(color: Colors.white),),
//                  ),
//                  FlatButton(
//                    onPressed: () {
//                      //setRotationSpeed('cross');
//                      _unityWidgetController.pause();
//                    },
//                    child: Text('pause'),
//                  ),
//                  FlatButton(
//                    onPressed: () {
//                      //setRotationSpeed('cross');
//                      _unityWidgetController.resume();
//                    },
//                    child: Text('resume'),
//                  ),
//                  FlatButton(
//                    onPressed: () {
//                      playexercise(hiit);
//                    },
//                    child: Text('hiit'),
//                  ),
//                  FlatButton(
//                    onPressed: () {
//                      playexercise(pilates);
//                    },
//                    child: Text('pilates'),
//                  ),
//                  Text(widget.program_name),
//                ],
//              ),
//            ),
//          ),
        ]),
      ),
    );
  }

  startTimer(Timer timer, List<String> pack) {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!_pause) {
        if (_i < pack.length) {
          _unityWidgetController.postMessage(
            "rp_nathan_animated_003_walking",
            'flu',
            pack[_i],
          );
          print(pack[_i]);
          setState(() {
            curr_excercise = pack[_i].split("-")[0];
            if(_i==pack.length-1) {
              next_excercise = "Completed";
            }
            else{
              next_excercise = pack[_i + 1].split("-")[0];
            }
          });
          _i++;
        } else {
          cancelTimer(timer);
        }
        setState(() {
          _progress = (_i - 1) / pack.length;
        });
      }
    });
  }

  cancelTimer(Timer timer) {
    timer.cancel();
    _unityWidgetController.postMessage(
      "rp_nathan_animated_003_walking",
      'flu',
      'Abs',
    );
    updateexcercise();
    print("completed");
    Navigator.pop(context);
  }
  Future updateexcercise() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("uid");
    CollectionReference collectionReference = Firestore.instance.collection('UserData');
//    collectionReference.document('hiit').setData({'reps':1},merge: true);
    var obj = ['HIIT'];
    collectionReference.document(uid).updateData({'excercise':FieldValue.arrayUnion(obj)});
    collectionReference.document(uid).updateData({'calories':FieldValue.increment(50)});
    DocumentReference ds = collectionReference.document(uid).collection("excercise").document("programs");
    ds.setData({
      "plan": {
        "hiit": FieldValue.increment(1)
      }
    },merge:true);
  }
  void playexercise(List<String> pack) {
    _i = 1;
    Timer timer;
    print("first played");
    print(widget.program_name);
    setState(() {
      _progress = 0.0;
    });
    _unityWidgetController.postMessage(
      "rp_nathan_animated_003_walking",
      'flu',
      pack[0],
    );
    setState(() {
      curr_excercise = pack[0].split("-")[0];
      next_excercise = pack[1].split("-")[0];
    });
    print(pack[0]);
    startTimer(timer, pack);
//    const oneSec = const Duration(seconds:2);
//    new Timer.periodic(oneSec, (Timer t) => pla(i));
  }

  void onUnityMessage(controller, message) {
    print('Received message from unity: ${message.toString()}');
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    this._unityWidgetController = controller;
  }
}
