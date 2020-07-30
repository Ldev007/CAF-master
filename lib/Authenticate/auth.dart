import 'package:firebase_auth/firebase_auth.dart';
import '../User/user.dart';
//import 'package:leaderboard_app/services/databsae.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

// auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }
}