import 'package:cloud_firestore/cloud_firestore.dart';

class BlogModel {
  final String blogId;
  final String title;
  final String content;
  final int likes;
  final List<dynamic> likedBy;
  final List<CommentModel> comments;

  BlogModel({
    required this.blogId,
    required this.title,
    required this.content,
    required this.likes,
    required this.likedBy,
    required this.comments,
  });

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      blogId: map['blogId'],
      title: map['title'],
      content: map['content'],
      likes: map['likes'] ?? 0,
      likedBy: map['likedBy'] ?? [], // Add this line
      comments: (map['comments'] as List<dynamic>?)
          ?.map((comment) => CommentModel.fromMap(comment))
          .toList() ??
          [],
    );
  }
}

class CommentModel {
  final String userId;
  final String comment;
  final DateTime timestamp;

  CommentModel({
    required this.userId,
    required this.comment,
    required this.timestamp,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      userId: map['userId'],
      comment: map['comment'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }
}