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
    {
      "name": "abs",
      "picture":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcStlRBvXZcw9y2LI1g74X1sr81j8EP0ISTI-Q&usqp=CAU",
    },
    {
      "name": "hii",
      "picture":
          "https://hips.hearstapps.com/ame-prod-menshealth-assets.s3.amazonaws.com/main/thumbs/32597/bodyweight-workout.jpg?crop=1xw:0.954653937947494xh;center,top&resize=1200:*",
    },
    {
      "name": "hii",
      "picture":
          "data:image/jpeg;base64,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",
    },
    {
      "name": "hii",
      "picture":
          "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/gettyimages-1040635130.jpg",
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
