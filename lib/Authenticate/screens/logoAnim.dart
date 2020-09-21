import 'package:flutter/material.dart';
import 'package:firebase_ex/Authenticate/AuthScreen.dart';

class LogoAnim extends StatefulWidget {
  @override
  _LogoAnimState createState() => _LogoAnimState();
}

class _LogoAnimState extends State<LogoAnim> with TickerProviderStateMixin {
  AnimationController animContForLogo, animContForTxt;
  Animation<Offset> offsetsForTxt, offsetsForLogo;
  Animation<double> opacityForLogo, opacityForTxt, size;

  @override
  void initState() {
    super.initState();

    animContForLogo =
        AnimationController(duration: Duration(milliseconds: 1500), vsync: this)
          ..addListener(() {
            setState(() {});
            if (animContForLogo.isCompleted) {
              animContForTxt.forward();
            }
          });

    animContForTxt =
        AnimationController(duration: Duration(milliseconds: 1200), vsync: this)
          ..addListener(() {
            setState(() {});
            if (animContForLogo.isCompleted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            }
          });

    opacityForLogo =
        Tween<double>(begin: 0.0, end: 1.0).animate(animContForLogo);
    opacityForTxt = Tween<double>(begin: 0.0, end: 1.0).animate(animContForTxt);

    offsetsForLogo = Tween<Offset>(begin: Offset(0, -0.5), end: Offset(0, 0))
        .animate(CurvedAnimation(
            parent: animContForLogo, curve: Curves.fastLinearToSlowEaseIn));
    offsetsForTxt = Tween<Offset>(begin: Offset(0, 2), end: Offset(0, 0))
        .animate(CurvedAnimation(
            parent: animContForTxt, curve: Curves.fastLinearToSlowEaseIn));

    size = Tween<double>(begin: 330, end: 350).animate(animContForLogo);

    animContForLogo.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: opacityForLogo,
            child: SlideTransition(
              position: offsetsForLogo,
              child: Image.asset(
                'images/logo_black.png',
                width: size.value,
                height: size.value,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
