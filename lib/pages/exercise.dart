import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

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

  List<String> hiit = ["jumping_high_knees","SQUADS", "pushups","Jumpting_Squats","legRaise","plankrock"];
  List<String> pilates = ["theonehundred","crossCrunches", "doublelegstrech","teasser","pendulum","plankleglift","plankrock","hipdip"];

  int _i=1;
  double _progress = 0.0;
  bool _pause = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Unity Demo'),
          backgroundColor: Color(0xffb4691f9),
        ),
        body: Column(children: <Widget>[
          Column(
            children: <Widget>[
              LinearProgressIndicator(value: _progress),
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
            ],
          ),
      Padding(
        padding: EdgeInsets.only(left: 0.0,top: 10,right: 0.0,bottom: 0.0),
          child: IconButton(
            iconSize: 80.0,
            icon: Icon(
              (_pause)?Icons.play_arrow:Icons.pause,
              color: Colors.blue,
            ),
            onPressed: () {
              print("play");
              setState(() {
                _pause = !_pause;
              });
            },
          ),
      ),
      FlatButton(
                    onPressed: () {
                      playexercise(hiit);
                    },
                    child: Text('hiit'),
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
  startTimer(Timer timer , List<String> pack){
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if(!_pause){
        if(_i<pack.length){
          _unityWidgetController.postMessage(
            "rp_nathan_animated_003_walking",
            'flu',
            pack[_i],
          );
          print(pack[_i]);
          _i++;
        }
        else{
          timer.cancel();
        }
        setState((){
          _progress = (_i-1)/pack.length;
        });
      }
    });
  }

  cancelTimer(Timer timer) {
    timer.cancel();
  }
  void playexercise(List<String> pack) {
    _i = 1;
    Timer timer;
    print("first played");
    print(widget.program_name);
    setState((){
      _progress = 0.0;
    });
    _unityWidgetController.postMessage(
      "rp_nathan_animated_003_walking",
      'flu',
      pack[0],);
    print(pack[0]);
    startTimer(timer,pack);
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
