import 'package:flutter/material.dart';

class LoginCheck extends StatelessWidget {
  bool verify = false;

  LoginCheck({bool verifier}) {
    verify = verifier;
  }

  @override
  Widget build(BuildContext context) {
    if (verify == true) {
      return MaterialApp(
        home: SafeArea(
          child: Scaffold(
            body: Text('csc'),
          ),
        ),
      );
    }
  }
}
