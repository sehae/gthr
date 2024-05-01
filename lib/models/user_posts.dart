class Post {
  final String content;
  final DateTime timestamp;
  final String? postId;

  Post({
    required this.content,
    required this.timestamp,
    this.postId,
  });
}