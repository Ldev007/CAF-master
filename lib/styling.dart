import 'package:flutter/material.dart';

class CustomStyle {
  static final Color light_bg_color = Colors.white60;
  static final Color light_fg_color = Colors.black54;
  static final Color light_bn_color = Color.fromRGBO(48, 67, 120, 1);
  static final Color light_dis_bn_color = Color.fromRGBO(192, 196, 228, 0.6);
  static final Color light_bn_txt_Color = Color.fromRGBO(192, 196, 228, 1);
  static final Color light_smthg_color = Colors.amber;
  static final Color appBar_color = Color.fromRGBO(48, 67, 120, 1);
  static final Color appBar_txt_color = Color.fromRGBO(192, 196, 228, 1);
  static final Color inactive_tracker_color = Color.fromRGBO(192, 196, 228, 1);
  static final Color active_tracker_color = Color.fromRGBO(48, 67, 120, 1);
  static final Color tracker_thumb_color = Color.fromRGBO(48, 67, 120, 1);
  static final Color tracker_overlay_color = Color.fromRGBO(192, 196, 228, 0.5);

  //TOGGLE BUTTON COLOR STYLING
  static final Color toggle_Border_Color = Color.fromRGBO(48, 67, 120, 1);
  static final Color toggle_Sel_Color = Color.fromRGBO(192, 196, 228, 0.6);
  static final Color toggle_Fill_Color = Color.fromRGBO(192, 196, 228, 0.6);
  static final Color toggle_Sel_txt_Color = Color.fromRGBO(48, 67, 120, 1);

  //eb = enabled, db = disabled
  static final Color fab_eb_color = Color.fromRGBO(48, 67, 120, 1);
  static final Color fab_db_color = Color.fromRGBO(192, 196, 228, 0.6);
  static final Color fab_icon_eb_color = Color.fromRGBO(192, 196, 228, 1);
  static final Color fab_icon_db_color = Color.fromRGBO(48, 67, 120, 1);

  /****************************************
  * APP BAR'S THEME DECLARATION
  ****************************************/
  static final AppBarTheme regAppBarTheme = AppBarTheme(
      color: Colors.white10,
      textTheme: TextTheme(
        headline5:
            TextStyle(color: light_bn_color, fontWeight: FontWeight.bold),
        headline6: TextStyle(color: light_bn_color),
      ));

  static final ThemeData def_theme = ThemeData(
    backgroundColor: Colors.white10,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      splashColor: Colors.transparent,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      button: TextStyle(),
      headline1: TextStyle(color: light_bn_color),
      headline2: TextStyle(color: light_bn_color),
      headline3: TextStyle(color: light_bn_color),
      headline4: TextStyle(
          color: light_bn_txt_Color, fontFamily: 'fonts/Roboto-Light.ttf'),
      headline5: TextStyle(
        color: light_bn_color,
      ),
      headline6: TextStyle(
          color: light_bn_txt_Color, fontFamily: 'fonts/Roboto-Light.ttf'),
      subtitle1: TextStyle(color: light_bn_txt_Color),
      subtitle2: TextStyle(color: light_bn_txt_Color),
    ),
  );
  //To be continued...

  /*************************************
   * TEXT THEME DECLARATION
  **************************************/
  static TextStyle button_header;
  static TextStyle button_footer;
  static TextStyle page_header;
  static TextStyle appBar_Title;

  // void init(BuildContext context) {
  //   /*************************************
  //  * TEXT THEME INITIALISATION
  // **************************************/
  //   button_header = TextStyle(
  //       color: light_bn_txt_Color,
  //       fontSize: MediaQuery.of(context).size.height * 0.010, //20
  //       fontWeight: FontWeight.bold,
  //       fontFamily: 'fonts/Roboto-Bold.ttf');
  //   button_footer = TextStyle(
  //       color: light_bn_txt_Color,
  //       fontSize: MediaQuery.of(context).size.height * 0.01, //15
  //       fontFamily: 'fonts/Roboto-Light.ttf');
  //   page_header = TextStyle(
  //     fontSize: MediaQuery.of(context).size.height * 0.01, //26
  //     fontFamily: 'fonts/Roboto-Bold.ttf',
  //     fontWeight: FontWeight.bold,
  //     color: light_bn_color,
  //   );
  // }

  static double verticalFractions;
  static double horizontalFractions;
  static double txtMutliplier;
  static double imgMultiplier;
  static double buttonMultiplier;
  static double iconMultiplier;

  void init(BoxConstraints constraints) {
    verticalFractions = constraints.maxHeight / 100;
    horizontalFractions = constraints.maxWidth / 100;

    txtMutliplier = verticalFractions;

    /*************************************
   * TEXT THEME INITIALISATION
  **************************************/
    button_header = TextStyle(
        color: light_bn_txt_Color,
        fontSize: txtMutliplier * 2.5, //20
        fontWeight: FontWeight.bold,
        fontFamily: 'fonts/Roboto-Bold.ttf');
    button_footer = TextStyle(
        color: light_bn_txt_Color,
        fontSize: txtMutliplier * 1.8, //15
        fontFamily: 'fonts/Roboto-Light.ttf');
    page_header = TextStyle(
      fontSize: txtMutliplier * 3.5, //26
      fontFamily: 'fonts/Roboto-Bold.ttf',
      fontWeight: FontWeight.bold,
      color: light_bn_color,
    );
    appBar_Title = TextStyle(
      fontSize: txtMutliplier * 2.2, //26
      fontFamily: 'fonts/Roboto-Bold.ttf',
      fontWeight: FontWeight.bold,
      color: light_bn_txt_Color,
    );

    print('vertical fractions $verticalFractions');
  }
}
