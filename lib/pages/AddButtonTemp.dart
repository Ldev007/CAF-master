import 'package:flutter/material.dart';

class AddButtonTemp extends StatelessWidget {
  void initState() {
//    print(anistart);
//    print(aniend);
    print("add");
//    hasPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.5,
      color: Colors.black54,
      child: Text('//TEMP FILE WILL BE REMOVED LATER//'),
    );
  }
}
