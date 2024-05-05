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