import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ex/styling.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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

  //COLOR PROPS
  final Color darkPurple = CustomStyle.light_bn_color;

  //MULTIPLIER SHORTCUTS
  final double vf = CustomStyle.verticalFractions;

  //ROUTINE DIET
  List<String> taken = ["Breakfast"];
  List<String> upcoming = ["Lunch", "Dinner"];

  //NUTRITIONAL FACTS
  List<String> nutFacts1 = [
    "Energy 429 kcal",
    "Total Fat 17.3 g",
    "Saturated Fatty Acids 8.1 g",
    "Total Fatty Acids 0 g",
    "Total Carbohydrates 58.3 g",
    "Of which sugars 4.4 g",
    "Protein 10 g",
    "Calcium 105 mg"
  ];

  List<String> nutFacts2 = [
    "Total Carbohydrates 58.3 g",
    "Of which sugars 4.4 g",
    "Protein 10 g",
    "Calcium 105 mg"
  ];

  List<String> ingredients1 = [
    "1 Cube of Maggi",
    "1 Packet Masala",
    "1 Tbsp Salt",
    "Half a cup water",
    "Handfull Cabbage",
    "1 Green/Red Bell Pepper",
    "5-10 Peas",
    "Half a Tbsp of Pepper Salt"
  ];
  List<String> ingredients2 = [
    "Handfull Cabbage",
    "1 Green/Red Bell Pepper",
    "5-10 Peas",
    "Half a Tbsp of Pepper Salt"
  ];

  //INTAKE VALUES
  double calories = 0;
  double protein = 0;
  double water = 0;
  double cal = 200;

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
        SizedBox(
          width: 16,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
              color: colr != null ? colr : Colors.black45,
              borderRadius: BorderRadius.circular(6)),
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

  String videoURL =
      YoutubePlayer.convertUrlToId("https://youtu.be/DChGFbpPqTw");

  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(initialVideoId: videoURL);
  }

//FUNCTION TO GENERATE INDIVIDUAL CATEGORIES HAVING DIFFERENT DISHES
  Widget mealGenerator(String title,Map<String,dynamic> food) {
    List<String> items=food.keys.toList();
    return Container(
      padding: EdgeInsets.only(left: vf * 1.078),
      margin: EdgeInsets.only(top: vf * 2.157),
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      height: vf * 38,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
//          Text(items.toString()),
          Text(
            title != null?title:"_",
            style: TextStyle(
              fontSize: vf * 3.8,
              color: darkPurple,
              fontWeight: FontWeight.bold,
              decorationThickness: vf * 0.086,
              decorationColor: darkPurple,
            ),
          ),
          Spacer(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: vf * 32,
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap:() => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            individualDishInterfaceGenerator(),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 2,
                        child:
                        CachedNetworkImage(
                          imageUrl: food[items[i]]['pic'],
                          width:vf * 24,
                          height: vf * 23 ,
                          placeholder: (context, url) => new CircularProgressIndicator(),
                          errorWidget: (context, url, error) => new Icon(Icons.error_outline),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 0.0,left:10),
                        child: Text(
                          items[i],
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 3.0,left:10,bottom: 15),
                        child: Text(
                          food[items[i]]['calories'].toString()+' cal',
                          style: TextStyle(
                            fontSize: 12.0,
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
  Widget individualDishInterfaceGenerator() {
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
                        onPressed: () => Navigator.pop(context),
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
                        child: Row(
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
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Divider(
                                        indent: 10,
                                        endIndent: 10,
                                        color: Colors.white),
                                    Expanded(
                                      child: Text(
                                        'HOW TO COOK ?',
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
                                        itemCount: ingredients1.length,
                                        itemBuilder: (context, index) => Column(
                                          children: [
                                            FittedBox(
                                              child: tablet(
                                                ingredients1[index],
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
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
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
                                          itemCount: nutFacts1.length,
                                          itemBuilder: (context, index) =>
                                              Column(
                                                children: [
                                                  FittedBox(
                                                    child: tablet(
                                                      nutFacts1[index],
                                                    ),
                                                  ),
                                                  SizedBox(height: vf * 1.2),
                                                ],
                                              )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
  Map<String, dynamic> now = {};

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
          body: ListView(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: darkPurple, width: 0.5),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: darkPurple,
                              blurRadius: 10,
                              spreadRadius: -2),
                        ],
                        color: darkPurple),
                    child: ExpansionTile(
                      childrenPadding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      title: Text(
                        'CURRENT PLAN',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: CustomStyle.light_bn_txt_Color),
                      ),
                      children: [
                        //TO-DO: Continue designing the container (color, layout, etc)
                        //padding in container has to be verified once

                        Container(
                          padding: EdgeInsets.only(
                              top: 20, bottom: 20, left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(117, 131, 194, 1),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'INTAKE',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: '',
                                  fontWeight: FontWeight.bold,
                                  color: CustomStyle.light_bn_txt_Color,
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black45,
                                      borderRadius: BorderRadius.circular(
                                          vf * 2.157), //20
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: vf * 2.157),
                                    width: vf * 12, //141
                                    height: 100,
                                    child: Column(
                                      children: [
                                        Text(
                                          'KCAL',
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
                                  SizedBox(width: vf * 1.078), //10
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.black45),
                                    padding: EdgeInsets.symmetric(
                                        vertical: vf * 2.157), //20
                                    width: vf * 12,
                                    height: 100,
                                    child: Column(
                                      children: [
                                        Text(
                                          'PROTEIN',
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
                                          '$protein',
                                          style: TextStyle(
                                            fontSize: vf * 1.833, //17
                                            color:
                                                CustomStyle.light_bn_txt_Color,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: vf * 1.078), //10
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.black45),
                                    padding: EdgeInsets.symmetric(
                                        vertical: vf * 2.157), //20
                                    width: vf * 12,
                                    height: 100,
                                    child: Column(
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
                                        SizedBox(height: vf * 1.510), //14
                                        Text(
                                          '$water L',
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
                        SizedBox(height: 40),
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(117, 131, 194, 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.only(
                              left: 15, right: 15, top: 22, bottom: 20),
                          child: Column(
                            children: [
                              Text(
                                'ROUTINE DIET',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: CustomStyle.light_bn_txt_Color,
                                ),
                              ),
                              SizedBox(height: 30),
                              Row(
                                children: [
                                  Text(
                                    'TAKEN :',
                                    style: TextStyle(
                                      fontSize: 22,
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
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Text(
                                    'UPCOMING : ',
                                    style: TextStyle(
                                      fontSize: 22,
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
              now.isEmpty ? null : mealGenerator("Recommended For You", now),
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
    Map<String, dynamic> m = {};
    collectionReference.snapshots().listen((snapshot) {
      List data;
      data = snapshot.documents;
      data.forEach((element) {
        m[element.documentID.toString()] = element.data;
        Map<String, dynamic> x = element.data;
        x.forEach((key, value) {
          // print("key"+key.toString());
          // print("value"+value['calories'].toString());
          if (value['calories'] < cal + 100 && value['calories'] > cal - 100) {
            // print(key.toString());
            now[key.toString()] = value;
          }
        });
      });
      // print(m);
      print(now.toString());
      setState(() {
        food_data = m;
      });
    });
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
