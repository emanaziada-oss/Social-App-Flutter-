//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../screen/post_details_screen.dart';
// import '../widget/comment_card.dart';
//


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialapp/models/comments_model.dart';

class FirebaseCommentService {
  FirebaseCommentService._();

  static final FirebaseCommentService instance = FirebaseCommentService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String collectionPath = "posts";
  static const String subCollectionPath = "comments";

  // insert
  Future<void> addComment(String postId , CommentModel comment) async{
    try{
      await _firestore
          .collection(collectionPath)
          .doc(postId)
          .collection(subCollectionPath)
          .add(comment.toJson());

    }on FirebaseException catch(e){
      rethrow;
    }
  }

  //read
  Stream <List<CommentModel>> getComments(String postId)  {
    try {
      return _firestore
          .collection(collectionPath)
          .doc(postId)
          .collection(subCollectionPath)
          .orderBy("timestamp", descending: true)
          .snapshots()
          .map((snapshot) =>
          snapshot.docs
              .map((doc) => CommentModel.fromJson(doc.data()))
              .toList());
    }on FirebaseException catch(e){
      rethrow;
    }
  }
}