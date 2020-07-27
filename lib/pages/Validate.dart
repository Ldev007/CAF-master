import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn gSignin = GoogleSignIn();

String name;
String email;
String imageURL;

Future<String> googleSignIn() async {
  final GoogleSignInAccount gAccount = await gSignin.signIn();
  final GoogleSignInAuthentication gAuth = await gAccount.authentication;

  final AuthCredential gCred = GoogleAuthProvider.getCredential(
      idToken: gAuth.idToken, accessToken: gAuth.accessToken);

  final AuthResult gAuthResult = await _auth.signInWithCredential(gCred);
  final FirebaseUser usr = gAuthResult.user;

  assert(usr.email != null);
  assert(usr.displayName != null);
  assert(usr.photoUrl != null);

  name = usr.displayName;
  email = usr.email;
  imageURL = usr.photoUrl;

  final FirebaseUser currUsr = await _auth.currentUser();
  assert(usr.uid == currUsr.uid);

  return 'Login Successful !';
}

Future<String> googleSignOut() async {
  await gSignin.signOut();

  return 'Logout Successful !';
}
