class Post {
  final String content;
  final DateTime timestamp;
  final String? postId;
  final bool isEdited;
  final String icon;
  final String username;

  Post({
    required this.content,
    required this.timestamp,
    this.postId,
    this.isEdited = false,
    required this.icon,
    required this.username,
  });
}

class Reply {
  final String content;
  final DateTime timestamp;
  final String? postId;
  final String userId;
  final String postContent;
  final String icon;
  final String username;

  Reply({
    required this.content,
    required this.timestamp,
    this.postId,
    required this.userId,
    required this.postContent,
    required this.icon,
    required this.username,
  });
}