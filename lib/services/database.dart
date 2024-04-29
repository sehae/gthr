import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userdataCollection = FirebaseFirestore.instance.collection('UData');

  //init user data
  Future initUserData(String email) async {
    return await userdataCollection.doc(uid).set({
      'email': email,
      'uid': uid,
    });
  }

  //update user data
  Future updateUserData(String email) async {
    return await userdataCollection.doc(uid).set({
      'email' : email,
    });
  }
}