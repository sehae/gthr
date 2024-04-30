import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gthr/models/user.dart';
import 'package:gthr/models/user_list.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userdataCollection =
  FirebaseFirestore.instance.collection('UData');

  //init user data
  Future initUserData(
      String fname, String lname, String username, String bio,
      String location, String email, String base64Image, String base64CoverImage, String uni) async {
    return await userdataCollection.doc(uid).set({
      'fname': fname,
      'lname': lname,
      'username': username,
      'email': email,
      'bio': '',
      'location': '',
      'icon': '',
      'header': '',
      'uni': uni,
      'uid': uid,
    });
  }

  //update user data
  Future updateUserData(String fname, String lname, String username, String bio,
      String location, String email, String base64Image, String base64CoverImage) async {
    return await userdataCollection.doc(uid).set({
      'fname': fname,
      'lname': lname,
      'username': username,
      'bio': bio,
      'location': location,
      'icon': base64Image,
      'header': base64CoverImage,
      'email': email,
    });
  }

  // get user list from snapshot
  List<UserList> _uDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map<UserList>((doc) {
      return UserList(
          uid: uid,
          fname: doc.get('fname'),
          lname: doc.get('lname'),
          username: doc.get('username'),
          bio: doc.get('bio'),
          location: doc.get('location'),
          icon: doc.get('icon'),
          header: doc.get('header'),
          email: doc.get('email'));
    }).toList();
  }

  // get user data from document
  UserData _uDataFromDocument(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      fname: snapshot.get('fname'),
      lname: snapshot.get('lname'),
      username: snapshot.get('username'),
      bio: snapshot.get('bio') ,
      location: snapshot.get('location'),
      icon: snapshot.get('icon'),
      header: snapshot.get('header'),
      email: snapshot.get('email'),
    );
  }

  //get user list stream
  Stream<List<UserList>> get userLists {
    return userdataCollection.snapshots()
        .map((_uDataFromSnapshot));
  }

  //get user data stream
  Stream<UserData> get userData {
    return userdataCollection.doc(uid).snapshots().map(_uDataFromDocument)
        .handleError((error) {
      print('Error in userData stream: $error');
    });
  }
}
