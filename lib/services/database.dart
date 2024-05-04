import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gthr/models/user.dart';
import 'package:gthr/models/user_list.dart';
import 'package:gthr/models/chat_message.dart';
import '../models/user_posts.dart';

class DatabaseService {
  final String? uid;
  final String? currentUserId; 
  final String? chatPartnerId; 

  DatabaseService({
    this.uid,
    this.currentUserId,
    this.chatPartnerId,
  });

  // Collection reference for user data
  final CollectionReference userdataCollection =
      FirebaseFirestore.instance.collection('UData');

  // Collection reference for chat
  CollectionReference get _chatCollection {
    if (currentUserId != null && chatPartnerId != null) {
      final chatRoomId = _getChatRoomId();
      return FirebaseFirestore.instance
          .collection('chats')
          .doc(chatRoomId)
          .collection('messages');
    } else {
      throw Exception(
          "Chat room ID requires both currentUserId and chatPartnerId");
    }
  }

  // Generate a unique chat room ID based on currentUserId and chatPartnerId
  String _getChatRoomId() {
    if (currentUserId != null && chatPartnerId != null) {
      final ids = [currentUserId!, chatPartnerId!];
      ids.sort(); // Ensure unique and consistent room ID
      return ids.join('_');
    }
    throw Exception("Unable to generate chat room ID without user IDs");
  }

  // Method to send a message to Firestore
  Future<void> sendMessage(String text) async {
    if (currentUserId == null) {
      throw Exception("currentUserId must be set to send messages");
    }

    final message = {
      'text': text,
      'timestamp': FieldValue.serverTimestamp(), // Server timestamp
      'senderId': currentUserId,
    };
    await _chatCollection.add(message); // Add message to Firestore
  }

  // Stream to get chat messages in real-time
  Stream<List<ChatMessage>> get messagesStream {
    return _chatCollection
        .orderBy('timestamp',
            descending: false) // Order by 'timestamp', in ascending order
        .snapshots() // Get real-time updates
        .map((snapshot) => snapshot.docs.map((doc) {
              // Extracting and converting the timestamp to `DateTime`
              Timestamp? firestoreTimestamp = doc.get('timestamp');
              DateTime? dateTime =
                  firestoreTimestamp?.toDate(); // Convert to `DateTime`

              // Creating `ChatMessage` with the converted `DateTime`
              return ChatMessage(
                text: doc.get('text') ?? '', // Ensuring safe retrieval of text
                timestamp: dateTime, // `DateTime` from Firestore
                senderId: doc.get('senderId') ??
                    '', // Ensuring safe retrieval of senderId
              );
            }).toList());
  }

  // Additional functionalities for user data, posts, and replies

  // Add user posts
  Future<DocumentReference<Map<String, dynamic>>> addPost(Post post) async {
    if (uid == null) {
      throw Exception("UID must be set to add a post");
    }
    return await userdataCollection.doc(uid).collection('posts').add({
      'content': post.content,
      'timestamp': post.timestamp,
    });
  }

  // Add user reply to a specific post
  Future addReply(String postId, Reply reply) async {
    if (uid == null) {
      throw Exception("UID must be set to add a reply");
    }
    return await userdataCollection
        .doc(uid)
        .collection('posts')
        .doc(postId)
        .collection('replies')
        .add({
      'content': reply.content,
      'timestamp': reply.timestamp,
      'userId': reply.userId,
    });
  }

  // Initialize user data
  Future initUserData(
      String fname,
      String lname,
      String username,
      String email,
      String bio,
      String location,
      String base64Image,
      String base64CoverImage,
      String uni) async {
    if (uid == null) {
      throw Exception("UID must be set to initialize user data");
    }
    return await userdataCollection.doc(uid).set({
      'fname': fname,
      'lname': lname,
      'username': username,
      'email': email,
      'bio': bio,
      'location': location,
      'icon': base64Image,
      'header': base64CoverImage,
      'uni': uni,
    });
  }

  // Update user data
  Future updateUserData(
      String fname,
      String lname,
      String username,
      String bio,
      String location,
      String email,
      String base64Image,
      String base64CoverImage) async {
    if (uid == null) {
      throw Exception("UID must be set to update user data");
    }
    return await userdataCollection.doc(uid).set({
      'fname': fname,
      'lname': lname,
      'username': username,
      'bio': bio,
      'location': location,
      'email': email,
      'icon': base64Image,
      'header': base64CoverImage,
    });
  }

  // Get user list from Firestore snapshot
  List<UserList> _uDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserList(
        uid: uid,
        fname: doc.get('fname'),
        lname: doc.get('lname'),
        username: doc.get('username'),
        bio: doc.get('bio'),
        location: doc.get('location'),
        icon: doc.get('icon'),
        header: doc.get('header'),
        email: doc.get('email'),
      );
    }).toList();
  }

  // Get user data from document snapshot
  UserData _uDataFromDocument(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      fname: snapshot.get('fname'),
      lname: snapshot.get('lname'),
      username: snapshot.get('username'),
      bio: snapshot.get('bio'),
      location: snapshot.get('location'),
      icon: snapshot.get('icon'),
      header: snapshot.get('header'),
      email: snapshot.get('email'),
    );
  }

  // Get user list stream
  Stream<List<UserList>> get userLists {
    return userdataCollection
        .snapshots()
        .map((snapshot) => _uDataFromSnapshot(snapshot));
  }

  // Get user data stream
  Stream<UserData> get userData {
    if (uid == null) {
      throw Exception("UID must be set to retrieve user data");
    }
    return userdataCollection.doc(uid).snapshots().map(_uDataFromDocument);
  }

  // Get posts stream
  Stream<List<Post>> get posts {
    if (uid == null) {
      throw Exception("UID must be set to retrieve posts");
    }
    return userdataCollection
        .doc(uid)
        .collection('posts')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Post(
                content: doc.get('content'),
                timestamp: doc.get('timestamp').toDate(),
                postId: doc.id,
                isEdited: doc.get('isEdited') ?? false,
              ))
          .toList();
    });
  }

  // Delete a post by its ID
  Future<void> deletePost(String postId) async {
    if (uid == null) {
      throw Exception("UID must be set to delete a post");
    }
    return userdataCollection.doc(uid).collection('posts').doc(postId).delete();
  }

  // Update or edit a post
  Future<void> updatePost(String postId, String newContent) async {
    if (uid == null) {
      throw Exception("UID must be set to edit a post");
    }
    return userdataCollection.doc(uid).collection('posts').doc(postId).update({
      'content': newContent,
      'isEdited': true,
    });
  }
}
