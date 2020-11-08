/* JUST SELECT THE BELOW CODE AND UNCOMMENT IT AND THE BUILD & RUN */

// import 'package:flutter/material.dart';

// class DumDum extends StatefulWidget {
//   @override
//   DumDumState createState() => DumDumState();
// }

// class DumDumState extends State<DumDum> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           height: MediaQuery.of(context).size.height,
//           child: ListView(
//             children: [
//               Stack(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
//                     height: 200,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(24),
//                       color: Color.fromRGBO(118, 81, 247, 1),
//                       boxShadow: [
//                         BoxShadow(
//                           offset: Offset(3, 3),
//                           blurRadius: 10,
//                           color: Colors.black54,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Positioned(
//                     top: 10,
//                     left: 365,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(50),
//                           topRight: Radius.circular(24)),
//                       child: Container(
//                         width: 60,
//                         height: 60,
//                         color: Color.fromRGBO(180, 180, 180, 0.42),
//                         alignment: Alignment(0.2, -0.2),
//                         child: Icon(
//                           Icons.av_timer,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Stack(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
//                     height: 200,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(24),
//                       color: Color.fromRGBO(88, 97, 247, 1),
//                       boxShadow: [
//                         BoxShadow(
//                           offset: Offset(3, 3),
//                           blurRadius: 10,
//                           color: Colors.black54,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Positioned(
//                     top: 10,
//                     left: 365,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(50),
//                           topRight: Radius.circular(24)),
//                       child: Container(
//                         width: 60,
//                         height: 60,
//                         color: Color.fromRGBO(180, 180, 180, 0.42),
//                         alignment: Alignment(0.2, -0.2),
//                         child: Icon(
//                           Icons.timelapse,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Stack(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
//                     height: 200,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(24),
//                       color: Color.fromRGBO(88, 97, 247, 1),
//                       boxShadow: [
//                         BoxShadow(
//                           offset: Offset(3, 3),
//                           blurRadius: 10,
//                           color: Colors.black54,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Positioned(
//                     top: 10,
//                     left: 365,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(50),
//                           topRight: Radius.circular(24)),
//                       child: Container(
//                         width: 60,
//                         height: 60,
//                         color: Color.fromRGBO(180, 180, 180, 0.42),
//                         alignment: Alignment(0.2, -0.2),
//                         child: Icon(
//                           Icons.run_circle,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Stack(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
//                     height: 200,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(24),
//                       color: Color.fromRGBO(88, 97, 247, 1),
//                       boxShadow: [
//                         BoxShadow(
//                           offset: Offset(3, 3),
//                           blurRadius: 10,
//                           color: Colors.black54,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Positioned(
//                     top: 10,
//                     left: 365,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(50),
//                           topRight: Radius.circular(24)),
//                       child: Container(
//                         width: 60,
//                         height: 60,
//                         color: Color.fromRGBO(180, 180, 180, 0.42),
//                         alignment: Alignment(0.2, -0.2),
//                         child: Icon(
//                           Icons.timelapse,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               // Temp(shouldPaint: shouldPaint, animeObj: animeObj),
//               // FlatButton(
//               //     onPressed: () => animeObj.value == 1
//               //         ? animeCont.reverse()
//               //         : animeCont.forward(),
//               //     child: Text("start anime")),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Temp extends StatelessWidget {
//   const Temp({
//     Key key,
//     @required this.shouldPaint,
//     @required this.animeObj,
//   }) : super(key: key);

//   final bool shouldPaint;
//   final Animation<double> animeObj;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Row(
//           children: [
//             CustomPaint(
//               child: Container(
//                 color: Colors.transparent,
//                 width: MediaQuery.of(context).size.width * 0.40,
//                 height: MediaQuery.of(context).size.height * 0.4,
//               ),
//               foregroundPainter: CircleProgressBarPaint(
//                 percentage: shouldPaint ? animeObj.value : 0.0,
//                 foregroundColor: Color.fromRGBO(1, 1, 1, 1),
//                 strokeWidth: 10,
//                 radius: 30,
//               ),
//             ),
//             CustomPaint(
//               child: Container(
//                 color: Colors.transparent,
//                 width: MediaQuery.of(context).size.width * 0.40,
//                 height: MediaQuery.of(context).size.height * 0.4,
//               ),
//               foregroundPainter: CircleProgressBarPaint(
//                 percentage: shouldPaint ? animeObj.value : 0.0,
//                 foregroundColor: Color.fromRGBO(1, 1, 1, 1),
//                 radius: 30,
//                 strokeWidth: 10,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
