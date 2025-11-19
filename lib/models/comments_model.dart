
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String authorName;
  final String text;
  final Timestamp? timestamp;

  const CommentModel({
    required this.authorName,
    required this.text,
    this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'authorName': authorName,
      'text': text,
      'timestamp': timestamp ?? FieldValue.serverTimestamp(),
    };
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      authorName: json['authorName'] ?? 'Anonymous',
      text: json['text'] ?? '',
      timestamp: json['timestamp'] as Timestamp?,
    );
  }
}
