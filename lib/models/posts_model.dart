
import 'package:cloud_firestore/cloud_firestore.dart';

class PostsModel {
  final String id;
  final String authorName;
  final String content;
  final Timestamp? timestamp;

  const PostsModel({
    required this.id,
    required this.authorName,
    required this.content,
    this.timestamp,
  });
  // used when adding a post (no id yet — Firestore generates it)
  PostsModel.withoutId({
    required this.authorName,
    required this.content,
    this.timestamp,
  })  : id = '';

  Map<String, dynamic> toJson() {
    return {
      // 'id':id,
      'authorName': authorName,
      'content': content,
      'timestamp': timestamp ?? FieldValue.serverTimestamp(),
    };
  }

  factory PostsModel.fromJson(Map<String, dynamic> json,String id) {
    return PostsModel(
      id:id,
      authorName: json['authorName'] ?? 'Anonymous',
      content: json['content'] ?? '',
      timestamp: json['timestamp'] as Timestamp?,
    );
  }
}
