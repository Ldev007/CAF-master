import 'package:flutter/material.dart';
import 'routes.dart';
import 'styling.dart';
import 'pages/Screen_1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //This widget is the root of your application..
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.routes.keys.firstWhere((smthg) => Routes.routes[smthg] == (context) => ScreenOne(), orElse: () => null) ,
      routes: Routes.routes,
      title: 'Fitness',
      theme: CustomStyle.def_theme,
    );
  }
}