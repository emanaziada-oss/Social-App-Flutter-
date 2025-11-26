import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialapp/models/posts_model.dart';

class FirebasePostsService {
  FirebasePostsService._();

  static final FirebasePostsService instance = FirebasePostsService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String collectionPath = "posts";

  // insert
  Future<void> addPost(PostsModel post) async{
    try{
      await _firestore
          .collection(collectionPath)
          .add(post.toJson());

    }on FirebaseException catch(e){
      rethrow;
    }
  }

  //read
  Stream <List<PostsModel>> getPosts()  {
    try {
      return _firestore
          .collection(collectionPath)
          .orderBy("timestamp", descending: true)
          .snapshots()
          .map((snapshot) =>
          snapshot.docs
              .map((doc) => PostsModel.fromJson(doc.data(),doc.id))
              .toList());
    }on FirebaseException catch(e){
      rethrow;
    }
  }
}