import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'HomeScreen.dart';
class ind_food extends StatefulWidget {
  final vedio_link;
  final specific_cal;
  Map<String, dynamic> m;
  List<dynamic> inc;
  List<dynamic> cons;

  ind_food({
    this.vedio_link,
    this.specific_cal,
    this.m,
    this.inc,
    this.cons,
  });
  @override
  _ind_foodState createState() => _ind_foodState();
}

class _ind_foodState extends State<ind_food> {
  int _count = 0;
  int _type=0;//m.values.toList()[0];
  addcal(int intake) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("uid");
    DocumentReference trackerref = await Firestore.instance
        .collection('UserData')
        .document(uid)
        .collection('excercise')
        .document('Diet');
    DateTime now = DateTime.now();
    DateTime dda = DateTime(now.year, now.month, now.day);
    var fulldate = DateTime.parse(dda.toString());
//    print(moonLanding.month);
    var month = fulldate.month;
    var date = fulldate.day;
    var year = fulldate.year;
    print(
        'm' + month.toString() + 'd' + date.toString() + 'y' + year.toString());
    var x = '0' + month.toString();
      trackerref.setData({
        year.toString(): {
          x: {
            date.toString(): {
              "cal": FieldValue.increment(intake),
            }
          }
        }
      },merge: true);
    // trackerref.updateData({"calories": FieldValue.increment(1)});
      // double wat = prefs.getDouble("waterIntake");
      // setState(() {
      //   calories = 0.0;
      //   protein = 0.0;
      //   water = wat;
      //   food_data = m;
      // });
  }
  Widget tablet(String text, {Color colr}) {
      return Row(
        children: <Widget>[
          SizedBox(width: vf * 1.64), //16
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: vf * 1.026, //10
              vertical: vf * 0.821, //8
            ),
            decoration: BoxDecoration(
              color: colr != null ? colr : Colors.black45,
              borderRadius: BorderRadius.circular(vf * 0.616), //6
            ),
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white70,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    }

  @override
  Widget build(BuildContext context) {
    // _type=widget.m.values.toList()[0];
    final Size size = MediaQuery.of(context).size;
    YoutubePlayerController _controller;
    String videoU = YoutubePlayer.convertUrlToId(widget.vedio_link);
    print(videoU);
    _controller = YoutubePlayerController(initialVideoId: videoU);
    print(widget.m.toString());
    print(widget.cons.toString());
    List<Widget> _getnumbers() {
      List listings = List<Widget>();
      for (int i = 0; i < 100; i++) {
        listings.add(Text(
          i.toString(),
          style: TextStyle(color: Colors.white),
        ));
      }
      return listings;
    }

    List<Widget> _getListings() {
      // <<<<< Note this change for the return type
      List listings = List<Widget>();
      int i = 0;
      widget.m.forEach((key, value) {
        listings
            .add(Text(key.toString(), style: TextStyle(color: Colors.white)));
      });
      return listings;
    }

    List<dynamic> val = widget.m.values.toList();
    print(val[2].toString());

    
    return MaterialApp(
      home: Scaffold(
        body:YoutubePlayerBuilder(
          player: YoutubePlayer(controller: _controller),
        builder: (context, player) {
          return Scaffold(
            body: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    player,
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.645,
                      width: MediaQuery.of(context).size.width,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(
                          'https://images.pexels.com/photos/842571/pexels-photo-842571.jpeg?cs=srgb&dl=pexels-valeria-boltneva-842571.jpg&fm=jpg',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: vf * 1.5, vertical: vf * 3),
                      height: MediaQuery.of(context).size.height * 0.645,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Row(
                              //   children: [
                              //     Container(
                              //       width: vf * 15,
                              //       height: vf * 20,
                              //       child: ListView.builder(
                              //         padding: EdgeInsets.only(top: 15),
                              //         scrollDirection: Axis.vertical,
                              //         physics: NeverScrollableScrollPhysics(),
                              //         shrinkWrap: true,
                              //         itemBuilder: (context, index) => Column(
                              //           children: [
                              //             FittedBox(
                              //               child: tablet(
                              //                 ingredients1[index],
                              //                 colr:
                              //                     Color.fromRGBO(1, 1, 1, 0.4),
                              //               ),
                              //             ),
                              //             SizedBox(height: vf * 1.2)
                              //           ],
                              //         ),
                              //         itemCount: ingredients1.length,
                              //       ),
                              //     ),
                              //     Container(
                              //       width: vf * 20,
                              //       height: vf * 20,
                              //       child: ListView.builder(
                              //         padding: EdgeInsets.only(top: 15),
                              //         scrollDirection: Axis.vertical,
                              //         shrinkWrap: true,
                              //         itemBuilder: (context, index) => Column(
                              //           children: [
                              //             FittedBox(
                              //               child: tablet(
                              //                 ingredients2[index],
                              //                 colr:
                              //                     Color.fromRGBO(1, 1, 1, 0.4),
                              //               ),
                              //             ),
                              //             SizedBox(height: vf * 1.2)
                              //           ],
                              //         ),
                              //         itemCount: ingredients2.length,
                              //       ),
                              //     )
                              //   ],
                              // ),

                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(right: 5),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(128, 128, 128, 0.4),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  height: MediaQuery.of(context).size.height *
                                      0.35,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Divider(
                                          indent: 10,
                                          endIndent: 10,
                                          color: Colors.white),
                                      Expanded(
                                        child: Text(
                                          'INCREDIENTS',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                      Divider(
                                          indent: 50,
                                          endIndent: 50,
                                          color: Colors.white),
                                      Expanded(
                                        flex: vf.round(),
                                        child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          padding: EdgeInsets.only(top: 15),
                                          physics: BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: widget.inc.length,
                                          itemBuilder: (context, index) =>
                                              Column(
                                                children: [
                                                  FittedBox(
                                                    child: tablet(
                                                      widget.inc[index],
                                                    ),
                                                  ),
                                                  SizedBox(height: vf * 1.2),
                                                ],
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(128, 128, 128, 0.4),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  height: MediaQuery.of(context).size.height *
                                      0.35,
                                  child: Column(
                                    children: [
                                      Divider(
                                        color: Colors.white,
                                        indent: 10,
                                        endIndent: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'WHY SHOULD YOU EAT IT ?',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                      Divider(
                                          indent: 50,
                                          endIndent: 50,
                                          color: Colors.white),
                                      Expanded(
                                        flex: vf.round(),
                                        child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            padding: EdgeInsets.only(top: 15),
                                            physics: BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: widget.cons.length,
                                            itemBuilder: (context, index) =>
                                                Column(
                                                  children: [
                                                    FittedBox(
                                                      child: tablet(
                                                        widget.cons[index],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: vf * 1.2),
                                                  ],
                                                )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  // decoration: BoxDecoration(
                                  //   border:Border(
                                  //     top: BorderSide(color: Colors.white),
                                  //     bottom:BorderSide(color: Colors.white),
                                  //   )
                                  // ),
                                  child: CupertinoPicker(
                                    itemExtent: 40,
                                    onSelectedItemChanged: (int i) {
                                      setState(() {
                                        _count = i;
                                      });
                                    },
                                    children: _getnumbers(),
                                  ),
                                ),
                                Container(
                                  height: 80,
                                  width: 80,
                                  // decoration: BoxDecoration(
                                  //   border:
                                  // ),
                                  child: CupertinoPicker(
                                    itemExtent: 50,
                                    onSelectedItemChanged: (int i) {
                                      setState(() {
                                        _type = val[i];
                                      });
                                      print(i);
                                      print(_type);
                                    },
                                    children: _getListings(),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        width: size.width,
                        height: 60,
                        child: RaisedButton(
                          onPressed: () {
                            print(_count);
                            print(_type);
                            int intake = _count*_type;
                            addcal(intake);
                          },
                          child: const Text('ADD',
                              style: TextStyle(fontSize: 20)),
                          color: Colors.blue,
                          textColor: Colors.white,
                          elevation: 5,
                        ),
                      ),
                    ),
                  ],
                ),
                // Card(
                //   shadowColor: CustomStyle.light_bn_color,
                //   margin: EdgeInsets.only(left: 10, right: 10, bottom: 25),
                //   elevation: 5,
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(15)),
                //   child: Container(
                //     padding: EdgeInsets.symmetric(vertical: 10),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: <Widget>[
                //         Text(
                //           'NUTRITIONAL FACTS',
                //           style: TextStyle(
                //             wordSpacing: vf * 0.513,
                //             fontSize: vf * 2.566,
                //             color: CustomStyle.light_bn_color,
                //           ),
                //         ),
                //         Divider(
                //             indent: 100,
                //             endIndent: 100,
                //             color: CustomStyle.light_bn_color),
                //         Row(
                //           children: [
                //             //FIRST COLUMN
                //             Expanded(
                //               flex: 1,
                //               child: ListView.builder(
                //                 padding: EdgeInsets.only(top: 15),
                //                 scrollDirection: Axis.vertical,
                //                 physics: NeverScrollableScrollPhysics(),
                //                 shrinkWrap: true,
                //                 itemCount: 4,
                //                 itemBuilder: (context, val) {
                //                   return Column(
                //                     children: <Widget>[
                //                       tablet(nutFacts1[val],
                //                           colr: CustomStyle.light_bn_color),
                //                       SizedBox(height: 7),
                //                     ],
                //                   );
                //                 },
                //               ),
                //             ),

                //             //SECOND COLUMN
                //             Expanded(
                //               flex: 1,
                //               child: ListView.builder(
                //                 padding: EdgeInsets.only(top: 15),
                //                 scrollDirection: Axis.vertical,
                //                 physics: NeverScrollableScrollPhysics(),
                //                 shrinkWrap: true,
                //                 itemCount: 4,
                //                 itemBuilder: (context, val) {
                //                   return Column(
                //                     children: <Widget>[
                //                       tablet(nutFacts2[val],
                //                           colr: CustomStyle.light_bn_color),
                //                       SizedBox(height: 7),
                //                     ],
                //                   );
                //                 },
                //               ),
                //             ),
                //           ],
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // Card(
                //   shadowColor: CustomStyle.light_bn_color,
                //   margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                //   elevation: 5,
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(15)),
                //   child: Container(
                //     padding: EdgeInsets.symmetric(vertical: 10),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: <Widget>[
                //         Text(
                //           'INGREDIENTS REQUIRED',
                //           style: TextStyle(
                //             wordSpacing: vf * 1.026, //10
                //             fontSize: vf * 2.52, //19
                //             color: CustomStyle.light_bn_color,
                //           ),
                //         ),
                //         Divider(
                //             indent: 100,
                //             endIndent: 100,
                //             color: CustomStyle.light_bn_color),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             //FIRST COLUMN
                //             Expanded(
                //               flex: 1,
                //               child: ListView.builder(
                //                 padding: EdgeInsets.only(top: 15),
                //                 scrollDirection: Axis.vertical,
                //                 physics: NeverScrollableScrollPhysics(),
                //                 shrinkWrap: true,
                //                 itemCount: 4,
                //                 itemBuilder: (context, val) {
                //                   return Column(
                //                     children: <Widget>[
                //                       tablet(nutFacts1[val],
                //                           colr: CustomStyle.light_bn_color),
                //                       SizedBox(height: 7),
                //                     ],
                //                   );
                //                 },
                //               ),
                //             ),

                //             //SECOND COLUMN
                //             Expanded(
                //               flex: 1,
                //               child: ListView.builder(
                //                 padding: EdgeInsets.only(top: 15),
                //                 scrollDirection: Axis.vertical,
                //                 physics: NeverScrollableScrollPhysics(),
                //                 shrinkWrap: true,
                //                 itemCount: 4,
                //                 itemBuilder: (context, val) {
                //                   return Column(
                //                     children: <Widget>[
                //                       tablet(nutFacts2[val],
                //                           colr: CustomStyle.light_bn_color),
                //                       SizedBox(height: 7),
                //                     ],
                //                   );
                //                 },
                //               ),
                //             ),
                //           ],
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // Text(
                //   'THE CHEF',
                //   style: TextStyle(
                //     wordSpacing: vf * 0.513,

                //     ///5
                //     fontSize: vf * 2.669, //26
                //     color: CustomStyle.light_bn_color,
                //   ),
              ],
            ),
          );
        }),
      )
    );
  }
}
