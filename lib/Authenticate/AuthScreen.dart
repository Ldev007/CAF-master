import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ex/pages/Validate.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../User/user.dart';
import 'screens/Screen_1.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, String title}) : super(key: key);

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {

  //Single Animation controller object for controlling diff. animation's values..
  AnimationController animCont1;
  //Names animation Objects meant to be used for diff. attribs..
  Animation<Offset> offsets;
  Animation<double> size;
  Animation<double> opacity;

  @override
  void initState() {
    super.initState();

    //Animation will complete in 2.5 seconds
    animCont1 = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    //To set beginning and ending values of types other the 'Double' using 'Tween' class..
    offsets = Tween<Offset>(begin: Offset(0, 1.5), end: Offset(0, -2))
        .animate(CurvedAnimation(parent: animCont1, curve: Curves.bounceIn));
    size = Tween<double>(begin: 110.0, end: 60.0).animate(animCont1);
    opacity = Tween<double>(begin: 0.0, end: 1.0).animate(animCont1);

    //To start the animation when app opens
    animCont1.forward();
  }

  final _fireStore = Firestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  GoogleSignIn _googleSignIn = new GoogleSignIn();

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("seen",true);
  }

  Future<void> handleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = (await _auth.signInWithCredential(credential));
    _user = result.user;
    final String uid = _user.uid.toString();
    print("user");
    print(_user.uid.toString());
    print("result");
    print(result.toString());
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ScreenOne(userid: uid)));
  }

  //Method definition used for kick starting the validation process..
  void validate() {
    googleSignIn().then((onValue) {
      _fireStore.collection('users').document('auth').collection('gusers').add({
        'email': email,
        'image': imageURL,
        'name': name,
      });
    }).catchError((e) {
      print(e);
    }).then((onValue) {
      Navigator.pushNamed(context, '/first_screen');
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            right: 70,
            left: 70,
            bottom: 150,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SlideTransition(
                position: offsets,
                child: SizedBox(
                  width: size.value,
                  height: size.value,
                  child: FlutterLogo(),
                ),
              ),
              FadeTransition(
                opacity: opacity,
                child: OutlineButton(
                  highlightedBorderColor: Colors.black54,
                  splashColor: Colors.transparent,
                  onPressed: () => handleSignIn(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 18,
                      bottom: 18,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.gps_fixed,
                          color: Colors.black87,
                          size: 35,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          'Google',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 27),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              FadeTransition(
                opacity: opacity,
                child: FlatButton(
                  color: Colors.blue,
                  splashColor: Colors.transparent,
                  textColor: Colors.black54,
                  onPressed: () => print(googleSignOut()),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 18,
                      bottom: 18,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.favorite_border,
                          color: Colors.black87,
                          size: 35,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          'Facebook',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 27),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              FadeTransition(
                opacity: opacity,
                child: OutlineButton(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                  highlightedBorderColor: Colors.black54,
                  splashColor: Colors.transparent,
                  onPressed: () => null,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 18,
                      bottom: 18,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.accessibility_new,
                          color: Colors.blue,
                          size: 35,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          'Twitter',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 27),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}