import 'package:firebase_ex/Bluetooth/prov/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Providers{
  static final userProvider = ChangeNotifierProvider<UserProvider>((ref){
    return UserProvider();
  });


}