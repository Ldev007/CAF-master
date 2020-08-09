import 'package:firebase_ex/Authenticate/google_auth.dart';
import 'package:firebase_ex/pages/DietChart.dart';
import 'package:firebase_ex/pages/Gym.dart';
import 'package:flutter/material.dart';
import 'routes.dart';
import 'styling.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //This widget is the root of your application..

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      CustomStyle().init(constraints);
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: Routes.routes,
        title: 'Fitness',
        theme: CustomStyle.def_theme,
        home: google_auth(),
      );
    });
  }

  @override
  void dipose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}
