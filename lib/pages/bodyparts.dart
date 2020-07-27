import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class parts extends StatefulWidget {
  @override
  _partState createState() => _partState();
}

class _partState extends State<parts> {
  @override
  bool pres = false;

  Widget build(BuildContext context) {
    return Container(
        height: 180,
        child: Padding(
            padding: EdgeInsets.all(10),
            child:
            ListView(scrollDirection: Axis.horizontal, children: <Widget>[
              SizedBox(width: 180,
                child:GestureDetector(
                  onTap: () {
                    setState(() {
                      pres = false;
                    });
                  },
                  child: Container(
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Color(0xffb4691f9),
                        elevation: (pres) ? 50 : 10,
                        child:Image(
                          image:AssetImage('images/chest.png'),
                          fit: BoxFit.fill,
                        )
//                    CachedNetworkImage(
//                      imageUrl: 'https://lh3.googleusercontent.com/proxy/TVAClb3TAwb0VCJTYtQQlAqtmJpZ4stah8Vyu-tzxIPZvw7hkp2Fg5Jm_70V6XTU78FcunZC98k9T6OcUGGkyrM27KRL6hgZwPqP-YNhxQpptxbWwxdM',
//                      placeholder: (context, url) => new CircularProgressIndicator(backgroundColor: Colors.green,),
//                      errorWidget: (context, url, error) => new Icon(Icons.error),
//                    ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 180,
                child:GestureDetector(
                  onTap: () {
                    setState(() {
                      pres = true;
                    });
                  },
                  child: Container(
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Color(0xff1c56ac),
                        elevation: (pres) ? 50 : 10,
                        child: Image(
                          image:AssetImage('images/abs.png'),
                          fit: BoxFit.fill,
                        )
//                          CachedNetworkImage(
//                            imageUrl: 'https://lh3.googleusercontent.com/proxy/TVAClb3TAwb0VCJTYtQQlAqtmJpZ4stah8Vyu-tzxIPZvw7hkp2Fg5Jm_70V6XTU78FcunZC98k9T6OcUGGkyrM27KRL6hgZwPqP-YNhxQpptxbWwxdM',
//                            placeholder: (context, url) => new CircularProgressIndicator(),
//                            errorWidget: (context, url, error) => new Icon(Icons.error),
//                          ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 180,
                child:GestureDetector(
                  onTap: () {
                    setState(() {
                      pres = true;
                    });
                  },
                  child: Container(
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Color(0xffb4691f9),
                        elevation: (pres) ? 50 : 10,
                        child: Image(
                          image:AssetImage('images/back.png'),
                          fit: BoxFit.fill,
                        )
//                          CachedNetworkImage(
//                            imageUrl: 'https://lh3.googleusercontent.com/proxy/TVAClb3TAwb0VCJTYtQQlAqtmJpZ4stah8Vyu-tzxIPZvw7hkp2Fg5Jm_70V6XTU78FcunZC98k9T6OcUGGkyrM27KRL6hgZwPqP-YNhxQpptxbWwxdM',
//                            placeholder: (context, url) => new CircularProgressIndicator(),
//                            errorWidget: (context, url, error) => new Icon(Icons.error),
//                          ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 180,
                child:GestureDetector(
                  onTap: () {
                    setState(() {
                      pres = true;
                    });
                  },
                  child: Container(
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Color(0xffb4691f9),
                        elevation: (pres) ? 50 : 10,
                        child: Image(
                          image:AssetImage('images/arm.png'),
                          fit: BoxFit.fill,
                        )
//                          CachedNetworkImage(
//                            imageUrl: 'https://lh3.googleusercontent.com/proxy/TVAClb3TAwb0VCJTYtQQlAqtmJpZ4stah8Vyu-tzxIPZvw7hkp2Fg5Jm_70V6XTU78FcunZC98k9T6OcUGGkyrM27KRL6hgZwPqP-YNhxQpptxbWwxdM',
//                            placeholder: (context, url) => new CircularProgressIndicator(),
//                            errorWidget: (context, url, error) => new Icon(Icons.error),
//                          ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 180,
                child:GestureDetector(
                  onTap: () {
                    setState(() {
                      pres = true;
                    });
                  },
                  child: Container(
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Color(0xffb4691f9),
                        elevation: (pres) ? 50 : 10,
                        child: Image(
                          image:AssetImage('images/leg.png'),
                          fit: BoxFit.fill,
                        )
//                          CachedNetworkImage(
//                            imageUrl: 'https://lh3.googleusercontent.com/proxy/TVAClb3TAwb0VCJTYtQQlAqtmJpZ4stah8Vyu-tzxIPZvw7hkp2Fg5Jm_70V6XTU78FcunZC98k9T6OcUGGkyrM27KRL6hgZwPqP-YNhxQpptxbWwxdM',
//                            placeholder: (context, url) => new CircularProgressIndicator(),
//                            errorWidget: (context, url, error) => new Icon(Icons.error),
//                          ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 180,
                child:GestureDetector(
                  onTap: () {
                    setState(() {
                      pres = true;
                    });
                  },
                  child: Container(
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Color(0xffb4691f9),
                        elevation: (pres) ? 50 : 10,
                        child: Image(
                          image:AssetImage('images/shoulder.png'),
                          fit: BoxFit.fill,
                        )
//                          CachedNetworkImage(
//                            imageUrl: 'https://lh3.googleusercontent.com/proxy/TVAClb3TAwb0VCJTYtQQlAqtmJpZ4stah8Vyu-tzxIPZvw7hkp2Fg5Jm_70V6XTU78FcunZC98k9T6OcUGGkyrM27KRL6hgZwPqP-YNhxQpptxbWwxdM',
//                            placeholder: (context, url) => new CircularProgressIndicator(),
//                            errorWidget: (context, url, error) => new Icon(Icons.error),
//                          ),
                    ),
                  ),
                ),
              ),
            ])));
  }
}
