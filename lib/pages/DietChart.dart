import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ex/pages/ind_food.dart';
import 'package:firebase_ex/styling.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DietChart extends StatefulWidget {
  DietChart({Key key, String title}) : super(key: key);

  @override
  _DietChartState createState() => _DietChartState();
}

class _DietChartState extends State<DietChart> {
  _DietChartState() {
    super.initState();
    fetch();
    print("diet");
  }

  final isSelected = <bool>[false, false];
  Decoration _decoration = new BoxDecoration(
    color: Color.fromRGBO(128, 128, 128, 0.4),
    borderRadius: BorderRadius.circular(15),
  );

  int _currentValue = 1;

  //COLOR PROPS
  final Color darkPurple = CustomStyle.light_bn_color;

  //MULTIPLIER SHORTCUTS
  final double vf = CustomStyle.verticalFractions;

  //ROUTINE DIET
  List<String> taken = ["Breakfast"];
  List<String> upcoming = ["Lunch", "Dinner"];

  //INTAKE VALUES
  double calories = 0;
  double protein = 0;
  double water = 0;
  double cal = 200;
  int _count = 0;
  int _type;

  String _dietsTaken(List<String> takenDishes) {
    String txt;
    if (takenDishes.length == 1) {
      return takenDishes[0];
    } else if (takenDishes.length == 0) {
      return 'Yet to be started';
    } else {
      for (int i = 0; i < takenDishes.length; i++) {
        txt += takenDishes[i];
      }
      return txt;
    }
  }

