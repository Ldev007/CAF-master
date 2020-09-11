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
  List product_list;

//COLOR PROPS
  final Color darkPurple = CustomStyle.light_bn_color;

  //MULTIPLIER SHORTCUTS
  final double vf = CustomStyle.verticalFractions;

  //ROUTINE DIET
  List<String> taken = ["Breakfast"];
  List<String> upcoming = ["Lunch, Dinner"];

  //INTAKE VALUES
  double calories = 0;
  double protein = 0;
  double water = 0;

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

  Widget tablet(String text) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 16,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
              color: Colors.black45, borderRadius: BorderRadius.circular(6)),
          child: Text(
            text,
            style: TextStyle(color: Colors.white70, letterSpacing: 1),
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
  Widget mealGenerator(String title) {
    return Container(
      padding: EdgeInsets.only(left: vf * 1.078),
      margin: EdgeInsets.only(top: vf * 2.157),
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      height: vf * 35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: vf * 3.8,
              color: darkPurple,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.overline,
              decorationThickness: vf * 0.086,
              decorationColor: darkPurple,
            ),
          ),
          Spacer(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: vf * 28,
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                return FlatButton(
                  padding: EdgeInsets.only(
                    right: vf * 2.1,
                  ),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            individualDishInterfaceGenerator(),
                      )),
                  // margin: EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage('images/dish.jpg'),
                        width: vf * 24,
                        height: vf * 23,
                      ),
                      Text(i == 2 ? 'EX: DUM ALOO' : 'Name of the dish',
                          style: TextStyle(
                              fontSize: vf * 3.1,
                              fontWeight: FontWeight.bold,
                              color: darkPurple)),
                    ],
                  ),
                );
              },
            ),
          ),
          Spacer(),
          Divider(
            color: darkPurple,
            indent: vf * 5.393,
            endIndent: vf * 5.393,
            thickness: 0.5,
          )
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
            body: SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    player,
                    SizedBox(height: 20),
                    Container(
                      // padding: EdgeInsets.all(10),
                      width: 500,
                      height: 200,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: darkPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                          width: 380,
                          height: 170,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(117, 131, 194, 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 270,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: darkPurple,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    )),
                                child: Text(
                                  'NUTRITIONAL VALUES',
                                  style: TextStyle(
                                      wordSpacing: 5,
                                      fontSize: 26,
                                      color: CustomStyle.light_bn_txt_Color,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )),
                    ),
                    Container(
                      // padding: EdgeInsets.all(10),
                      width: 500,
                      height: 400,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: darkPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                          width: 380,
                          height: 360,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(117, 131, 194, 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 290,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: darkPurple,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    )),
                                child: Text(
                                  'INGREDIENTS REQUIRED',
                                  style: TextStyle(
                                      wordSpacing: 10,
                                      fontSize: 26,
                                      color: CustomStyle.light_bn_txt_Color,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )),
                    ),
                    Container(
                      // padding: EdgeInsets.all(10),
                      width: 500,
                      height: 200,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: darkPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                          width: 380,
                          height: 170,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(117, 131, 194, 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 120,
                                height: 35,
                                alignment: Alignment.topLeft,
                                decoration: BoxDecoration(
                                    color: darkPurple,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                    )),
                                child: Text(
                                  'THE CHEF',
                                  style: TextStyle(
                                      wordSpacing: 5,
                                      fontSize: 26,
                                      color: CustomStyle.light_bn_txt_Color,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                            splashColor: CustomStyle.light_bn_txt_Color,
                            color: darkPurple,
                            padding: EdgeInsets.all(22),
                            shape: CircleBorder(),
                            onPressed: () => null,
                            child: Icon(
                              Icons.file_download,
                              color: CustomStyle.light_bn_txt_Color,
                              size: 35,
                            )),
                        RaisedButton(
                            splashColor: CustomStyle.light_bn_txt_Color,
                            color: darkPurple,
                            padding: EdgeInsets.all(22),
                            shape: CircleBorder(),
                            onPressed: () => null,
                            child: Icon(
                              Icons.star_border,
                              color: CustomStyle.light_bn_txt_Color,
                              size: 35,
                            )),
                        RaisedButton(
                            splashColor: CustomStyle.light_bn_txt_Color,
                            shape: CircleBorder(),
                            color: darkPurple,
                            padding: EdgeInsets.all(22),
                            onPressed: () => null,
                            child: Icon(
                              Icons.thumb_up,
                              color: CustomStyle.light_bn_txt_Color,
                              size: 35,
                            )),
                        RaisedButton(
                            shape: CircleBorder(),
                            splashColor: CustomStyle.light_bn_txt_Color,
                            color: darkPurple,
                            padding: EdgeInsets.all(22),
                            onPressed: () => null,
                            child: Icon(Icons.thumb_down,
                                color: CustomStyle.light_bn_txt_Color,
                                size: 35)),
                      ],
                    ),
                    FlatButton(
                        onPressed: () {
                          if (flag == true) {
                            _controller.play();
                            flag = false;
                          } else {
                            _controller.pause();
                            flag = true;
                          }
                        },
                        color: Colors.black54,
                        child: Text('PLAY/PAUSE'))
                  ],
                ),
              ),
            ),
          );
        });
  }

  List<String> _categoriesOfDishes = [
    "OATS MEAL :",
    "SALADS :",
    "CHINESE DISHES :",
    "Smoothies :",
    "Sprout meals :",
    "Bean Love :"
  ];

  @override
  Widget build(BuildContext context) {
    if (product_list == null) {
      return Text("loading");
    } else {
      print(MediaQuery.of(context).size.width * 0.94);
      print("Vertical Fracts : ${vf}");
      return MaterialApp(
        home: Scaffold(
          body: ListView(
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
                                          'H2O',
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
                                  tablet('BREAKFAST'),
                                  tablet('LUNCH')
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
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return mealGenerator(_categoriesOfDishes[index]);
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
    var x = collectionReference.document();
//      print("===================="+x.toString());
    collectionReference.snapshots().listen((snapshot) {
      List data;
      data = snapshot.documents;
//        print(data.runtimeType);
      data.forEach((element) {
//          print(element.data.toString());
      });
//        print(data[0].data['name'].toString());
      setState(() {
        product_list = data;
      });
    });
  }
}

class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_pricture;
  final prod_link;
  final prod_price;

  Single_prod({
    this.prod_name,
    this.prod_pricture,
    this.prod_link,
    this.prod_price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: prod_name,
          child: Material(
            child: InkWell(
              onTap: () {
//                print("called");
                _launchURL(prod_link);
              },
              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      leading: Text(
                        prod_name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        "\$$prod_price",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  child: Image.asset(
                    prod_pricture,
                    fit: BoxFit.cover,
                  )),
            ),
          )),
    );
  }

  _launchURL(String url) async {
//    const url = url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
