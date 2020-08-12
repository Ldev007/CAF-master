import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ex/styling.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DietChart extends StatefulWidget {
  @override
  _DietChartState createState() => _DietChartState();
}

class _DietChartState extends State<DietChart> {
  _DietChartState(){
    super.initState();
    fetch();
}
  List product_list;

  @override
  Widget build(BuildContext context) {
    if (product_list==null) {
      return Text("loading");
    } else {
      return Material(
        child: GridView.builder(
          itemCount: product_list.length,
          gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Single_prod(
              prod_name: product_list[index].data['name'].toString(),
              prod_pricture: 'images/tum7.jpg',
              prod_link:product_list[index].data['link'].toString(),
              prod_price: '30',
            ),
          );
          }),
      );
    }
  }
  fetch() async{
      CollectionReference collectionReference = Firestore.instance.collection('food');
      var x = collectionReference.document();
      print("===================="+x.toString());
      collectionReference.snapshots().listen((snapshot) {
        List data;
        data = snapshot.documents;
        print(data.runtimeType);
        data.forEach((element) {
          print(element.data.toString());
        });
        print(data[0].data['name'].toString());
        setState(() {
          product_list=data;
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
                print("called");
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