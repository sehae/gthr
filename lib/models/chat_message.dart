import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String text;
  final DateTime? timestamp; // Nullable for safety
  final String senderId;
  final bool isRead; // Example additional property: read status
  final String? messageId; // Optional message ID for unique identification

  ChatMessage({
    required this.text,
    required this.timestamp,
    required this.senderId,
    this.isRead = false, // Default to not read
    this.messageId, // Optional
  });

  // Convert Firestore data to ChatMessage object
  factory ChatMessage.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    // Safely retrieve and convert Firestore data to ChatMessage properties
    final text = data['text'] ?? ''; // Default to empty string if null
    final senderId = data['senderId'] ?? ''; // Ensure senderId is not null
    final timestamp = (data['timestamp'] as Timestamp?)
        ?.toDate(); // Convert Timestamp to DateTime

    // Determine if the message has been read
    final isRead = data.containsKey('isRead') ? data['isRead'] as bool : false;

    return ChatMessage(
      text: text,
      timestamp: timestamp,
      senderId: senderId,
      isRead: isRead, // Assign read status
      messageId: doc.id, // Assign message ID from Firestore document ID
    );
  }
}
