
import 'package:cloud_firestore/cloud_firestore.dart';

class PostsModel {
  final String authorName;
  final String content;
  final Timestamp? timestamp;

  const PostsModel({
    required this.authorName,
    required this.content,
    this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'authorName': authorName,
      'content': content,
      'timestamp': timestamp ?? FieldValue.serverTimestamp(),
    };
  }

  factory PostsModel.fromJson(Map<String, dynamic> json) {
    return PostsModel(
      authorName: json['authorName'] ?? 'Anonymous',
      content: json['content'] ?? '',
      timestamp: json['timestamp'] as Timestamp?,
    );
  }
}
