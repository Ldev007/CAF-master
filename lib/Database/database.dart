import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String userid;
  final String goal;
  final String gender;
  final String age;
  final String height;
  final String weight;
  final String currentfat;
  final String targetfat;
  DatabaseService({
    this.age,this.goal,this.userid,this.gender,this.height,this.weight,this.currentfat,this.targetfat,
});

  Future updateUserData(String uid,String goal,String gender,String age,String height,String weight,String currentfat,String targetfat) async {
    Map<String,dynamic> demodata = {"User ID": uid,
      "Goal": goal,
      "Gender":gender,
      "Age":age,
      "Height":height,
      "Weight":weight,
      "CurrentFat":currentfat,
      "TargetFat": targetfat,
    };
    print("data update in data");
    CollectionReference collectionReference = Firestore.instance.collection('data');
    return await collectionReference.document('uid').setData(demodata);
  }

}