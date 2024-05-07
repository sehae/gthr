import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String chatId;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime timestamp;

  Chat({
    required this.chatId,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      chatId: json['chatId'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      message: json['message'],
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

  factory Chat.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Chat(
      chatId: doc.id,
      senderId: data['senderId'],
      receiverId: data['receiverId'],
      message: data['message'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}

class GroupChat {
  final String groupId;
  final String groupName;
  final List<String> members;

  GroupChat({
    required this.groupId,
    required this.groupName,
    required this.members,
  });

  factory GroupChat.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return GroupChat(
      groupId: doc.id,
      groupName: data['groupName'] ?? 'Unnamed Group',
      members: List<String>.from(
          data['members'] ?? []), // Default to empty list if null
    );
  }
}

class Message {
  final String groupId;
  final String message;
  final String senderId;
  final DateTime timestamp;

  Message({
    required this.groupId,
    required this.message,
    required this.senderId,
    required this.timestamp,
  });

  factory Message.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Message(
      groupId: data['groupId'],
      message: data['message'] ?? '', // Default to empty if missing
      senderId: data['senderId'] ?? '', // Ensure `senderId` is provided
      timestamp: (data['timestamp'] as Timestamp)
          .toDate(), // Convert `Timestamp` to `DateTime`
    );
  }
}
