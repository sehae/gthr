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

  
}
