import 'package:flutter/material.dart';

class CustomStyle {
  CustomStyle._();

  static final Color def_bg_color = Colors.white60;
  static final Color def_fg_color = Colors.black54;
  static final Color def_bn_color = Colors.black54;
  static final Color def_bn_txt_Color = Colors.white70;
  static final Color def_smthg_color = Colors.amber;

static final ThemeData def_theme = ThemeData(
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    splashColor: Colors.transparent,
  ),
  primarySwatch: Colors.blue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  );
  //To be continued... 


}