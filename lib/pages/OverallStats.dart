import 'package:flutter/material.dart';

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
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
      children: <Widget>[
        //STATISTICS
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 17),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.blue[800],
              borderRadius: BorderRadius.circular(18),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  blurRadius: 8,
                  color: Colors.grey[400],
                  offset: Offset.fromDirection(10, -3),
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
                        color: Colors.white60,
                        fontSize: 30),
                  ),
                ),
                Divider(
                  indent: 0,
                  endIndent: 0,
                  color: Colors.white60,
                ),
                ListTile(
                  leading: Icon(Icons.fastfood, color: Colors.white54),
                  title: Text('Dishes Cooked',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white60,
                          fontSize: 22)),
                ),
                ListTile(
                  leading: Icon(Icons.copyright, color: Colors.white54),
                  title: Text('Calories burnt',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white60,
                          fontSize: 22)),
                ),
                ListTile(
                  leading: Icon(Icons.line_weight, color: Colors.white54),
                  title: Text('Weight Loss',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white60,
                          fontSize: 22)),
                ),
              ],
            ),
          ),
        ),

        //TRAINER'S DETAILS
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            margin: EdgeInsets.symmetric(vertical: 25),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.blue[800],
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      blurRadius: 15,
                      color: Colors.grey[400],
                      offset: Offset.fromDirection(10, -2))
                ],
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'TRAINER\'S DETAILS',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.white60,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.account_circle,
                      size: 100,
                      color: Colors.white54,
                    ),
                    SizedBox(
                      width: 35,
                      height: 20,
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
                                height: 2.2,
                                fontSize: 18,
                                color: Colors.white60,
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
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.blue[800],
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      blurRadius: 15,
                      color: Colors.grey[400],
                      offset: Offset.fromDirection(10, -2))
                ],
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'DIETICIAN\'S DETAILS',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.white60,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.account_circle,
                      size: 100,
                      color: Colors.white54,
                    ),
                    SizedBox(
                      width: 35,
                      height: 20,
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
                                height: 2.2,
                                fontSize: 18,
                                color: Colors.white60,
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
