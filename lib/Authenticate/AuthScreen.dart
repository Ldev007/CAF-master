import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ex/styling.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ex/pages/Validate.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/Screen_1.dart';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, String title}) : super(key: key);

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  //Vertical fractions
  double vf = CustomStyle.verticalFractions;

  //Single Animation controller object for controlling diff. animation's values..
  AnimationController animCont1;

  //Names animation Objects meant to be used for diff. attribs..
  Animation<Offset> offsets;
  Animation<double> animatedWidth;
  Animation<double> animatedHeight;
  Animation<double> opacity;

  //Carousel vars
  CarouselController carouselController = CarouselController();

  //Random num generator
  Random rd = Random();
  int numHolder;

  //Quotes
  // List<String> authors = [
  //   "\n- Arnold Schwarzenegger, seven-time Mr. Olympia",
  //   "\n- Henry David Thoreau, poet and philosopher",
  //   "\n- Michael John Bobak, digital artist",
  //   "\n- Bret Contreras, sports scientist",
  //   "\n- Vidal Sassoon, hairstylist and businessman",
  //   "\n- Greg Plitt, fitness model",
  //   "\n- Henry Ford, industrialist",
  //   "\n- Bruce Lee, actor and martial artist",
  //   "\n- Michael Jordan, basketball player",
  //   "\n- Pablo Picasso, visual artist"
  // ];
  // List<String> quotes = [
  //   "The last three or four reps is what makes the muscle grow. This area of pain divides a champion from someone who is not a champion",
  //   "Success usually comes to those who are too busy to be looking for it.",
  //   "All progress takes place outside the comfort zone.",
  //   "If you think lifting is dangerous, try being weak. Being weak is dangerous.",
  //   "The only place where success comes before work is in the dictionary.",
  //   "The clock is ticking. Are you becoming the person you want to be ?",
  //   "Whether you think you can, or you think you can’t, you’re right.",
  //   "The successful warrior is the average man, with laser-like focus.",
  //   "You must expect great things of yourself before you can do them.",
  //   "Action is the foundational key to all success.",
  // ];

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
    offsets = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, 5)).animate(
        CurvedAnimation(
            parent: animCont1, curve: Curves.fastLinearToSlowEaseIn));

    animatedWidth = Tween<double>(begin: 180, end: 210).animate(animCont1);
    animatedHeight = Tween<double>(begin: 550, end: 600).animate(animCont1);

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
    prefs.setBool("seen", true);
  }

  Future<void> handleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = (await _auth.signInWithCredential(credential));
    final FirebaseUser user = result.user;
    // String photourl = user.photoUrl;
    // String username = user.displayName;
    // String useremail = user.email;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("photourl", user.photoUrl);
    prefs.setString("username", user.displayName);
    prefs.setString("useremail", user.email);
    _user = result.user;
    final String uid = _user.uid.toString();
    print("user");
    print(_user.uid.toString());
    print("result");
    print(result.toString());
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ScreenOne(userid: uid)));
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
          child: Container(
            padding: EdgeInsets.only(
              left: vf * 2.566, //25
              right: vf * 2.566, //25
              top: vf * 4.62, //45
              bottom: vf * 3.08, //30
            ),
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Column(
                      children: [
                        FadeTransition(
                            opacity: opacity,
                            child: Text(
                              'Welcome to\n',
                              style: TextStyle(
                                fontSize: vf * 2.874, //28
                                fontWeight: FontWeight.bold,
                                color: CustomStyle.light_bn_color,
                              ),
                            )
                            // child: Image.asset(
                            //   'images/logo_black.png',
                            //   width: animatedWidth.value,
                            //   height: animatedWidth.value,
                            //   color: CustomStyle.light_bn_color,
                            // ),
                            ),
                        Text(
                          'CONNECT ANYTIME FITNESS',
                          style: TextStyle(
                              fontSize: vf * 2.258,
                              color: CustomStyle.light_bn_color,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Trade Winds'),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(
                              top: vf * 3.08, //30
                              right: vf * 1.026, //10
                              left: vf * 1.026, //10
                              bottom: vf * 2.566, //25
                            ),
                            margin: EdgeInsets.only(top: vf * 5.133), //50
                            color: Colors.grey[300],
                            // decoration: BoxDecoration(
                            //     color: Colors.grey[300],
                            //     borderRadius: BorderRadius.circular(12),
                            //     boxShadow: [
                            //       BoxShadow(
                            //           color: Colors.grey,
                            //           offset: Offset(6, 4),
                            //           blurRadius: 10,
                            //           spreadRadius: -3)
                            //     ]),
                            child: Center(
                                child: CarouselSlider.builder(
                              itemCount: 4,
                              itemBuilder: (context, index) => Center(
                                child: Text(
                                  'Image : ${(index + 1)}',
                                  style: TextStyle(
                                    fontSize: vf * 3.08, //30
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              options: CarouselOptions(
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 5),
                                enlargeCenterPage: true,
                              ),
                            )
                                // child: Text(
                                //   quotes[numHolder] + "\n" + authors[numHolder],
                                //   style: TextStyle(
                                //     fontSize: 19,
                                //     color: CustomStyle.light_bn_color,
                                //     fontFamily: 'Roboto-Bold.ttf',
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    // padding: EdgeInsets.only(top: 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Spacer(),
                        RaisedButton(
                          highlightElevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(vf * 1.54), //15
                          ),
                          color: Colors.grey[200],
                          padding: EdgeInsets.all(vf * 2.566), //25
                          onPressed: () => handleSignIn(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/google.png',
                                width: vf * 4.106, //40
                                height: vf * 4.106, //40
                              ),
                              Text(
                                'oogle',
                                style: TextStyle(
                                  fontSize: vf * 3.593, //35
                                  letterSpacing: vf * 0.513, //5
                                  fontWeight: FontWeight.bold,
                                  color: CustomStyle.light_bn_color,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Divider(
                          height: vf * 5.133, //50
                          color: CustomStyle.light_bn_color,
                          indent: vf * 5.133, //50
                          endIndent: vf * 5.133, //50
                          thickness: vf * 0.154, //1.5
                        ),
                        Text(
                          'By logging in our app you agree to our',
                          style: TextStyle(
                            fontSize: vf * 2.053, //20
                            fontWeight: FontWeight.w500,
                            color: CustomStyle.light_bn_color,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Terms and Conditions ',
                              style: TextStyle(
                                color: CustomStyle.light_bn_color,
                                fontWeight: FontWeight.bold,
                                fontSize: vf * 2.053, //20
                              ),
                            ),
                            Text(
                              'and ',
                              style: TextStyle(
                                fontSize: vf * 2.053, //20
                                fontWeight: FontWeight.w500,
                                color: CustomStyle.light_bn_color,
                              ),
                            ),
                            Text(
                              'Privacy Policy.',
                              style: TextStyle(
                                color: CustomStyle.light_bn_color,
                                fontWeight: FontWeight.bold,
                                fontSize: vf * 2.053, //20
                              ),
                            ),
                          ],
                        ),
                      ],
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
