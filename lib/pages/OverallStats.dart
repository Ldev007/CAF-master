import 'package:flutter/material.dart';
import 'package:firebase_ex/styling.dart';

class Overallstats extends StatefulWidget {
  Overallstats({Key key, String title}) : super(key: key);

  _OverallstatsState createState() {
    return _OverallstatsState();
  }
}

class _OverallstatsState extends State<Overallstats> {
  static String trainers_name = "John Wick",
      trainers_exp = "4 Years",
      trainers_degrees = "MDA,ADS,NASDA";

  static String dieticians_name = "Sonia Mathur",
      dieticians_exp = "5 Years",
      dieticians_degrees = "MAC,MBS,NDAS";

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
          vertical: CustomStyle.verticalFractions * 3.236, //30
          horizontal: CustomStyle.verticalFractions * 2.696), //25
      children: <Widget>[
        //STATISTICS
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: CustomStyle.verticalFractions * 1.618, //15
              vertical: CustomStyle.verticalFractions * 1.833, //17
            ),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: CustomStyle.light_bn_color,
              borderRadius: BorderRadius.circular(
                  CustomStyle.verticalFractions * 1.941), //18
              boxShadow: <BoxShadow>[
                BoxShadow(
                  blurRadius: CustomStyle.verticalFractions * 0.862, //8
                  color: CustomStyle.light_bn_txt_Color,
                  offset: Offset.fromDirection(
                    CustomStyle.verticalFractions * 1.078, //10
                    -(CustomStyle.verticalFractions * 0.323), //3
                  ),
                )
              ],
            ),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'STATISTICS',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CustomStyle.light_bn_txt_Color,
                        fontSize: CustomStyle.verticalFractions * 3.236), //30
                  ),
                ),
                Divider(
                  indent: 0,
                  endIndent: 0,
                  color: CustomStyle.light_bn_txt_Color,
                ),
                ListTile(
                  leading: Icon(Icons.fastfood,
                      color: CustomStyle.light_bn_txt_Color),
                  title: Text(
                    'Dishes Cooked',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CustomStyle.light_bn_txt_Color,
                      fontSize: CustomStyle.verticalFractions * 2.373, //22
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.copyright,
                      color: CustomStyle.light_bn_txt_Color),
                  title: Text(
                    'Calories burnt',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CustomStyle.light_bn_txt_Color,
                      fontSize: CustomStyle.verticalFractions * 2.373, //22
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.line_weight,
                      color: CustomStyle.light_bn_txt_Color),
                  title: Text(
                    'Weight Loss',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CustomStyle.light_bn_txt_Color,
                      fontSize: CustomStyle.verticalFractions * 2.373, //22
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        //TRAINER'S DETAILS
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: CustomStyle.verticalFractions * 1.618, //15
              vertical: CustomStyle.verticalFractions * 2.157, //20
            ),
            margin: EdgeInsets.symmetric(
              vertical: CustomStyle.verticalFractions * 2.696, //25
            ),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: CustomStyle.light_bn_color,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    blurRadius: CustomStyle.verticalFractions * 1.618, //15
                    color: CustomStyle.light_bn_txt_Color,
                    offset: Offset.fromDirection(
                      CustomStyle.verticalFractions * 1.078, //10
                      -CustomStyle.verticalFractions * 0.323, //3
                    ))
              ],
              borderRadius: BorderRadius.circular(
                CustomStyle.verticalFractions * 1.618, //15
              ),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('TRAINER\'S DETAILS',
                        style: CustomStyle.button_header),
                  ],
                ),
                Divider(
                  color: CustomStyle.light_bn_txt_Color,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.account_circle,
                      size: CustomStyle.verticalFractions * 10.787, //100
                      color: CustomStyle.light_bn_txt_Color,
                    ),
                    SizedBox(
                      width: CustomStyle.verticalFractions * 3.775, //35
                      height: CustomStyle.verticalFractions * 2.157, //20
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                              text: 'Name: $trainers_name\n',
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Experience: $trainers_exp\n',
                                ),
                                TextSpan(text: 'Degrees: $trainers_degrees')
                              ],
                              style: TextStyle(
                                height:
                                    CustomStyle.verticalFractions * 0.237, //2.2
                                fontSize:
                                    CustomStyle.verticalFractions * 1.941, //18
                                color: CustomStyle.light_bn_txt_Color,
                                fontFamily: 'fonts/Roboto-Bold.ttf',
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        //DIETICIAN'S DETAILS
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: CustomStyle.verticalFractions * 1.618, //15
              vertical: CustomStyle.verticalFractions * 1.078, //10
            ),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: CustomStyle.light_bn_color,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      blurRadius: CustomStyle.verticalFractions * 1.618, //15
                      color: CustomStyle.light_bn_txt_Color,
                      offset: Offset.fromDirection(
                        CustomStyle.verticalFractions * 1.078, //10
                        -CustomStyle.verticalFractions * 0.323, //3
                      ))
                ],
                borderRadius: BorderRadius.circular(
                  CustomStyle.verticalFractions * 1.618, //15
                )),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('DIETICIAN\'S DETAILS',
                        style: CustomStyle.button_header),
                  ],
                ),
                Divider(
                  color: CustomStyle.light_bn_txt_Color,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.account_circle,
                      size: CustomStyle.verticalFractions * 10.787, //100
                      color: CustomStyle.light_bn_txt_Color,
                    ),
                    SizedBox(
                      width: CustomStyle.verticalFractions * 3.775, //35
                      height: CustomStyle.verticalFractions * 2.157, //20
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                              text: 'Name: $dieticians_name\n',
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Experience: $dieticians_exp\n',
                                ),
                                TextSpan(text: 'Degrees: $dieticians_degrees')
                              ],
                              style: TextStyle(
                                height:
                                    CustomStyle.verticalFractions * 0.237, //2.2
                                fontSize:
                                    CustomStyle.verticalFractions * 1.941, //18
                                color: CustomStyle.light_bn_txt_Color,
                                fontFamily: 'fonts/Roboto-Bold.ttf',
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
