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