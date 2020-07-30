import 'package:firebase_ex/Authenticate/google_auth.dart';
import 'package:flutter/material.dart';
import 'routes.dart';
import 'styling.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //This widget is the root of your application..
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: Routes.routes,
      title: 'Fitness',
      theme: CustomStyle.def_theme,
      home: google_auth(),
    );
  }
}