import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gthr/models/user.dart';
import 'package:gthr/models/user_list.dart';

import '../models/user_posts.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userdataCollection =
  FirebaseFirestore.instance.collection('UData');

  // get user posts data
  Future<DocumentReference<Map<String, dynamic>>> addPost(Post post) async{
    return await userdataCollection.doc(uid).collection('posts').add({
      'content': post.content,
      'timestamp': post.timestamp,
    });
  }

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

  // Post data from snapshot
  List<Post> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {

      Timestamp timestamp = doc.get('timestamp');

      DateTime dateTime = timestamp.toDate();

      return Post(
        content: doc.get('content') ?? '',
        timestamp: dateTime,
        postId: doc.id,
      );
    }).toList();
  }

  // delete post
  Future<void> deletePost(String postId) async {
    return await userdataCollection.doc(uid).collection('posts').doc(postId).delete();
  }

  //edit post
  Future<void> updatePost(String postId, String newContent) async {
    return await userdataCollection.doc(uid).collection('posts').doc(postId).update({
      'content': newContent,
    });
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
    return userdataCollection.snapshots().map((snapshot) {
      print('Snapshot received: ${snapshot.docs.length} documents');
      final userList = _uDataFromSnapshot(snapshot);
      print('UserList: $userList');
      return userList;
    });
  }

  //get user data stream
  Stream<UserData> get userData {
    return userdataCollection.doc(uid).snapshots().map(_uDataFromDocument)
        .handleError((error) {
      print('Error in userData stream: $error');
    });
  }

  // Get posts stream
  Stream<List<Post>> get posts {
    return userdataCollection.doc(uid).collection('posts').snapshots()
        .map(_postListFromSnapshot);
  }
}
