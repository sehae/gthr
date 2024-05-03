class Post {
  final String content;
  final DateTime timestamp;
  final String? postId;
  final bool isEdited;

  Post({
    required this.content,
    required this.timestamp,
    this.postId,
    this.isEdited = false,
  });
}

class Reply {
  final String content;
  final DateTime timestamp;
  final String postId;
  final String userId;

  Reply({
    required this.content,
    required this.timestamp,
    required this.postId,
    required this.userId,
  });
}