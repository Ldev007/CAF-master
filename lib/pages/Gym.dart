import 'dart:ui';
import 'package:firebase_ex/pages/qrscanner.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GymDetail extends StatefulWidget {

  @override
  _GymDetailState createState() => _GymDetailState();
}

class _GymDetailState extends State<GymDetail> {

  _GymDetailState(){
    super.initState();
    fetch();
    print("init");
  }
  bool inside;
  Map data;
  String attend='0';
  String x="noentry";
  bool got=false;
  String Gym="";
  String total='0';
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
                height: screenHeight,
                width: screenWidth,
                color: Colors.transparent
            ),
            Container(
                height: screenHeight - screenHeight / 1.5,
                width: screenWidth,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/gy.jpg'),
                        fit: BoxFit.cover
                    )
                )
            ),
            Positioned(
                top: screenHeight - screenHeight /1.5 - 30.0,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  padding: EdgeInsets.only(left: 20.0),
                  height: screenHeight / 1.5 + 25.0,
                  width: screenWidth,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 25.0),
                        Text(Gym,
                            style: GoogleFonts.tinos(
                                fontSize: 35.0,
                                fontWeight: FontWeight.w500
                            )
                        ),
                        SizedBox(height: 7.0),
                        Text('Santa Monica, CA',
                            style: GoogleFonts.sourceSansPro(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF5E5B54)
                            )
                        ),
//                        SizedBox(height: 7.0),
//                        Row(
//                          children: <Widget>[
//                            SmoothStarRating(
//                                allowHalfRating: false,
//                                starCount: 5,
//                                rating: 4.0,
//                                size: 15.0,
//                                color: Color(0xFFF36F32),
//                                borderColor: Color(0xFFF36F32),
//                                spacing:0.0
//                            ),
//                            SizedBox(width: 3.0),
//                            Text('4.7',
//                                style: GoogleFonts.sourceSansPro(
//                                    fontSize: 14.0,
//                                    fontWeight: FontWeight.w400,
//                                    color: Color(0xFFD57843)
//                                )
//                            ),
//                            SizedBox(width: 3.0),
//                            Text('(200 Reviews)',
//                                style: GoogleFonts.sourceSansPro(
//                                    fontSize: 14.0,
//                                    fontWeight: FontWeight.w400,
//                                    color: Color(0xFFC2C0B6)
//                                )
//                            )
//                          ],
//                        ),
                        SizedBox(height: 15.0),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top:30.0),
                            child: Column(
                              children: <Widget>[
                                Text(got?"Welcome Please go inside":"Persons:-  ",
                                    style: GoogleFonts.sourceSansPro(
                                        fontSize: 34.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF201F1C)
                                    )
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:18.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                                    crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
                                    children: <Widget>[
                                      Container(
                                        height: 65,
                                        width:65,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.deepOrangeAccent,
                                            ),
                                            color: Colors.deepOrangeAccent,
                                            borderRadius: BorderRadius.all(Radius.circular(20))
                                        ),

                                        child: Center(
                                          child: Text(attend,
                                              style: GoogleFonts.sourceSansPro(
                                                  fontSize: 50.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF201F1C)
                                              )
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width:50,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top:15.0),
                                          child: Text('/'+total,
                                              style: GoogleFonts.sourceSansPro(
                                                  fontSize: 30.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF201F1C)
                                              )
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
//                        SizedBox(height: 5.0),
//                        Text('Read More',
//                            style: GoogleFonts.sourceSansPro(
//                                fontSize: 14.0,
//                                fontWeight: FontWeight.w400,
//                                color: Color(0xFFF36F32)
//                            )
//                        ),
//                        SizedBox(height: 10.0),
//                        Container(
//                            width: 150.0,
//                            child: Row(
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                children: [
//                                  Column(
//                                    crossAxisAlignment: CrossAxisAlignment.start,
//                                    children: <Widget>[
//                                      Text(
//                                          '200',
//                                          style: GoogleFonts.tinos(
//                                              fontSize: 25.0,
//                                              fontWeight: FontWeight.w500
//                                          )
//                                      ),
//                                      Text(
//                                          'Reviews',
//                                          style: GoogleFonts.sourceSansPro(
//                                              fontSize: 15.0,
//                                              fontWeight: FontWeight.w400,
//                                              color: Color(0xFF5E5B54)
//                                          )
//                                      )
//                                    ],
//                                  ),
//                                  Column(
//                                    crossAxisAlignment: CrossAxisAlignment.start,
//                                    children: <Widget>[
//                                      Text(
//                                          '4',
//                                          style: GoogleFonts.tinos(
//                                              fontSize: 25.0,
//                                              fontWeight: FontWeight.w500
//                                          )
//                                      ),
//                                      Text(
//                                          'Programs',
//                                          style: GoogleFonts.sourceSansPro(
//                                              fontSize: 15.0,
//                                              fontWeight: FontWeight.w400,
//                                              color: Color(0xFF5E5B54)
//                                          )
//                                      )
//                                    ],
//                                  )
//                                ]
//                            )
//                        )
                      ]
                  ),
//                  decoration: BoxDecoration(
//                      color: Color(0xFFFAF6ED),
//                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))
//                  ),
                )
            ),
