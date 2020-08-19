import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ex/additional/loading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'AuthScreen.dart';
import 'package:firebase_ex/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Google_auth extends StatefulWidget {
  @override
  _Google_authState createState() => _Google_authState();
}

class _Google_authState extends State<Google_auth> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  @override
  void initState() {
    super.initState();
    print("initState");
  }

  checknewuser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final newuser = prefs.getBool('firsttimer');
    if (newuser == null) {
      prefs.setBool('firsttimer', true);
    } else {
      setState(() {
        isSignIn = newuser;
      });
    }
  }

  Future<bool> getnewuser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final newuser = prefs.getBool('firsttimer');
    setState(() {
      isSignIn = newuser;
    });
    return newuser;
  }

  changenewuser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('firsttimer', false);
    print("set to false");
  }

  GoogleSignIn _googleSignIn = new GoogleSignIn();

  _Google_authState() {
    print("Inside google auth state const\n");
    checkFirstSeen();
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new HomePage()));
    } else {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new LoginScreen()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: loading(),),
      ),
    );
  }

  bool isSignIn = false;

//  Future<void> handleSignIn() async {
//    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
//    GoogleSignInAuthentication googleSignInAuthentication =
//    await googleSignInAccount.authentication;
//
//    AuthCredential credential = GoogleAuthProvider.getCredential(
//        idToken: googleSignInAuthentication.idToken,
//        accessToken: googleSignInAuthentication.accessToken);
//
//    AuthResult result = (await _auth.signInWithCredential(credential));
//
//    _user = result.user;
//
//    setState(() {
//      isSignIn = true;
//    });
//    changenewuser();
//  }
//
//  Future<void> gooleSignout() async {
//    await _auth.signOut().then((onValue) {
//      _googleSignIn.signOut();
//      setState(() {
//        isSignIn = false;
//      });
//    });
//  }
}
