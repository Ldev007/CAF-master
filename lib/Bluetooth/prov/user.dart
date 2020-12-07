import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class UserProvider with ChangeNotifier{
  int cm;

  UserProvider(){
    cm=0;
  }

  int get getcm => cm;


  void setCm(int x){
    cm=x;
    notifyListeners();
  }
}