//            Align(
//                alignment: Alignment.bottomRight,
//                child: Container(
//                  height: 75.0,
//                  width: 100.0,
//                  child: Center(
//                      child: Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: [
//                            Text('>',
//                                style: GoogleFonts.sourceSansPro(
//                                    fontSize: 20.0,
//                                    fontWeight: FontWeight.w500,
//                                    color: Color(0xFFFFF2D5)
//                                )
//                            ),
//                            Text('Availability',
//                                style: GoogleFonts.sourceSansPro(
//                                    fontSize: 12.0,
//                                    fontWeight: FontWeight.w500,
//                                    color: Color(0xFFFFF2D5)
//                                )
//                            )
//                          ]
//                      )
//                  ),
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0)),
//                      color: Color(0xFFFE6D2E)
//                  ),
//                )
//            ),
//            Align(
//                alignment: Alignment.topLeft,
//                child: Padding(
//                    padding: EdgeInsets.only(left: 15.0, top: 30.0),
//                    child: Container(
//                        height: 40.0,
//                        width: 40.0,
//                        decoration: BoxDecoration(
//                            shape: BoxShape.circle,
//                            color: Color(0xFFA4B2AE)
//                        ),
//                        child: Center(
//                            child: Icon(Icons.arrow_back, size: 20.0, color: Colors.white)
//                        )
//                    )
//                )
//            ),

            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 30.0),
                    child: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFA4B2AE)
                        ),
                        child: Center(
                            child: Icon(Icons.arrow_back, size: 30.0, color: Colors.white)
                        )
                    )
                )
            ),
            Container(
              child: Text(x),
            ),
//            Positioned(
//                top: (screenHeight - screenHeight / 3) / 2,
//                left: (screenWidth /2) - 75.0,
//                child: Container(
//                    height: 40.0,
//                    width: 150.0,
//                    decoration: BoxDecoration(
//                        color: Color(0xFFA4B2AE),
//                        borderRadius: BorderRadius.circular(20.0)
//                    ),
//                    child: Center(
//                        child: Text('Explore Programs',
//                            style: GoogleFonts.sourceSansPro(
//                                fontSize: 14.0,
//                                fontWeight: FontWeight.w500,
//                                color: Colors.white
//                            )
//                        )
//                    )
//                )
//            ),
            Positioned(
                top: screenHeight - screenHeight / 1.5 - 45.0,
                right: 25.0,
//                child: Hero(
//                    tag: ,
                    child: InkWell(
                      onTap: (){
                        print("hi");
                        _navigateAndDisplaySelection(context);
                        //Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => qrscanner()));
                        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => qrscanner()));
                      },
                      child: Stack(
                        children: <Widget>[
                          Container(
                              height: 100.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('images/qr.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(15.0)
                              ),
                              child:BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                                child: Container(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                          ),
                          Container(
                            height: 100.0,
                            width: 100.0,
                            child:Center(
                              child:Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                child: Text('Click To Scan',
                                  style: GoogleFonts.sourceSansPro(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                  )
                            ),
                              ),),
                          ),
                        ]
                      ),
                    )
                )
//            )
          ],
        )
    );
  }
  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => qrscanner()),
    );
    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    int p=0;
    String qr;
    setState(() {
      got = true;
      qr = result;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    inside = prefs.getBool("inside");
    if(qr==x) {
      if(!inside){
        p = int.parse(attend);
        CollectionReference collectionReference = Firestore.instance.collection('gym').document(x).collection('population');
        collectionReference.document('populationdoc').updateData({'crowd': (p + 1).toString()});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("inside",true);
        _showDialog("Enjoy your excercise","Attendance Complete");
      }
      else{
        p = int.parse(attend);
        CollectionReference collectionReference = Firestore.instance.collection('gym').document(x).collection('population');
        collectionReference.document('populationdoc').updateData({'crowd': (p - 1).toString()});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("inside",false);
        _showDialog("Please Visit Again","Goal Achieved");
      }
    }
    else{
      print("wrong gym go to "+x);
      _showDialog("Either you are not registered to this or by your gym owner","Something Went Wrong");
    }
//    Scaffold.of(context)
//      ..removeCurrentSnackBar()
//      ..showSnackBar(SnackBar(content: Text("$result")));
  }

  void _showDialog(String msg,String title) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  fetch() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.setString("uid","1ydRuGXxonhiKVnk1N9NNKytxvs2");  //set on screen 8
//    prefs.setBool("inside",false); //set on screen 8
    String uid = prefs.getString("uid");
    inside = prefs.getBool("inside");
    print( prefs.getString("uid"));
    print(inside);
    DocumentSnapshot ds = await Firestore.instance.collection('UserData').document(uid).get();
    if(ds.data['gym']=='noentry'){
      Gym="No Data";
    }
    else {
      x = ds.data['gym'];
    }
//    CollectionReference collectionReference = Firestore.instance.collection('UserData');
//    collectionReference.snapshots().forEach((element) {print(element);});
//    x=collectionReference.document(uid)[0];
    if(x!="noentry") {
      CollectionReference collectionReference = Firestore.instance.collection('gym').document(x).collection('population');
      collectionReference.snapshots().listen((snapshot) {
        //List data;
        setState(() {
          Gym = x;
          data = snapshot.documents[0].data;
          if (data['crowd'] != null) {
            attend = data['crowd'];
          }
          else {
            attend = "_";
          }
        });
      });
    }
  }
}

