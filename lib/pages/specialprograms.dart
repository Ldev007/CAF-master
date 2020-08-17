import 'package:flutter/material.dart';
import 'exercise.dart';

class specialprograms extends StatefulWidget {
  @override
  _specialprogramsState createState() => _specialprogramsState();
}

class _specialprogramsState extends State<specialprograms> {
  var program_list = [
    {
      "name": "hii",
      "picture":
          "https://s3.envato.com/files/227435581/BEE-2064-Yoga%20Banners_01_Preview4.jpg",
    },
    {
      "name": "pilates",
      "picture": "https://images.fitpass.co.in/blog_photo_0C933E311D60906.jpg",
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
        );
      },
    ));
  }
}

class Single_product extends StatelessWidget {
  final prod_name;
  final prod_picture;

  Single_product({
    this.prod_name,
    this.prod_picture,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(0),
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: SizedBox(
              height: 180,
              child: InkWell(
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new exercise(program_pic: prod_picture,program_name:prod_name))),
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
                  child: Image.network(
                    prod_picture,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