  String _dietsUpcoming(List<String> upcomingDishes) {
    String txt;
    if (upcomingDishes.length == 1) {
      return upcomingDishes[0];
    } else if (upcomingDishes.length == 0) {
      return 'Yet to be started';
    } else {
      for (int i = 0; i < upcomingDishes.length; i++) {
        txt += upcomingDishes[i];
      }
      txt += txt + " \n";
      return txt;
    }
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

/* OVERLAY BUTTON FUNCTIONALITY*/

  addcal(int intake) async {
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
    }, merge: true);
    // trackerref.updateData({"calories": FieldValue.increment(1)});
    // double wat = prefs.getDouble("waterIntake");
    // setState(() {
    //   calories = 0.0;
    //   protein = 0.0;
    //   water = wat;
    //   food_data = m;
    // });
  }

  /* OVERLAY PART */

  // OVERLAY DATA MEMBERS //
  Future<bool> flg;
  OverlayState overlay;
  OverlayEntry entry;

  // OVERLAY BUILDER FUNCTION //

  //PUT OVERLAY BUTTON'S LOGIC IN THE BELOW "onPressed" FUNCTION

  OverlayEntry _buildOverlay() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 725,
          left: 112,
          width: MediaQuery.of(context).size.width * 0.53,
          height: MediaQuery.of(context).size.height * 0.1,
          child: SafeArea(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15) //12,
                  ),
              color: CustomStyle.light_bn_color,
              onPressed: () {
                print(_count);
                print(_type);
                int intake = _count * _type;
                addcal(intake);
              }, //<<-- WHATEVER BUTTON PRESS WILL DO WILL COME HERE
              child: Text(
                'ADD',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: 1.5,
                  fontFamily: 'fonts/Anton-Regular.ttf',
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> _getBool() async {
    return flg;
  }

  // END OF THE OVERLAY SECTION //

//FUNCTION TO GENERATE INDIVIDUAL CATEGORIES HAVING DIFFERENT DISHES
  Widget mealGenerator(String title, Map<String, dynamic> food) {
    List<String> items = food.keys.toList();
    return Container(
      padding: EdgeInsets.only(left: vf * 1.078), //10
      margin: EdgeInsets.only(top: vf * 2.157), //21
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      height: vf * 27.5, //267.85
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
//          Text(items.toString()),
          Text(
            title != null ? title : "_",
            style: TextStyle(
              fontSize: vf * 3.8, //37
              color: darkPurple,
              fontWeight: FontWeight.bold,
              decorationThickness: vf * 0.086, //0.8
              decorationColor: darkPurple,
            ),
          ),
          SizedBox(height: vf * 1.4), //13.636
          Container(
            width: MediaQuery.of(context).size.width,
            height: vf * 22, //214
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {
                    overlay = Overlay.of(context, rootOverlay: true);

                    entry = _buildOverlay();

                    WidgetsBinding.instance
                        .addPostFrameCallback((_) => overlay.insert(entry));
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (context) => WillPopScope(
                          child: individualDishInterfaceGenerator(
                              food[items[i]]['vedio'],
                              food[items[i]]['calories'],
                              food[items[i]]['serve'],
                              food[items[i]]['incredients'],
                              food[items[i]]['constituent']),
                          onWillPop: _getBool,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(vf * 1.026), //10
                        ),
                        elevation: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(vf * 1.026), //10
                          child: CachedNetworkImage(
                            imageUrl: food[items[i]]['pic'],
                            width: vf * 24,
                            height: vf * 16,
                            placeholder: (context, url) =>
                                new CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                new Icon(Icons.error_outline),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 0.0,
                          left: vf * 1.026, //10
                        ),
                        child: Text(
                          items[i],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: vf * 1.848, //18
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: vf * 0.308, //3
                          left: vf * 1.026, //10
                          bottom: vf * 1.54, //15
                        ),
                        child: Text(
                          food[items[i]]['calories'].toString() + ' cal',
                          style: TextStyle(
                            fontSize: vf * 1.232, //12
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Spacer(),
        ],
      ),
    );
  }

  bool flag = true;

//TO-DO: CONSTRUCT INDIVUAL DISH INTERFACE DESIGN AS WELL AS FRONT-END FUNCTIONALITY
  Widget individualDishInterfaceGenerator(String p, int specific_cal,
      Map<String, dynamic> m, List<dynamic> inc, List<dynamic> cons) {
    YoutubePlayerController _controller;
    String videoU = YoutubePlayer.convertUrlToId(p);
    print(videoU);
    _controller = YoutubePlayerController(initialVideoId: videoU);
    print(m.toString());
    print(cons.toString());
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
      m.forEach((key, value) {
        listings
            .add(Text(key.toString(), style: TextStyle(color: Colors.white)));
      });
      return listings;
    }

    List<dynamic> val = m.values.toList();
    print(val[2].toString());
    return YoutubePlayerBuilder(
        player: YoutubePlayer(controller: _controller),
        builder: (context, player) {
          return Scaffold(
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      player,
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          entry.remove();
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.71,
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
                        height: MediaQuery.of(context).size.height * 0.71,
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
                                    margin:
                                        EdgeInsets.only(right: vf * 0.513), //5
                                    padding: EdgeInsets.symmetric(
                                      horizontal: vf * 1.54, //15
                                      vertical: vf * 1.54, //15
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(128, 128, 128, 0.4),
                                      borderRadius:
                                          BorderRadius.circular(vf * 1.54), //15
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Divider(
                                            indent: vf * 1.026, //10
                                            endIndent: vf * 1.026, //10
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
                                            indent: vf * 5.133, //50
                                            endIndent: vf * 5.133, //50
                                            color: Colors.white),
                                        Expanded(
                                          flex: vf.round(),
                                          child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            padding: EdgeInsets.only(
                                                top: vf * 1.54), //15
                                            physics: BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: inc.length,
                                            itemBuilder: (context, index) =>
                                                Column(
                                              children: [
                                                FittedBox(
                                                  child: tablet(
                                                    inc[index],
                                                  ),
                                                ),
                                                SizedBox(height: vf * 1.2), //12
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
                                    margin:
                                        EdgeInsets.only(left: vf * 0.513), //5
                                    padding: EdgeInsets.symmetric(
                                      horizontal: vf * 1.54, //15
                                      vertical: vf * 1.54, //15
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(128, 128, 128, 0.4),
                                      borderRadius:
                                          BorderRadius.circular(vf * 1.54), //15
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    child: Column(
                                      children: [
                                        Divider(
                                          color: Colors.white,
                                          indent: vf * 1.026, //10
                                          endIndent: vf * 1.026, //10
                                        ),
                                        Expanded(
                                          child: Text(
                                            'WHY SHOULD YOU EAT IT ?',
                                            style: TextStyle(
                                              fontSize: vf * 1.54, //15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ),
                                        Divider(
                                            indent: vf * 5.133, //50
                                            endIndent: vf * 5.133, //50
                                            color: Colors.white),
                                        Expanded(
                                          flex: vf.round(),
                                          child: ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              padding: EdgeInsets.only(
                                                  top: vf * 1.54), //15
                                              physics: BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: cons.length,
                                              itemBuilder: (context, index) =>
                                                  Column(
                                                    children: [
                                                      FittedBox(
                                                        child: tablet(
                                                          cons[index],
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
                              padding: EdgeInsets.only(top: vf * 0.821), //8
                              child: Row(
                                children: [
                                  Container(
                                    height: vf * 8.213, //80
                                    width: vf * 8.213, //80
                                    // decoration: BoxDecoration(
                                    //   border:Border(
                                    //     top: BorderSide(color: Colors.white),
                                    //     bottom:BorderSide(color: Colors.white),
                                    //   )
                                    // ),
                                    child: CupertinoPicker(
                                      itemExtent: vf * 4.106, //40
                                      onSelectedItemChanged: (int i) {
                                        setState(() {
                                          _count = i;
                                        });
                                      },
                                      children: _getnumbers(),
                                    ),
                                  ),
                                  Container(
                                    height: vf * 8.213, //80
                                    width: vf * 8.213, //80
                                    // decoration: BoxDecoration(
                                    //   border:
                                    // ),
                                    child: CupertinoPicker(
                                      itemExtent: vf * 5.133, //50
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
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: RaisedButton(
                          onPressed: () {
                            print(_count);
                            print(_type);
                          },
                          child: Text(
                            'Bottom Button!',
                            style: TextStyle(fontSize: vf * 2.053), //20
                          ),
                          color: Colors.blue,
                          textColor: Colors.white,
                          elevation: vf * 0.513, //5
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
            ),
          );
        });
  }

  Map<String, dynamic> food_data = {};
  Map<String, dynamic> recommend = {};

  @override
  Widget build(BuildContext context) {
    List<String> titles = food_data.keys.toList();
    if (food_data.isEmpty) {
      return Text("loading");
    } else {
      // print(MediaQuery.of(context).size.width * 0.94);
      // print("Vertical Fracts : ${vf}");
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              "Diet",
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w600,
                fontSize: vf * 3.593, //35
              ),
            ),
          ),
          body: ListView(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: vf * 1.026), //10
                    decoration: BoxDecoration(
                        border: Border.all(color: darkPurple, width: 0.5),
                        borderRadius: BorderRadius.circular(vf * 1.54), //15
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: darkPurple,
                              blurRadius: vf * 1.026,
                              spreadRadius: -2),
                        ],
                        color: darkPurple),
                    child: ExpansionTile(
                      childrenPadding: EdgeInsets.symmetric(
                        vertical: vf * 2.053, //20
                        horizontal: vf * 1.026, //10
                      ),
                      title: Row(
                        children: [
                          Text(
                            'CURRENT PLAN',
                            style: TextStyle(
                                fontSize: vf * 3.08, //30
                                fontWeight: FontWeight.bold,
                                color: CustomStyle.light_bn_txt_Color),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                double wat = prefs.getDouble('waterIntake');
                                setState(() {
                                  water = wat;
                                });
                              })
                        ],
                      ),
                      children: [
                        //TO-DO: Continue designing the container (color, layout, etc)
                        //padding in container has to be verified once

                        Container(
                          padding: EdgeInsets.only(
                            top: vf * 2.053, //20
                            bottom: vf * 2.053, //20
                            left: vf * 1.026, //10
                            right: vf * 1.026, //10
                          ),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(117, 131, 194, 1),
                              borderRadius: BorderRadius.circular(
                                vf * 2.053, //20
                              )),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'STATISTICS',
                                style: TextStyle(
                                  fontSize: vf * 3.08, //30
                                  fontFamily: '',
                                  fontWeight: FontWeight.bold,
                                  color: CustomStyle.light_bn_txt_Color,
                                ),
                              ),
                              SizedBox(height: vf * 2.053), //20
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black45,
                                      borderRadius: BorderRadius.circular(
                                          vf * 2.157), //20
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: vf * 2.157, //21
                                    ),
                                    width: vf * 18, //141
                                    height: vf * 10.266, //100
                                    child: Column(
                                      children: [
                                        Text(
                                          'CAL',
                                          style: TextStyle(
                                              fontSize: CustomStyle
                                                      .verticalFractions *
                                                  2.373, //22
                                              color: CustomStyle
                                                  .light_bn_txt_Color,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: vf * 1.510), //14
                                        Text(
                                          '$calories',
                                          style: TextStyle(
                                            fontSize: vf * 1.833, //17,
                                            color:
                                                CustomStyle.light_bn_txt_Color,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  // SizedBox(width: vf * 1.078), //10
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(
                                  //           vf * 2.053), //20
                                  //       color: Colors.black45),
                                  //   padding: EdgeInsets.symmetric(
                                  //       vertical: vf * 2.157), //20
                                  //   width: vf * 12,
                                  //   height: vf * 10.266, //100
                                  //   child: Column(
                                  //     children: [
                                  //       Text(
                                  //         'PROTEIN',
                                  //         style: TextStyle(
                                  //             fontSize: CustomStyle
                                  //                     .verticalFractions *
                                  //                 2.373, //22
                                  //             color: CustomStyle
                                  //                 .light_bn_txt_Color,
                                  //             fontWeight: FontWeight.bold),
                                  //       ),
                                  //       SizedBox(height: vf * 1.510), //14
                                  //       Text(
                                  //         '$protein',
                                  //         style: TextStyle(
                                  //           fontSize: vf * 1.833, //17
                                  //           color:
                                  //               CustomStyle.light_bn_txt_Color,
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // SizedBox(width: vf * 1.078), //10
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.black45),
                                    padding: EdgeInsets.symmetric(
                                        vertical: vf * 2), //20
                                    width: vf * 18, //117
                                    height: vf * 10.266, //100
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'WATER',
                                          style: TextStyle(
                                              fontSize: CustomStyle
                                                      .verticalFractions *
                                                  2.373, //22
                                              color: CustomStyle
                                                  .light_bn_txt_Color,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // SizedBox(height: vf * 1.510), //14
                                        Text(
                                          water != null
                                              ? water.toStringAsPrecision(2) +
                                                  ' L'
                                              : 0.toString() + ' L',
                                          style: TextStyle(
                                            fontSize: vf * 1.833, //17
                                            color:
                                                CustomStyle.light_bn_txt_Color,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: vf * 4.106), //40
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(117, 131, 194, 1),
                            borderRadius:
                                BorderRadius.circular(vf * 2.053), //20
                          ),
                          padding: EdgeInsets.only(
                            left: vf * 1.54, //15
                            right: vf * 1.54, //15
                            top: vf * 2.258, //22
                            bottom: vf * 2.053, //20
                          ),
                          child: Column(
                            children: [
                              Text(
                                'ROUTINE DIET',
                                style: TextStyle(
                                  fontSize: vf * 3.08, //30
                                  fontWeight: FontWeight.bold,
                                  color: CustomStyle.light_bn_txt_Color,
                                ),
                              ),
                              SizedBox(height: vf * 3.08), //30
                              Row(
                                children: [
                                  Text(
                                    'TAKEN :',
                                    style: TextStyle(
                                      fontSize: vf * 2.258, //22
                                      fontWeight: FontWeight.bold,
                                      color: CustomStyle.light_bn_txt_Color,
                                    ),
                                  ),
                                  //TABLET !
                                  // ListView.builder(
                                  //     itemCount: taken.length,
                                  //     itemBuilder: (context,index){
                                  //   return tablet('BREAKFAST');
                                  // }),
                                  tablet('BREAKFAST'),
                                  tablet('LUNCH'),
                                ],
                              ),
                              SizedBox(height: vf * 2.053), //20
                              Row(
                                children: [
                                  Text(
                                    'UPCOMING : ',
                                    style: TextStyle(
                                      fontSize: vf * 2.258, //22
                                      fontWeight: FontWeight.bold,
                                      color: CustomStyle.light_bn_txt_Color,
                                    ),
                                  ),
                                  tablet('DINNER'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              recommend.isEmpty
                  ? null
                  : mealGenerator("Recommended For You", recommend),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  return mealGenerator(titles[index], food_data[titles[index]]);
                },
              ),
            ],
          ),
        ),
      );
    }
  }

  fetch() async {
    CollectionReference collectionReference =
        Firestore.instance.collection('food');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("uid");
    Map<String, dynamic> m = {};
    collectionReference.snapshots().listen((snapshot) {
      List data;
      data = snapshot.documents;
      data.forEach((element) {
        m[element.documentID.toString()] = element.data;
        print("===================================" + element.data.toString());
        Map<String, dynamic> x = element.data;
        x.forEach((key, value) {
          if (value['calories'] < cal + 100 && value['calories'] > cal - 100) {
            recommend[key.toString()] = value;
          }
        });
      });
    });
    //Tracking fetch
    DocumentReference trackerref = await Firestore.instance
        .collection('UserData')
        .document(uid)
        .collection('excercise')
        .document('Diet');
    DocumentSnapshot trackersnap = await trackerref.get();
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
    Map<String, dynamic> temp =
        trackersnap.data[year.toString()][x][date.toString()];
    print(temp.toString());
    if (temp == null) {
      trackerref.setData({
        year.toString(): {
          x: {
            date.toString(): {
              "cal": 0,
              "protien": 0,
            }
          }
        }
      }, merge: true);
      double wat = prefs.getDouble("waterIntake");
      setState(() {
        calories = 0.0;
        protein = 0.0;
        water = wat;
        food_data = m;
      });
    } else {
      double wat = prefs.getDouble("waterIntake");
      setState(() {
        calories = temp['cal'].toDouble();
        protein = temp['protien'].toDouble();
        water = wat;
        food_data = m;
      });
    }
  }
}

update(int p, String x, int cal) async {
  int intake = 0;
  if (x == "KG") {
    intake = p * cal;
  } else {
    intake = p * cal;
  }
}
//
// class Single_prod extends StatelessWidget {
//   final prod_name;
//   final prod_pricture;
//   final prod_link;
//   final prod_price;
//
//   Single_prod({
//     this.prod_name,
//     this.prod_pricture,
//     this.prod_link,
//     this.prod_price,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Hero(
//           tag: prod_name,
//           child: Material(
//             child: InkWell(
//               onTap: () {
// //                print("called");
//                 _launchURL(prod_link);
//               },
//               child: GridTile(
//                   footer: Container(
//                     color: Colors.white70,
//                     child: ListTile(
//                       leading: Text(
//                         prod_name,
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       title: Text(
//                         "\$$prod_price",
//                         style: TextStyle(
//                             color: Colors.red, fontWeight: FontWeight.w800),
//                       ),
//                     ),
//                   ),
//                   child: Image.asset(
//                     prod_pricture,
//                     fit: BoxFit.cover,
//                   )),
//             ),
//           )),
//     );
//   }
//
//   _launchURL(String url) async {
// //    const url = url;
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
// }
