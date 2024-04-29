import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userdataCollection = FirebaseFirestore.instance.collection('UData');

  //init user data
  Future initUserData(String fname, String lname, String username, String email) async {
    return await userdataCollection.doc(uid).set({
      'fname': fname,
      'lname': lname,
      'username': username,
      'email': email,
      'uid': uid,
    });
  }

  //update user data
  Future updateUserData(String fname, String lname, String username, String bio, String location, String email) async {
    return await userdataCollection.doc(uid).set({
      'fname' : fname,
      'lname' : lname,
      'username' : username,
      'bio' : bio,
      'location' : location,
      'icon' : '',
      'header' : '',
      'email' : email,
    });
  }

  //get userstream
  Stream <QuerySnapshot> get userStream {
    return userdataCollection.snapshots();
  }
}