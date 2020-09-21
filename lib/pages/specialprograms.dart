import 'package:firebase_ex/additional/LeftRightAlign.dart';
import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'exercise.dart';

class specialprograms extends StatefulWidget {
  @override
  _specialprogramsState createState() => _specialprogramsState();
}

class _specialprogramsState extends State<specialprograms> {
  var program_list = [
    {
      "name": "hiit",
      "duration": "6",
      "cal": "150",
      "picture": "images/hiit.jpeg",
      "type": "Beginners",
      "excercise": [
        "jumping_high_knees-s",
        "SQUADS-s",
        "plankrock-fd",
        "Jumpting_Squats-s",
        "legRaise-fu",
        // "pushups-fd",
      ],
    },
    {
      "name": "pilates",
      "duration": "9",
      "cal": "250",
      "picture": "images/pilates.jpeg",
      "type": "Beginners",
      "excercise": [
        "theonehundred-fu",
        "crossCrunches-fu",
        "doublelegstrech-fu",
        // "teasser",
        "pendulum-fu",
        "plankleglift-fu",
        "plankrock-fd",
        "hipdip-s"
      ],
    },
  ];
  ScrollController _controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: ListView.builder(
      physics: ClampingScrollPhysics(),
      controller: _controller,
      itemCount: program_list.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      reverse: true,
      itemBuilder: (BuildContext context, int index) {
        return Single_product(
          prod_picture: program_list[index]['picture'],
          prod_name: program_list[index]['name'],
          duration: program_list[index]['duration'],
          calories: program_list[index]['cal'],
          point: program_list[index]['type'],
          excercise : program_list[index]['excercise'],
        );
      },
    ));
  }
}

class Single_product extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final duration;
  final calories;
  final point;
  final excercise;

  Single_product({
    this.prod_name,
    this.prod_picture,
    this.duration,
    this.calories,
    this.point,
    this.excercise,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(0),
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(left: 0, right: 0, top: 8, bottom: 8),
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (context) => new exercise(
                                program_pic: prod_picture,
                                program_name: prod_name,
                            excercise_f:excercise))),
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                        ),
                        color: Colors.black45,
                        elevation: 5,
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image(
                          image: AssetImage(prod_picture),
                          fit: BoxFit.fill,
                        )
                        // Image.network(
                        //   prod_picture,
                        //   fit: BoxFit.fill,
                        // ),
                        ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0, left: 10),
                    child: Text(
                      point.toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0, left: 10, bottom: 15),
                    child: Text(
                      '${calories} Cal  |  ${duration} min',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 10,right:10,top:8),
                  //   child: LeftRightAlign(
                  //     left: Text(
                  //       'Time '+duration+' Min',
                  //       style: TextStyle(
                  //         // color: Colors.black,
                  //         // fontWeight: FontWeight.w600,
                  //         // fontSize: 40,
                  //         color: Colors.grey,
                  //         fontWeight: FontWeight.bold,
                  //         decorationThickness: vf * 0.086,
                  //         decorationColor: darkPurple,
                  //         fontSize: 16,
                  //       ),
                  //     ),
                  //     right: Text('Calories '+calories+' cal',
                  //       style: TextStyle(
                  //       // color: Colors.black,
                  //       // fontWeight: FontWeight.w600,
                  //       // fontSize: 40,
                  //       color: Colors.grey,
                  //       fontWeight: FontWeight.bold,
                  //       decorationThickness: vf * 0.086,
                  //       decorationColor: darkPurple,
                  //       fontSize: 16,
                  //     ),),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ));
  }
}
