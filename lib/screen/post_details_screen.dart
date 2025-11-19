import 'package:flutter/material.dart';

import '../services/firebase_comment_service.dart';
// Post Detail Screen - Displays comments with real-time updates
class PostDetailScreen extends StatefulWidget {
  final String postId;

  const PostDetailScreen({Key? key, required this.postId}) : super(key: key);

  @override
  State<PostDetailScreen> createState() => PostDetailScreenState();
}
