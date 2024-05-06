import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gthr/models/user.dart';
import 'package:gthr/models/user_list.dart';
import 'package:async/async.dart';
import '../models/chat_message.dart';
import '../models/user_posts.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //collection reference
  final CollectionReference userdataCollection =
      FirebaseFirestore.instance.collection('UData');

  //group chat collection reference
  final CollectionReference groupChatCollection =
      FirebaseFirestore.instance.collection('GroupChats');

  // Method to create a subcollection for both the sender and the receiver
  Future<void> createChatSubCollections(
      String senderId, String receiverId, Map<String, dynamic> userData) async {
    // Create a subcollection for the sender
    await userdataCollection
        .doc(senderId)
        .collection('chats')
        .doc(receiverId)
        .set(userData);

    // Create a subcollection for the receiver
    await userdataCollection
        .doc(receiverId)
        .collection('chats')
        .doc(senderId)
        .set(userData);
  }

  //init user data
  Future initUserData(
      String fname,
      String lname,
      String username,
      String bio,
      String location,
      String email,
      String base64Image,
      String base64CoverImage,
      String uni) async {
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
  Future updateUserData(
      String fname,
      String lname,
      String username,
      String bio,
      String location,
      String email,
      String base64Image,
      String base64CoverImage) async {
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
          uid: doc.id,
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

  /* Post and Reply Functions */
  // add user posts data
  Future<DocumentReference<Map<String, dynamic>>> addPost(Post post) async {
    return await userdataCollection.doc(uid).collection('posts').add({
      'content': post.content,
      'timestamp': post.timestamp,
    });
  }

  // add user reply data
  Future addReply(String postId, Reply reply) async {
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

  // Post data from snapshot
  List<Post> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      Timestamp timestamp = doc.get('timestamp');

      DateTime dateTime = timestamp.toDate();

      return Post(
        content: doc.get('content') ?? '',
        timestamp: dateTime,
        postId: doc.id,
        isEdited: data.containsKey('isEdited') ? data['isEdited'] : false,
      );
    }).toList();
  }

  // get replies
  Future<List<Reply>> getReplies(String postId) async {
    QuerySnapshot querySnapshot = await userdataCollection
        .doc(uid)
        .collection('posts')
        .doc(postId)
        .collection('replies')
        .get();

    return querySnapshot.docs.map((doc) {
      return Reply(
        content: doc.get('content'),
        timestamp: doc.get('timestamp').toDate(),
        postId: doc.get('postId'),
        userId: doc.get('userId'),
      );
    }).toList();
  }

  // delete post
  Future<void> deletePost(String postId) async {
    return await userdataCollection
        .doc(uid)
        .collection('posts')
        .doc(postId)
        .delete();
  }

  // edit post
  Future<void> updatePost(String postId, String newContent) async {
    return await userdataCollection
        .doc(uid)
        .collection('posts')
        .doc(postId)
        .update({
      'content': newContent,
      'isEdited': true,
    });
  }

  // Get posts stream
  Stream<List<Post>> get posts {
    return userdataCollection
        .doc(uid)
        .collection('posts')
        .snapshots()
        .map(_postListFromSnapshot);
  }
  /* End of post and reply functions */

  /* Chat and group chat functions */
  /// Group Chat
  // Method to get group chat document reference
  DocumentReference getGroupChatDocument(String groupId) {
    return groupChatCollection.doc(groupId);
  }

// Method to create a group chat
  Future<void> createGroupChat(String groupName, List<String> members) {
    return groupChatCollection.add({
      'groupName': groupName,
      'members': members,
    });
  }

// Method to add a user to a group chat
  Future<void> addUserToGroupChat(String groupId, String userId) {
    return groupChatCollection.doc(groupId).update({
      'members': FieldValue.arrayUnion([userId]),
    });
  }

// Method to send a message in a group chat
  Future<void> sendGroupMessage(String groupId, Chat message) {
    return getGroupChatDocument(groupId).collection('messages').add({
      'chatId': message.chatId,
      'senderId': message.senderId,
      'receiverId': message.receiverId,
      'message': message.message,
      'timestamp': message.timestamp,
    });
  }

// Method to get messages from a group chat
  Stream<List<Chat>> getGroupMessages(String groupId) {
    return getGroupChatDocument(groupId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Chat(
          chatId: doc.id,
          senderId: doc.get('senderId'),
          receiverId: doc.get('receiverId'),
          message: doc.get('message'),
          timestamp: doc.get('timestamp').toDate(),
        );
      }).toList();
    });
  }

  /// end of group chat

  /// chat
  // Method to get chat document reference
  DocumentReference getChatDocument(String userId, String chatId) {
    return userdataCollection.doc(userId).collection('chats').doc(chatId);
  }

  // Method to send a message
  Future<void> sendMessage(String chatId, Chat message) {
    // Add the message to the sender's subcollection
    Future<void> sendersFuture = userdataCollection
        .doc(message.senderId)
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'chatId': message.chatId,
      'senderId': message.senderId,
      'receiverId': message.receiverId,
      'message': message.message,
      'timestamp': message.timestamp,
    });

    // Add the message to the receiver's subcollection
    Future<void> receiversFuture = userdataCollection
        .doc(message.receiverId)
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'chatId': message.chatId,
      'senderId': message.senderId,
      'receiverId': message.receiverId,
      'message': message.message,
      'timestamp': message.timestamp,
    });

    // Return a Future that completes when both futures complete
    return Future.wait([sendersFuture, receiversFuture]);
  }

  // Method to get messages
  Stream<List<Chat>> getMessages(String userId, String chatId) {
    return userdataCollection
        .doc(userId)
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Chat(
          chatId: doc.id,
          senderId: doc.get('senderId'),
          receiverId: doc.get('receiverId'),
          message: doc.get('message'),
          timestamp: doc.get('timestamp').toDate(),
        );
      }).toList();
    });
  }

  /// Method to retrieve all messages from multiple chat IDs
  Stream<List<Chat>> getAllMessages(List<String> chatIds) {
    // Create a list of streams, one for each chat ID
    final List<Stream<List<Chat>>> chatStreams = chatIds.map((chatId) {
      return userdataCollection
          .doc(uid)
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('timestamp', descending: true) // Order by descending
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return Chat(
            chatId: doc.id,
            senderId: doc.get('senderId'),
            receiverId: doc.get('receiverId'),
            message: doc.get('message'),
            timestamp: doc.get('timestamp').toDate(),
          );
        }).toList();
      });
    }).toList();

    // Use StreamZip to combine the multiple chat streams into one
    return StreamZip(chatStreams).map((chatLists) {
      // Flatten the list of chat lists into a single list
      final allChats = chatLists.expand((list) => list).toList();
      // Sort by timestamp in descending order
      allChats.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return allChats;
    });
  }

  /// end of chat
  /* End of chat and group chat functions */

  /* Getters */
  // get user data from document
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

  //get user list stream
  Stream<List<UserList>> get userLists {
    return userdataCollection.snapshots().map((snapshot) {
      print('Snapshot received: ${snapshot.docs.length} documents');
      final userList = snapshot.docs.map((doc) {
        return UserList(
          uid: doc.id, // Use the document ID as the uid
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
      print('UserList: $userList');
      return userList;
    });
  }

  //get user data stream
  Stream<UserData> get userData {
    return userdataCollection
        .doc(uid)
        .snapshots()
        .map(_uDataFromDocument)
        .handleError((error) {
      print('Error in userData stream: $error');
    });
  }

  /* End of Getters */
}
