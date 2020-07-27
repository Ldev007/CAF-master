import 'package:flutter/material.dart';

class lastused extends StatefulWidget {
  @override
  _lastusedState createState() => _lastusedState();
}

class _lastusedState extends State<lastused> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: SizedBox(
          height: 180,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(70),
                topLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
            color: Colors.black45,
            elevation: 5,
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
//                child:
            child: new Stack(children: <Widget>[
              Image.network(
                'https://s3.envato.com/files/227435581/BEE-2064-Yoga%20Banners_01_Preview4.jpg',
                fit: BoxFit.fill,
              ),
              new Positioned(
                right:10,
                bottom:8,
                child:InkWell(onTap:(){print("tapped");},
                  child:Icon(Icons.play_circle_outline, color:Colors.white ,size: 50.0),),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
