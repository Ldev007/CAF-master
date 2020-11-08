import 'package:firebase_ex/pages/Gym.dart';

import 'ProgressBar.dart';
import 'package:firebase_ex/profile.dart';
import 'package:flutter/material.dart';
import 'pages/HomePage.dart';

class Routes {
  static double _getValueForTracker() {
    return 50;
  }

  static Color _getFrgColorForTracker() {
    return Colors.black;
  }

  static Color _getBkgColorForTracker() {
    return Colors.black54;
  }

  static final Map<String, Widget Function(BuildContext)> routes = {
    '/home_page': (context) => HomePage(),
    '/profile_page': (context) => Profile(),
    '/gym': (context) => GymDetail(),
    '/tracker': (context) => CircleProgressBar(
          value: _getValueForTracker(),
          foregroundColor: _getFrgColorForTracker(),
          backgroundColor: _getBkgColorForTracker(),
        ),
  };
}
