import 'ProgressBar.dart';
import 'package:firebase_ex/profile.dart';
import 'package:flutter/material.dart';
import 'pages/AuthScreen.dart';
import 'pages/Screen_1.dart';
import 'pages/Screen_2.dart';
import 'pages/Screen_3.dart';
import 'pages/Screen_4.dart';
import 'pages/Screen_5.dart';
import 'pages/Screen_6.dart';
import 'pages/Screen_7.dart';
import 'pages/Screen_8.dart';
import 'pages/HomePage.dart';

class Routes {
  static double _getValueForTracker() {
    return 50;
  }

  static Color _getColorForTracker() {
    return Colors.black;
  }

  static final Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => LoginScreen(),
    '/first_screen': (context) => ScreenOne(),
    '/second_screen': (context) => ScreenTwo(),
    '/third_screen': (context) => ScreenThree(),
    '/fourth_screen': (context) => ScreenFour(),
    '/fifth_screen': (context) => ScreenFive(),
    '/sixth_screen': (context) => ScreenSix(),
    '/seventh_screen': (context) => ScreenSeven(),
    '/eighth_screen': (context) => ScreenEight(),
    '/home_page': (context) => HomePage(),
    '/profile_page': (context) => Profile(),
    '/tracker': (context) => CircleProgressBar(
          value: _getValueForTracker(),
          foregroundColor: _getColorForTracker(),
        ),
  };
}
